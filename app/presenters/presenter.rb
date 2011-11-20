# app/presenters/presenter.rb
require 'delegate'
class Presenter < SimpleDelegator  
  def initialize(model, template)
    @template = template
    super(model)
  end
  def to_model
    __getobj__
  end
  def class
    __getobj__.class
  end
end
