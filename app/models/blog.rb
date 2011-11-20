class Blog
  attr_reader :entries
  attr_writer :post_maker

  def initialize
    @entries = []
  end

  def title
    "Watching Paint Dry"
  end
  def subtitle 
    "The trusted source for drying paint news & opinion"
  end
  def add_entry(entry)
    entries << entry
  end
  def new_post(*args)
    post_maker.call(*args).tap do |p|
      p.blog = self
    end
  end
  private 
  def post_maker
    @post_maker ||= Post.public_method(:new)
  end
end
