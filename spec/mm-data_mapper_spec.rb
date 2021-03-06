require_relative 'spec_helper'

describe MailQueue do

  before :all do
    @mail_hash = {
      :from_name => 'Test example',
      :from_email => 'test@example.org',
      :to_name => 'Test recipient',
      :to_email => 'test@example.org',
      :subject => "I'm doing some test dude!",
      :body => "<html><h1>Title</h1><p>Just some text on the test email</p></html>",
      :attachments => [
        {:file_path => 'test.txt', :content_type => 'text/plain'},
        {:file_path => 'test.pdf', :content_type => 'application/pdf'}
      ]
    }
  end

  it 'should create urgent priority emails' do
    MailQueue.create(@mail_hash.merge(:priority => :urgent)).should be_true
    MailQueue.count(:priority => :urgent).should eq 1
  end

  it 'should create normal priority emails' do
    MailQueue.create(@mail_hash.merge(:priority => :normal)).should be_true
    MailQueue.count(:priority => :normal).should eq 1
  end

  it 'should create low priority emails' do
    MailQueue.create(@mail_hash.merge(:priority => :low)).should be_true
    MailQueue.count(:priority => :low).should eq 1
  end

  it 'should load mails from database and send them according to stablished quotas' do
    adapter = MonkeyMailer::TestAdapter.new
    MonkeyMailer.class_variable_set(:@@adapter, adapter)
    adapter.sent_emails.should be_empty
    20.times do |count|
      MailQueue.spawn(:priority => :urgent)
      MailQueue.spawn(:priority => :normal) if (count + 1) % 2 == 0
      MailQueue.spawn(:priority => :low) if (count + 1) % 5 == 0
    end
    MonkeyMailer.find_and_deliver
    MailQueue.count(:priority => :urgent).should eq 10
    MailQueue.count(:priority => :normal).should eq 10
    MailQueue.count(:priority => :low).should eq 4
    MonkeyMailer.find_and_deliver
    MailQueue.count(:priority => :urgent).should eq 0
    MailQueue.count(:priority => :normal).should eq 5
    MailQueue.count(:priority => :low).should eq 4
    MonkeyMailer.find_and_deliver
    MailQueue.count(:priority => :urgent).should eq 0
    MailQueue.count(:priority => :normal).should eq 5
    MailQueue.count(:priority => :low).should eq 2
  end
end