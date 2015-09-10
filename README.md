# GA Dashboard

This gem helps you to import Google Analytics Dashboard into your Rails application.

You can pull out the following stats from Google Analytics

1. Most Popular Pages
2. Geo Chart (Map) or Table which represents the following data for a given time period
	* Users count from various countries across the world 
	* Users count from various countries in a continent
	* Users count from various cities of a country
3. Overview of users and sessions for a given time period as line chart

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ga_dashboard'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ga_dashboard

## Usage

###Prerequisites

You need to set up the following things before using this gem.

1. Create Google Analytics account for your project, add the script with tracking code in all the view pages that you want to track.
2. Create a project at [Google Developers Console](https://code.google.com/apis/console/)
3. In Google Developers console, Select your Project -> API & auth -> Search for Analytics -> Enable API
4. Under API & auth -> Credentials -> Add Credentials -> Service Account -> Select P12 and create
5. Download the **Key file** and save it in your_project_folder/lib/keys
6. Note down the **service email address** that is created. It should be something like ‘something-long@developer.gserviceaccount.com’
7. Login into your Google Analytics account -> Admin -> User Management -> Add permission to your service email address.
8. Open [Query Explorer](https://ga-dev-tools.appspot.com/query-explorer/), select your GA account for the project. Note down the number shown after ga. (e.g., ga:xxxxxxxxxx) which is the **GA Profile ID**


###Configure your Rails application

In your Rails application, create a file 'ga_dashboard.rb' inside config/initializers with the following lines

```Ruby
GA_SERVICE_EMAIL_ADDRESS="<Your Service Email Address>"
GA_PROFILE_ID="<Ga Profile ID>"
PATH_TO_KEY_FILE="#{Rails.root}/keys/<Your key file name>"
```

###Add code to your controller (e.g., reports_controller#index)

```Ruby
@ga_dashboard_api=GaDashboard::AnalyticsApi.new("your_project_name",version_no)
```

###Add the dashboard in your views

In your view file (e.g., reports/index.html.erb) add this 

```
<script src='https://www.google.com/jsapi'></script>
```
* Create the division where you want the dashboard to be appear.
* Use any of the helper methods listed below to generate the view.


####1. Popular Pages

```Ruby
display_most_popular_pages(ga_dashboard_api,pages_starting_with,start_date,end_date,id_of_the_division)
```
#####Example:

```Ruby
<div id='popular_pages'></div>
<%= display_most_popular_pages(@ga_dashboard_api,"home",DateTime.now-2.months,DateTime.now,'popular_pages') %>
```

#####Screenshot
![ScreenShot](https://googledrive.com/host/0B-YetaqqmGclN1lzbm1KWGZCekE/popular_pages.png)

####2. Users count from various countries across the world

```Ruby
display_users_from_countries_across_world(ga_dashboard_api,start_date,end_date,id_of_the_division,format="table",options={})
```

* format can be either "table" or "map"
* options - google charts options. [Refer Google Charts Documentation](https://developers.google.com/chart/interactive/docs/customizing_charts)

#####Example: Using Map

```Ruby
<div id='world'></div>
<%= display_users_from_countries_across_world(@ga_dashboard_api,DateTime.now-2.months,DateTime.now,'world','map',{:title=>'Users Across world'}) %>
```
#####Screenshot
![ScreenShot](https://googledrive.com/host/0B-YetaqqmGclN1lzbm1KWGZCekE/world.png)

#####Example: Using Table

```Ruby
<div id='world1'></div>
<%= display_users_from_countries_across_world(@ga_dashboard_api,DateTime.now-2.months,DateTime.now,'world1','table',{:title=>'Users Across world'}) %>
```
#####Screenshot
![ScreenShot](https://googledrive.com/host/0B-YetaqqmGclN1lzbm1KWGZCekE/world_table.png)

####3. Users count from various countries in a continent
```Ruby
display_users_from_countries_of_continent(ga_dashboard_api,continent,start_date,end_date,division_id,format="table",options={})
```
*Acceptable continent names are Africa,Europe,Americas,Asia and Oceania*

#####Example: Using Map

```Ruby
<div id='continent'></div>
<%= display_users_from_countries_of_continent(@ga_dashboard_api,"Asia",DateTime.now-2.months,DateTime.now,'continent','map',{:title=>"Users from Asia"}) %>
```
#####Screenshot
![ScreenShot](https://googledrive.com/host/0B-YetaqqmGclN1lzbm1KWGZCekE/continent.png)

####4. Users count from various cities of a country
```Ruby
display_users_from_cities_of_country(ga_dashboard_api,country,start_date,end_date,id_of_the_division,format="table",options={})
```
*Acceptable country names are listed [here](../Countries.txt?raw=true)*

#####Example: Using Map

```Ruby
<div id='country'></div>
<%= display_users_from_cities_of_country(@ga_dashboard_api,"India",DateTime.now-2.months,DateTime.now,'country','map',{:title=>"Users from India"}) %>
```
#####Screenshot
![ScreenShot](https://googledrive.com/host/0B-YetaqqmGclN1lzbm1KWGZCekE/country.png)

####5. Users Overview
```Ruby
display_users_overview(ga_dashboard_api,start_date,end_date,region_type,region,div_id,options={})
```
* Region Type - Acceptable values are country or continent
* Region - continent names or countries names basis region type

#####Example: Using Map

```Ruby
<div id='users_overview1'></div>
<%= display_users_overview(@ga_dashboard_api,DateTime.now-2.months,DateTime.now,'country','India','users_overview1',{:title=>"Users Overview",:height=>'500'}) %>
```
#####Screenshot
![ScreenShot](https://googledrive.com/host/0B-YetaqqmGclN1lzbm1KWGZCekE/users_overview1.png)

```Ruby
<div id='users_overview2'></div>
<%= display_users_overview(@ga_dashboard_api,DateTime.now-1.months,DateTime.now,'country','India','users_overview2',{:title=>"Users Overview",:height=>'500'}) %>
```
#####Screenshot
![ScreenShot](https://googledrive.com/host/0B-YetaqqmGclN1lzbm1KWGZCekE/users_overview2.png)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/renugasaraswathy/ga_dashboard. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

