require 'spec_helper'

describe Tumblr::Request do

  let(:client) { Tumblr::Client.new }

  describe :respond do

    [200, 201].each do |rcode|

      context "with a #{rcode} response" do

        it 'should return the meta object' do
          data = { :message => 'ohyes' }
          response = OpenStruct.new(:status => rcode, :body => { 'response' => data })
          client.respond(response).should == data
        end

      end

    end

    context 'with an error response' do

      it 'should return the meta object (merged with response)' do
        meta = { :message => 'ohno' }
        response = OpenStruct.new(:status => 401, :body => { 'meta' => meta, 'response' => { :also => 'hi' } })
        client.respond(response).should == { :message => 'ohno', :also => 'hi' }
      end

      it 'should return the meta object even when response is nil' do
        meta = { :message => 'ohno' }
        response = OpenStruct.new(:status => 401, :body => { 'meta' => meta, 'response' => nil })
        client.respond(response).should == meta
      end

    end

  end

  describe :get do

    before do
      @path = '/the/path'
      @params = { :hello => 'world' }
      client.should_receive(:get_response).once.with(@path, @params).
      and_return(OpenStruct.new({
        :status => 200,
        :body => { 'response' => 'result' }
      }))
    end

    it 'should get the response directly' do
      client.get(@path, @params).should == 'result'
    end

  end

  describe :get_redirect_url do

    context 'when redirect is found' do

      before do
        @path = '/the/path'
        @params = { :hello => 'world' }
        @redirect_url = 'redirect-to-here'
        client.should_receive(:get_response).once.with(@path, @params).
        and_return(OpenStruct.new({
          :status => 301,
          :headers => { 'Location' => @redirect_url }
        }))
      end

      it 'should return the redirect url' do
        client.get_redirect_url(@path, @params).should == @redirect_url
      end

    end

    context 'when error is encountered' do

      before do
        @path = '/the/path'
        @params = { :hello => 'world' }
        @meta = { :message => 'ohno' }
        client.should_receive(:get_response).once.with(@path, @params).
        and_return(OpenStruct.new({
          :status => 401,
          :body => { 'meta' => @meta }
        }))
      end

      it 'should return the error meta' do
        client.get_redirect_url(@path, @params).should == @meta
      end

    end

  end

end
