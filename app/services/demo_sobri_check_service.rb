class DemoSobriCheckService
  # Demo service for testing without API key
  # This provides realistic responses for demonstration purposes

  def analyze_message(text)
    return error_response("Text cannot be empty") if text.blank?

    # Simple keyword-based analysis for demo
    text_lower = text.downcase

    if dangerous_keywords?(text_lower)
      {
        status: "danger",
        message: "This message contains language that could seriously damage relationships or your reputation.",
        suggestions: [
          "Wait until you're in a calmer state",
          "Consider the long-term consequences",
          "Maybe talk to a friend first"
        ],
        confidence: 0
      }
    elsif warning_keywords?(text_lower)
      {
        status: "warning",
        message: "This message might cause misunderstandings or minor issues.",
        suggestions: [
          "Review your message tomorrow morning",
          "Consider a more neutral tone",
          "Double-check for typos and clarity"
        ],
        confidence: 60
      }
    else
      {
        status: "safe",
        message: "This message appears appropriate and is likely safe to send.",
        suggestions: [],
        confidence: 95
      }
    end
  end

  private

  def dangerous_keywords?(text)
    dangerous_words = [
      "hate", "never speak", "regret", "worst", "terrible",
      "destroy", "ruin", "pathetic", "disgusting", "furious"
    ]
    dangerous_words.any? { |word| text.include?(word) }
  end

  def warning_keywords?(text)
    warning_words = [
      "drunk", "tipsy", "angry", "upset", "frustrated",
      "confused", "emotional", "crying", "wtf", "damn",
      "ignoring"
    ]

    warning_words.any? { |word| text.include?(word) } ||
      text.length > 500 || # Very long messages
      text.count("!") > 3 || # Too many exclamation marks
      (text.upcase == text && text.length > 3 && text.match?(/[A-Z]/)) # All caps with letters
  end

  def error_response(message)
    {
      status: "error",
      message: message,
      suggestions: [ "Please try again later" ],
      confidence: 0
    }
  end
end
