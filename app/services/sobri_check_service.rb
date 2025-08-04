require "ruby_llm"

class SobriCheckService
  def analyze_message(text)
    return error_response("Text cannot be empty") if text.blank?

    begin
      response = make_api_request(text)

      parse_gemini_response(response)
    rescue => e
      Rails.logger.error "Sobri Check Service Error: #{e.message}"

      error_response("Failed to analyze message. Please try again.")
    end
  end

  def configured?
    # Check if the service is healthy (e.g., API key is present)
    (
      Rails.application.credentials.google_gemini_api_key.present? || ENV["GOOGLE_GEMINI_API_KEY"].present?
    ) && !Rails.env.test?
  end

  private

  def make_api_request(text)
    prompt = build_analysis_prompt(text)
    chat   = RubyLLM.chat(model: "gemini-2.0-flash")

    chat.ask(prompt)
  end

  def build_analysis_prompt(text)
    <<~PROMPT
      You are a "Sobri Check" AI assistant that helps people determine if a message is safe to send when they might be drunk or in an emotional state. Always respond with valid JSON only.

      Analyze the following message and respond with EXACTLY this JSON format (no additional text):

      {
        "status": "safe|warning|danger",
        "message": "Brief explanation (max 100 words)",
        "suggestions": ["suggestion1", "suggestion2"],
        "confidence": 85
      }

      Status definitions:
      - "safe": Message is appropriate and unlikely to cause regret
      - "warning": Message might cause minor issues or embarrassment
      - "danger": Message could seriously damage relationships or reputation

      Consider factors like:
      - Emotional intensity
      - Potential for misunderstanding
      - Professional appropriateness
      - Relationship implications
      - Spelling/grammar quality

      Message to analyze: "#{text}"
    PROMPT
  end

  def parse_gemini_response(response)
    if response&.content
      content = response.content

      # Extract JSON from the response
      json_match = content.match(/\{.*\}/m)

      if json_match
        result = JSON.parse(json_match[0])

        validate_and_format_response(result)
      else
        fallback_response(content)
      end
    else
      error_response("No response from AI service")
    end
  rescue JSON::ParserError
    error_response("Invalid response format from AI service")
  rescue => e
    Rails.logger.error "Gemini response parsing error: #{e.message}"

    error_response("Failed to parse AI response")
  end

  def validate_and_format_response(result)
    {
      status: result["status"]&.downcase || "warning",
      message: result["message"] || "Unable to analyze message properly",
      suggestions: result["suggestions"] || [],
      confidence: result["confidence"] || 50
    }
  end

  def fallback_response(content)
    # Simple fallback analysis if JSON parsing fails
    status = if content.downcase.include?("safe")
      "safe"
    elsif content.downcase.include?("danger")
      "danger"
    else
      "warning"
    end

    {
      status: status,
      message: content.truncate(100),
      suggestions: ["Consider reviewing your message when sober"],
      confidence: 50
    }
  end

  def error_response(message)
    {
      status: "error",
      message: message,
      suggestions: ["Please try again later"],
      confidence: 0
    }
  end
end
