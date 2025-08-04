    RSpec.configure do |config|
      config.before(:suite) do
        DatabaseCleaner.strategy = :transaction
        DatabaseCleaner.clean_with(:truncation)
      end

      config.around(:each) do |example|
        DatabaseCleaner.cleaning do
          example.run
        end
      end

      config.add_formatter 'Fuubar'
      config.fuubar_output_pending_results = false
    end
