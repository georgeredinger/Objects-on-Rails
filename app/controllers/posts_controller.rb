# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  respond_to :html,:json
  include PresentersHelper

  def new
    @post = @blog.new_post
  end

  def create
    @post = @blog.new_post(params[:post])
    if @post.publish
      redirect_to root_path, :notice => "Post added!"
    else
      render "new"
    end
  end

  def show
    @post = present(@blog.entries[params[:id].to_i],self)
    respond_with(@post)
  end


end
 

