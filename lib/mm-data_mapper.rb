require 'monkey-mailer'
require 'data_mapper'

class MailQueue
  include ::DataMapper::Resource

  property :id, Serial
  property :priority, Enum[:urgent, :normal, :low]
  property :to_email, String, :length => 255, :required => true
  property :to_name, String, :length => 255
  property :from_email, String, :length => 255, :required => true
  property :from_name, String, :length => 255
  property :subject, String, :length => 255
  property :body, Text

  has n, :attachments, :constraint => :destroy

  class Attachment
    include ::DataMapper::Resource

    property :id, Serial
    property :file_path, String, :length => 255, :required => true
    property :content_type, String, :length => 255, :required => true

    belongs_to :mail_queue
  end
end

module MonkeyMailer::Loaders
  class DataMapper

    def initialize(sources)
      ::DataMapper::Logger.new(STDOUT, 'fatal')
      raise ArgumentError, 'One of the database names must be default' unless [:default, 'default'].any? {|source| sources.include? source}
      sources.each_pair do |name, opts|
        ::DataMapper.setup(name.to_sym, opts)
      end

      ::DataMapper.finalize
    end

    def find_emails(priority, quota)
      emails = []
      MonkeyMailer.configuration.loader_options.each_key do |database|
        new_emails = ::DataMapper.repository(database.to_sym) {MailQueue.all(:priority => priority, :limit => quota)}
        quota -= new_emails.size
        emails.concat(new_emails)
      end
      emails
    end

    def delete_email(email)
      email.destroy
    end
  end
end
