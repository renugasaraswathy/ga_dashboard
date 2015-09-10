require 'google/api_client'
require 'date'
  module GaDashboard  	
  	class AnalyticsApi  	 
	  def initialize(app_name, app_version)
	    @client = Google::APIClient.new(
	      application_name: app_name,
	      application_version: app_version)
	  end	  

	  def difference_in_days(start_date,end_date)
    	seconds = (end_date.to_i - start_date.to_i)
    	diff = seconds / 86400;     
	  end

	  def most_popular_pages(page_starts_with,start_date,end_date)
	    authorize!
	    @client.execute(api_method: api.data.ga.get,
	      parameters: {
	        'ids'        => "ga:#{profile_id}",
	        'start-date' => start_date.strftime('%Y-%m-%d'),
	        'end-date'   => end_date.strftime('%Y-%m-%d'),
	        'dimensions' => 'ga:pagePath',
	        'metrics'    => 'ga:pageviews,ga:avgTimeOnPage',
	        'sort'       => '-ga:pageviews',
	        "filters"=>"ga:pagePath=~\/#{page_starts_with}.*",      
	        "max-results"=>"50"
	      }).data.rows
	  end

	  def users_from_cities_of_country(country,start_date,end_date)
	    authorize!
	    @client.execute(api_method: api.data.ga.get,
	      parameters: {
	        'ids'        => "ga:#{profile_id}",
	        'start-date' => start_date.strftime('%Y-%m-%d'),
	        'end-date'   => end_date.strftime('%Y-%m-%d'),
	        'dimensions' => 'ga:city',
	        'metrics'    => 'ga:users,ga:sessions,ga:avgSessionDuration',
	        'sort'       => '-ga:users',
	        'filters'=>"ga:country==#{country}",
	        "max-results" =>"10"               
	      }).data.rows
	  end

	  def users_from_countries_of_continent(continent,start_date,end_date)
	    authorize!
	    @client.execute(api_method: api.data.ga.get,
	      parameters: {
	        'ids'        => "ga:#{profile_id}",
	        'start-date' => start_date.strftime('%Y-%m-%d'),
	        'end-date'   => end_date.strftime('%Y-%m-%d'),
	        'dimensions' => 'ga:country',
	        'metrics'    => 'ga:users,ga:sessions,ga:avgSessionDuration',
	        'sort'       => '-ga:users',
	        'filters'=>"ga:continent==#{continent}",
	        "max-results" =>"10"               
	      }).data.rows
	  end


	  def users_from_countries_across_world(start_date,end_date)
	    authorize!
	    @client.execute(api_method: api.data.ga.get,
	      parameters: {
	        'ids'        => "ga:#{profile_id}",
	        'start-date' => start_date.strftime('%Y-%m-%d'),
	        'end-date'   => end_date.strftime('%Y-%m-%d'),
	        'dimensions' => 'ga:country',
	        'metrics'    => 'ga:users,ga:sessions,ga:avgSessionDuration',
	        'sort'       => '-ga:users',
	        'filters'    => 'ga:country!=(not set)',
	        "max-results" =>"10"               
	      }).data.rows
	  end

	  def users_overview(start_date,end_date,region_type,region)
	    #if start date and end date are same or difference is less than 3 days, return result with time else return results with date
	    authorize!
	    diff=self.difference_in_days(start_date,end_date)
	    if diff<=1
	      start_date.strftime("%d")==end_date.strftime("%d") ? dimension='ga:hour' : dimension='ga:date'
	    elsif diff<=31
	      dimension='ga:date'      
	    elsif diff<=365
	      dimension='ga:month'      
	    else
	      dimension='ga:year'      
	    end	    

	    if region_type=="country"
	      filter="ga:country==#{region}"
	    elsif region_type=="continent"
	      filter="ga:continent==#{region}"    
	    end
	    
	    if filter
	        data=@client.execute(api_method: api.data.ga.get,
	          parameters: {
	            'ids'        => "ga:#{profile_id}",
	            'start-date' => start_date.strftime('%Y-%m-%d'),
	            'end-date'   => end_date.strftime('%Y-%m-%d'),
	            'dimensions' => dimension,
	            'metrics'    => 'ga:users,ga:sessions',
	            'filters'     =>  filter,
	            'sort'       => dimension,
	            "max-results" =>"31"               
	          }).data.rows
	    else
	      data=@client.execute(api_method: api.data.ga.get,
	          parameters: {
	            'ids'        => "ga:#{profile_id}",
	            'start-date' => start_date.strftime('%Y-%m-%d'),
	            'end-date'   => end_date.strftime('%Y-%m-%d'),
	            'dimensions' => dimension,
	            'metrics'    => 'ga:users,ga:sessions',
	            'sort'       => dimension,
	            "max-results" =>"31"               
	          }).data.rows
	    end
	    return dimension,data
	  end  

  	#private

	  def authorize!        
	    @key = Google::APIClient::PKCS12.load_key(key_file_path, 'notasecret')	    
	    @service_account = Google::APIClient::JWTAsserter.new(
	          service_email_address,
	          ['https://www.googleapis.com/auth/analytics.readonly', 'https://www.googleapis.com/auth/prediction'],
	          @key)
	    @client.authorization = @service_account.authorize
	    @client.authorization.fetch_access_token!
	  end

	  def api
	    api_version = 'v3'
	    @client.discovered_api('analytics', api_version)
	  end

	  def profile_id; GA_PROFILE_ID; end  
  	  def service_email_address; GA_SERVICE_EMAIL_ADDRESS; end
  	  def key_file_path; PATH_TO_KEY_FILE; end
 	end
end