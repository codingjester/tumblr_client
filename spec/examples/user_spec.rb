require 'spec_helper'

describe Tumblr::Client::User do

  let(:client) { Tumblr::Client.new }

  describe :info do

    it 'should make the request properly' do
      client.should_receive(:get).with('v2/user/info').and_return('response')
      r = client.info
      r.should == 'response'
    end

  end

  # These two are very similar
  [:following, :likes].each do |type|

    describe type do

      context 'with defaults' do

         it 'should make the reqest properly' do
           client.should_receive(:get).with("v2/user/#{type}", {
             :limit => 20,
             :offset => 0
           })
           client.send type
         end

      end

      context 'with custom limit & offset' do

         it 'should make the reqest properly' do
           client.should_receive(:get).with("v2/user/#{type}", {
             :limit => 10,
             :offset => 5
           })
           client.send type, 5, 10
         end

      end

    end

  end

end
