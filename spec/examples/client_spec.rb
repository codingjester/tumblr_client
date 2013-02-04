require 'spec_helper'

describe Tumblr::Client do

  context 'when using the generic copy' do

    before do
      @key = 'thekey'
      Tumblr.configure do |c|
        c.consumer_key = @key
      end
    end

    it 'should give new clients those credentials' do
      client = Tumblr::Client.new
      client.credentials[:consumer_key].should == @key
    end

    it 'should have it\'s own credentials' do
      Tumblr.credentials[:consumer_key].should == @key
    end

    it 'should be able to make a new client (using these credentials)' do
      Tumblr.new.should be_a(Tumblr::Client)
      Tumblr.new.credentials[:consumer_key].should == @key
    end

  end

  context 'when using custom copies of the client' do

    before do
      @client1 = Tumblr::Client.new(:consumer_key => 'key1')
      @client2 = Tumblr::Client.new(:consumer_key => 'key2')
    end

    it 'should keep them separate' do
      [
        @client1.credentials[:consumer_key],
        @client2.credentials[:consumer_key]
      ].uniq.count.should == 2
    end

  end

end
