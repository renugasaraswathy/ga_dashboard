require 'ga_dashboard/ga_dashboard_helper'
module GaDashboard
	class Railtie < Rails::Railtie
	    initializer "ga_dashboard.ga_dashboard_helper" do
	      ActionView::Base.send :include, GaDashboardHelper
	    end
	end
end