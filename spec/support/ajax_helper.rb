module AjaxHelper
  # Need to find a proper way of checking for ajax completion without JQuery
  def wait_for_ajax
    sleep(0.5)
  end
end

RSpec.configure do |config|
  config.include AjaxHelper, type: :system
end
