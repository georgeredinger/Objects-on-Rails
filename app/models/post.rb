# app/models/post.rb

class Post
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  attr_accessor :blog, :title, :body,:pubdate

  def create
    @post = @blog.new_post(params[:post])
    @post.publish
    redirect_to root_path, :notice => "Post added!"
  end

  def persisted?
    false
  end

  def initialize(attrs={})
    attrs.each do |k,v| send("#{k}=",v) end 
  end

  def publish(clock=DateTime)
    self.pubdate = clock.now
    blog.add_entry(self)
  end
end

