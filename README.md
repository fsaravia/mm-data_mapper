[![Build Status](https://travis-ci.org/fsaravia/mm-data_mapper.png)](https://travis-ci.org/fsaravia/mm-data_mapper)

mm-data_mapper
======

## Description

`mm-data_mapper` is a plugin for [MonkeyMailer](https://github.com/fsaravia/monkey-mailer) which allows using a `DataMapper` model as the datasource.  
It requires that you configure your database settings inside MonkeyMailer.configuration.loader_options using DataMapper's configuration options:
```ruby
MonkeyMailer.configure do |config|
  config.loader = MonkeyMailer::Loaders::DataMapper
  config.loader_options = {
    :default => {
      :adapter => 'mysql',
      :user => 'monkey-mailer',
      :password => 'monkey_mailer_dev',
      :database => 'monkey_mailer_test'
    }
  }
end
```
Note that you will need to have the adapter gem installed in your system (dm-mysql-adapter in this case)

## License 
See the `UNLICENSE` file included with this gem distribution.