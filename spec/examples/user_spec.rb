require 'spec_helper'

describe Tumblr::User do

  let(:client) { Tumblr::Client.new }

  describe :info do

    it 'should make the request properly' do
      client.should_receive(:get).with('v2/user/info').and_return('response')
      r = client.info
      r.should == 'response'
    end

  end

  describe :dashboard do

    context 'when using options that are not allowed' do

      it 'should raise an error' do
        lambda {
          client.dashboard :not => 'an option'
        }.should raise_error ArgumentError
      end

    end

    context 'when using valid options' do

      it 'should make the correct call' do
        client.should_receive(:get).with('v2/user/dashboard', {
          :limit => 25
        }).and_return('response')
        r = client.dashboard :limit => 25
        r.should == 'response'
      end

    end

  end

  # These two are very similar
  [:following, :likes].each do |type|

    describe type do

      context 'with defaults' do

         it 'should make the reqest properly' do
           client.should_receive(:get).with("v2/user/#{type}", {}).
           and_return('response')
           r = client.send type
           r.should == 'response'
         end

      end

      context 'with custom limit & offset' do

         it 'should make the reqest properly' do
           client.should_receive(:get).with("v2/user/#{type}", {
             :limit => 10,
             :offset => 5
           }).and_return('response')
           r = client.send type, :offset => 5, :limit => 10
           r.should == 'response'
         end

      end

    end

  end

  # Like and unlike are similar
  [:like, :unlike].each do |type|

    describe type do

      it 'should make the request properly' do
        id = 123
        reblog_key = 'hello'
        client.should_receive(:post).with("v2/user/#{type}", {
          :id => id,
          :reblog_key => reblog_key
        }).and_return('response')
        r = client.send type, id, reblog_key
        r.should == 'response'
      end

    end

  end

  # Follow and unfollow are similar
  [:follow, :unfollow].each do |type|

    describe type do

      it 'should make the request properly' do
        url = 'some url'
        client.should_receive(:post).with("v2/user/#{type}", {
          :url => url
        }).and_return('response')
        r = client.send type, url
        r.should == 'response'
      end

    end

  end

end
