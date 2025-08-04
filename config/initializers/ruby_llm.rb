RubyLLM.configure do |config|
  # Add keys ONLY for providers you intend to use
  # config.deepseek_api_key = Rails.application.credentials.deepseek_api_key || ENV["DEEPSEEK_API_KEY"]
  config.gemini_api_key = Rails.application.credentials.google_gemini_api_key || ENV["GOOGLE_GEMINI_API_KEY"]
  # ... see Configuration guide for all options ...
end
