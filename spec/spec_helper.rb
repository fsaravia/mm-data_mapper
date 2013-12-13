require 'mm-data_mapper'
require 'database_cleaner'

Dir[::File.join(::File.dirname(__FILE__), "support/**/*.rb")].each { |f| require f }

MonkeyMailer.configure do |config|
  config.normal_sleep = 1
  config.low_sleep = 2
  config.urgent_quota = 10
  config.normal_quota = 5
  config.low_quota = 2
  config.loader = MonkeyMailer::Loaders::DataMapper
  config.loader_options = {
    :default => {
      :adapter => 'mysql',
      :user => 'travis',
      :database => 'monkey_mailer_test'
    }
  }
end

RSpec.configure do |config|

  config.order = "random"

  config.before(:suite) do
    MonkeyMailer.loader
    DatabaseCleaner.strategy = :transaction
    DataMapper.auto_upgrade!
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end