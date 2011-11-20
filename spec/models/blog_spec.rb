#/spec/models/blog_spec.rb

require 'minitest/autorun'
require_relative '../../app/models/blog'
require 'ostruct'

describe Blog do
  before do
    @it = Blog.new
  end
 describe "#add_entry" do
   it "should add the entry to the blog" do
     entry = Object.new
     @it.add_entry(entry)
     @it.entries.must_include(entry)
   end
 end
  it "should have no entries" do
    @it.entries.must_be_empty
  end

  describe "#new_post" do
    before do
      @new_post = OpenStruct.new
      @it.post_maker = ->{ @new_post }
    end
    it "should accept an attribute hash on behalf of the post maker" do
      post_maker = MiniTest::Mock.new
      post_maker.expect(:call, @new_post, [{:x => 42, :y => 'z'}])
      @it.post_maker = post_maker
      @it.new_post(:x => 42, :y => 'z')
      post_maker.verify
    end
    it "should return a new post" do
      @it.new_post.must_equal @new_post
    end

    it "should set the post's blog reference to itself" do
      @it.new_post.blog.must_equal(@it)
    end
  end
end
