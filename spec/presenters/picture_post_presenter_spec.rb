# spec/presenters/picture_post_presenter_spec.rb
require_relative '../spec_helper_lite'
require_relative '../../app/presenters/picture_post_presenter'

describe PicturePostPresenter do
  before do
    @post = OpenStruct.new(
      title:   "TITLE", 
      body:    "BODY", 
      pubdate: "PUBDATE")
      @template = stub!
      @it = PicturePostPresenter.new(@post, @template)
  end

  it "delegates method calls to the post" do
    @it.title.must_equal "TITLE"
    @it.body.must_equal "BODY"
    @it.pubdate.must_equal "PUBDATE"
  end

  it "renders itself with the appropriate partial" do
    mock(@template).render(
      partial: "/posts/picture_body", locals: {post: @it}){
        "THE_HTML"
      }
      @it.render_body.must_equal "THE_HTML"
  end
end


