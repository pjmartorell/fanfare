module ApplicationHelper
  def get_flash
    flash.delete(:timedout)
  end
end
