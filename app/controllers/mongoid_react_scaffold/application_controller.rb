module MongoidReactScaffold
  class ApplicationController < ActionController::Base
    layout "mongoid_react_scaffold/application"

    if defined? PlayAuth
      helper PlayAuth::SessionsHelper
    end
  end
end