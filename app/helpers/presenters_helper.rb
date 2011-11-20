# app/helpers/presenters_helper.rb
module PresentersHelper
  def present(model, template)
    # Doing a string comparison because of Rails class-reloading weirdness
    case model.class.name
    when 'Post'
     model = if model.picture?
        PicturePostPresenter.new(model, template)
      else
        TextPostPresenter.new(model, template)
      end
      LinkPresenter.new(model, template)
    else
      model
    end
  end
end
