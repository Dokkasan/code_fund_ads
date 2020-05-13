class ApplicationComponent < ViewComponent::Base
  include Frontend::TableHelper
  delegate :current_user, :authorized_user, :true_user, to: :helpers

  def status_color(status)
    case status.to_sym
    when :archived
      "secondary"
    when :blacklisted
      "dark"
    when :paused
      "info"
    when :pending
      "warning"
    when :rejected
      "danger"
    when :unconfigured
      "warning"
    else
      "success"
    end
  end
end
