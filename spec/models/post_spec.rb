# spec/models/post_spec.rb
require_relative '../spec_helper_lite'
require 'minitest/autorun'
require 'active_model'
require_relative '../../app/models/post'
require 'date'

describe Post do
  before do
    @it = Post.new
  end

  describe "#picture?" do
    it "should be true when the post has a picture URL" do
      @it.image_url = "http://example.org/foo.png"
      assert(@it.picture?)
    end

    it "should be false when the post has no picture URL" do
      @it.image_url = ""
      refute(@it.picture?)
    end
  end

  describe "#publish" do
    describe "given an invalid post" do
      before do @it.title = nil end

      it "should not add the post to the blog" do
        dont_allow(@blog).add_entry
        @it.publish
      end

      it "should return false" do
        refute(@it.publish)
      end
    end
  end

  describe "#pubdate" do
    describe "before publishing" do
      it "should be blank" do
        @it.pubdate.must_be_nil
      end
    end

    describe "after publishing" do
      before do
        @clock = stub!
        @now = DateTime.parse("2011-09-11T02:56")
        stub(@clock).now(){@now}
        @it.blog = stub!
        @it.publish(@clock)
      end
      it "should be the current time" do
        @it.pubdate.must_equal(@now)
      end
      it "should be a datetime" do
        @it.pubdate.class.must_equal(DateTime)
      end
    end
  end

  it "should support setting attributes in the initializer" do
    it = Post.new(:title => "mytitle", :body => "mybody")
    it.title.must_equal "mytitle"
    it.body.must_equal "mybody"
  end

  it "should start with blank attributes" do
    @it.title.must_be_nil
    @it.body.must_be_nil
  end

  it "should support reading and writing a title" do
    @it.title = "foo"
    @it.title.must_equal "foo"
  end

  it "should support reading and writing a post body" do
    @it.body = "foo"
    @it.body.must_equal "foo"
  end

  it "should support reading and writing a blog reference" do
    blog = Object.new
    @it.blog = blog
    @it.blog.must_equal blog
  end

  describe "#publish" do
    before do
      @blog = MiniTest::Mock.new
      @it.blog = @blog
    end

    after do
      @blog.verify
    end

    it "should add the post to the blog" do
      @blog.expect :add_entry, nil, [@it]
      @it.publish
    end
  end
end
