require_relative '../spec_helper'

describe Tumblr::Client::Post do

  let(:client) { Tumblr::Client.new }
  let(:blog_name) { 'blogname' }
  let(:file_path) { '/path/to/the/file' }
  let(:file_data) { 'lol cats' }

  describe :photo do

    context 'when passing data different ways' do

      before do
        fakefile = OpenStruct.new :read => file_data
        File.stub(:open).with(file_path, 'rb').and_return(fakefile)
        client.should_receive(:post).once.with("v2/blog/#{blog_name}/post", {
          'data[0]' => file_data,
          :type => 'photo'
        }).and_return('post')
      end

      it 'should be able to pass data as an array of filepaths' do
        r = client.photo blog_name, :data => [file_path]
        r.should == 'post'
      end

      it 'should be able to pass data as a single filepath' do
        r = client.photo blog_name, :data => file_path
        r.should == 'post'
      end

      it 'should be able to pass an array of raw data' do
        r = client.photo blog_name, :data_raw => [file_data]
        r.should == 'post'
      end

      it 'should be able to pass raw data' do
        r = client.photo blog_name, :data_raw => file_data
        r.should == 'post'
      end

    end

    context 'when passing colliding options' do

      it 'should get an error when passing data & raw_data' do
        lambda {
          client.photo blog_name, :raw_data => 'hi', :data => 'bye'
        }.should raise_error ArgumentError
      end

    end

  end

end
