# app/models/post.rb

class Post
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  attr_accessor :blog, :title, :body, :image_url, :pubdate
  
  validates :title,:presence => true

  def create
    @post = @blog.new_post(params[:post])
    @post.publish
    redirect_to root_path, :notice => "Post added!"
  end

  def picture?
    image_url.present?
  end

  def persisted?
    false
  end

  def initialize(attrs={})
    attrs.each do |k,v| send("#{k}=",v) end 
  end

  def publish(clock=DateTime)
    return false unless valid?
    self.pubdate = clock.now
    blog.add_entry(self)
  end

  def self.first_before(date)
    first(conditions: ["pubdate < ?", date],
          order:      "pubdate DESC")
  end

  def self.first_after(date)
    first(conditions: ["pubdate > ?", date],
          order:      "pubdate ASC")
  end


  def prev
    self.class.first_before(pubdate)
  end

  def next
    self.class.first_after(pubdate)
  end

  def up
    THE_BLOG
  end
end

