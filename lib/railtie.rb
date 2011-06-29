require 'rails960gs/view_helper'  
module Rails960gs
  
  class Railtie < Rails::Railtie
    initializer "rails960gs.view_helpers" do
      ActionView::Base.send :include, ViewHelper
    end  
    
end    
end
