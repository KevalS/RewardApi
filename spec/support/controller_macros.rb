module ControllerMacros
  def login_as(user)
    access_token = Devise::JWT::TestHelpers.auth_headers({},user)

    request.headers.merge!(access_token)
  end
end

RSpec.configure do |config|
  config.include ControllerMacros, type: :controller
end