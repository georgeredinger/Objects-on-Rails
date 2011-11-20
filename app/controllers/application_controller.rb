class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init_blog
  helper :presenters
  def url_for(*args)
    # use string matching to avoid dev-mode autoloading issues
    if args.size == 1 && args.first.class.name == 'Blog'
      root_url
    else
      super
    end
  end

private
def init_blog
  @blog = THE_BLOG
end

end
