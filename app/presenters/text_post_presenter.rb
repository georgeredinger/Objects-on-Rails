# presenters/text_post_presenter.rb
require 'delegate'
class TextPostPresenter < SimpleDelegator
  def initialize(model, template)
    @template = template
    super(model)
  end

  def render_body
    @template.render(partial: "/posts/text_body", locals: {post: self})
  end
end
