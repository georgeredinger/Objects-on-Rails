# spec/helpers/presenters_helper_spec.rb
require_relative '../spec_helper_lite'
require_relative '../../app/helpers/presenters_helper'

stub_class 'PicturePostPresenter'
stub_class 'TextPostPresenter'
stub_class 'Post'

describe PresentersHelper do
  before do
    @it = Object.new
    @it.extend PresentersHelper
    @template = stub!
  end

  it "should decorate picture posts with a PicturePostPresenter" do
    post = Post.new
    stub(post).picture?{true}
    @it.present(post, @template).must_be_kind_of(PicturePostPresenter)
  end

  it "should decorate text posts with a TextPostPresenter" do
    post = Post.new
    stub(post).picture?{false}
    @it.present(post, @template).must_be_kind_of(TextPostPresenter)
  end

  it "should leave objects it doesn't know about alone" do
    model = Object.new
    @it.present(model, @template).must_be_same_as(model)
  end
end
