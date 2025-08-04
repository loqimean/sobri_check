# Sobri Check 🤖

An AI-powered message safety checker that helps you determine if a message is safe to send, especially useful when emotions run high or when you've had a few drinks.

## Features

- 🧠 **AI-Powered Analysis**: Uses DeepSeek AI to analyze message content, tone, and potential consequences
- 🛡️ **Relationship Protection**: Helps prevent messages that could damage personal or professional relationships
- ⚡ **Instant Feedback**: Get immediate analysis with confidence scores and helpful suggestions
- 🎨 **Beautiful UI**: Medium-style interface with Tailwind CSS
- 📱 **Responsive Design**: Works perfectly on desktop and mobile devices

## Safety Levels

- 🟢 **Safe**: Message is appropriate and unlikely to cause regret
- 🟡 **Warning**: Message might cause minor issues or embarrassment
- 🔴 **Danger**: Message could seriously damage relationships or reputation

## Setup

1. Clone the repository
2. Install dependencies:

   ```bash
   bundle install
   ```
3. Set up your DeepSeek API key:

   - Get an API key from AI what you prefer
   - Add it to Rails credentials:

     ```bash
     rails credentials:edit
     ```

     Then add, for example:

     ```yaml
     deepseek_api_key: your_api_key_here
     ```
   - Or set as environment variable:

     ```bash
     export DEEPSEEK_API_KEY=your_api_key_here
     ```
4. Start the development server:

   ```bash
   rails server
   ```
5. Visit `http://localhost:3000`

## How It Works

1. Enter your message in the text area
2. Click "🔍 Check with AI"
3. The AI analyzes your message considering:
   - Emotional intensity
   - Potential for misunderstanding
   - Professional appropriateness
   - Relationship implications
   - Spelling/grammar quality
4. Get instant feedback with suggestions

## Tech Stack

- **Backend**: Ruby on Rails 8.0
- **Frontend**: Tailwind CSS
- **AI**: Google Gemini API (RubyLLM gem with a lot of AI models)
- **Database**: PostgreSQL
- **Deployment**: Docker ready

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Disclaimer

Sobri Check is an AI assistant designed to help you make better communication decisions. It's not a substitute for your own judgment. Always consider your specific situation and relationships.

## License

This project is licensed under the MIT License.
