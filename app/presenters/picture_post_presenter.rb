# app/presenters/picture_post_presenter.rb
 require_relative 'presenter'

 class PicturePostPresenter < SimpleDelegator
   def initialize(model, template)
     @template = template
     super(model)
   end
   def render_body
     @template.render(partial: "/posts/picture_body", locals: {post: self})
   end
 end

