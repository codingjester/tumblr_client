require 'spec_helper'

describe Tumblr::Client::Blog do

  let(:blog_name) { 'seejohnrun.tumblr.com' }
  let(:consumer_key) { 'ckey' }
  let(:client) do
    Tumblr::Client.new :consumer_key => consumer_key
  end

  describe :blog_info do

    it 'should make the proper request' do
      client.should_receive(:get).once.with("v2/blog/#{blog_name}/info", {
        :api_key => consumer_key
      }).and_return 'response'
      r = client.blog_info blog_name
      r.should == 'response'
    end

  end

  # These are all just lists of posts with pagination
  [:queue, :draft, :submissions].each do |type|

    ext = type == :submissions ? 'submission' : type.to_s # annoying

    describe type do

      context 'when using parameters other than limit & offset' do

        it 'should raise an error' do
          lambda {
            client.send type, blog_name, :not => 'an option'
          }.should raise_error ArgumentError
        end

      end

      context 'with valid options' do

        it 'should construct the call properly' do
          limit = 5
          client.should_receive(:get).once.with("v2/blog/#{blog_name}/posts/#{ext}", {
            :limit => limit
          }).and_return('response')
          r = client.send type, blog_name, :limit => limit
          r.should == 'response'
        end

      end

    end

  end

end
