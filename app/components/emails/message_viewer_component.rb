class Emails::MessageViewerComponent < ApplicationComponent
  def initialize(email: nil, bold: false)
    @email = email
    @bold = bold
  end
  
  def user
    User.find_by(email: email)
  end

  private

  attr_reader :classes, :email, :bold
    
  def classes
    classes = []
    classes << "font-weight-bold" if bold
    classes.compact
  end


  def render?
    email.present?
  end
end
