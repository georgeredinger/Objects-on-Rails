class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init_blog
 private
  def init_blog
    @blog = THE_BLOG
  end
 
end
