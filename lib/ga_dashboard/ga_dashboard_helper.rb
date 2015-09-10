require 'google_visualr'
require 'date'

module GaDashboard
	module GaDashboardHelper

    COUNTRY_CODES={"Afghanistan"=>'AF',"Aland Islands"=>'AX',"Albania"=>'AL',"Algeria"=>'DZ',"American Samoa"=>'AS',"Andorra"=>'AD',"Angola"=>'AO',"Anguilla"=>'AI',"Antarctica"=>'AQ',"Antigua and Barbuda"=>'AG',"Argentina"=>'AR',"Armenia"=>'AM',"Aruba"=>'AW',"Australia"=>'AU',"Austria"=>'AT',"Azerbaijan"=>'AZ',"Bahamas"=>'BS',"Bahrain"=>'BH',"Bangladesh"=>'BD',"Barbados"=>'BB',"Belarus"=>'BY',"Belgium"=>'BE',"Belize"=>'BZ',"Benin"=>'BJ',"Bermuda"=>'BM',"Bhutan"=>'BT',"Bolivia, Plurinational State of"=>'BO',"Bonaire, Sint Eustatius and Saba"=>'BQ',"Bosnia and Herzegovina"=>'BA',"Botswana"=>'BW',"Bouvet Island"=>'BV',"Brazil"=>'BR',"British Indian Ocean Territory"=>'IO',"Brunei Darussalam"=>'BN',"Bulgaria"=>'BG',"Burkina Faso"=>'BF',"Burundi"=>'BI',"Cambodia"=>'KH',"Cameroon"=>'CM',"Canada"=>'CA',"Cape Verde"=>'CV',"Cayman Islands"=>'KY',"Central African Republic"=>'CF',"Chad"=>'TD',"Chile"=>'CL',"China"=>'CN',"Christmas Island"=>'CX',"Cocos (Keeling) Islands"=>'CC',"Colombia"=>'CO',"Comoros"=>'KM',"Congo"=>'CG',"Congo, the Democratic Republic of the"=>'CD',"Cook Islands"=>'CK',"Costa Rica"=>'CR',"Cote d'Ivoire"=>'CI',"Croatia"=>'HR',"Cuba"=>'CU',"Curacao"=>'CW',"Cyprus"=>'CY',"Czech Republic"=>'CZ',"Denmark"=>'DK',"Djibouti"=>'DJ',"Dominica"=>'DM',"Dominican Republic"=>'DO',"Ecuador"=>'EC',"Egypt"=>'EG',"El Salvador"=>'SV',"Equatorial Guinea"=>'GQ',"Eritrea"=>'ER',"Estonia"=>'EE',"Ethiopia"=>'ET',"Falkland Islands (Malvinas)"=>'FK',"Faroe Islands"=>'FO',"Fiji"=>'FJ',"Finland"=>'FI',"France"=>'FR',"French Guiana"=>'GF',"French Polynesia"=>'PF',"French Southern Territories"=>'TF',"Gabon"=>'GA',"Gambia"=>'GM',"Georgia"=>'GE',"Germany"=>'DE',"Ghana"=>'GH',"Gibraltar"=>'GI',"Greece"=>'GR',"Greenland"=>'GL',"Grenada"=>'GD',"Guadeloupe"=>'GP',"Guam"=>'GU',"Guatemala"=>'GT',"Guernsey"=>'GG',"Guinea"=>'GN',"Guinea-Bissau"=>'GW',"Guyana"=>'GY',"Haiti"=>'HT',"Heard Island and McDonald Islands"=>'HM',"Holy See (Vatican City State)"=>'VA',"Honduras"=>'HN',"Hong Kong"=>'HK',"Hungary"=>'HU',"Iceland"=>'IS',"India"=>'IN',"Indonesia"=>'ID',"Iran, Islamic Republic of"=>'IR',"Iraq"=>'IQ',"Ireland"=>'IE',"Isle of Man"=>'IM',"Israel"=>'IL',"Italy"=>'IT',"Jamaica"=>'JM',"Japan"=>'JP',"Jersey"=>'JE',"Jordan"=>'JO',"Kazakhstan"=>'KZ',"Kenya"=>'KE',"Kiribati"=>'KI',"Korea, Democratic People's Republic of"=>'KP',"Korea, Republic of"=>'KR',"Kuwait"=>'KW',"Kyrgyzstan"=>'KG',"Lao People's Democratic Republic"=>'LA',"Latvia"=>'LV',"Lebanon"=>'LB',"Lesotho"=>'LS',"Liberia"=>'LR',"Libya"=>'LY',"Liechtenstein"=>'LI',"Lithuania"=>'LT',"Luxembourg"=>'LU',"Macao"=>'MO',"Macedonia, the Former Yugoslav Republic of"=>'MK',"Madagascar"=>'MG',"Malawi"=>'MW',"Malaysia"=>'MY',"Maldives"=>'MV',"Mali"=>'ML',"Malta"=>'MT',"Marshall Islands"=>'MH',"Martinique"=>'MQ',"Mauritania"=>'MR',"Mauritius"=>'MU',"Mayotte"=>'YT',"Mexico"=>'MX',"Micronesia, Federated States of"=>'FM',"Moldova, Republic of"=>'MD',"Monaco"=>'MC',"Mongolia"=>'MN',"Montenegro"=>'ME',"Montserrat"=>'MS',"Morocco"=>'MA',"Mozambique"=>'MZ',"Myanmar"=>'MM',"Namibia"=>'NA',"Nauru"=>'NR',"Nepal"=>'NP',"Netherlands"=>'NL',"New Caledonia"=>'NC',"New Zealand"=>'NZ',"Nicaragua"=>'NI',"Niger"=>'NE',"Nigeria"=>'NG',"Niue"=>'NU',"Norfolk Island"=>'NF',"Northern Mariana Islands"=>'MP',"Norway"=>'NO',"Oman"=>'OM',"Pakistan"=>'PK',"Palau"=>'PW',"Palestine, State of"=>'PS',"Panama"=>'PA',"Papua New Guinea"=>'PG',"Paraguay"=>'PY',"Peru"=>'PE',"Philippines"=>'PH',"Pitcairn"=>'PN',"Poland"=>'PL',"Portugal"=>'PT',"Puerto Rico"=>'PR',"Qatar"=>'QA',"Reunion"=>'RE',"Romania"=>'RO',"Russian Federation"=>'RU',"Rwanda"=>'RW',"Saint Barthelemy"=>'BL',"Saint Helena, Ascension and Tristan da Cunha"=>'SH',"Saint Kitts and Nevis"=>'KN',"Saint Lucia"=>'LC',"Saint Martin (French part)"=>'MF',"Saint Pierre and Miquelon"=>'PM',"Saint Vincent and the Grenadines"=>'VC',"Samoa"=>'WS',"San Marino"=>'SM',"Sao Tome and Principe"=>'ST',"Saudi Arabia"=>'SA',"Senegal"=>'SN',"Serbia"=>'RS',"Seychelles"=>'SC',"Sierra Leone"=>'SL',"Singapore"=>'SG',"Sint Maarten (Dutch part)"=>'SX',"Slovakia"=>'SK',"Slovenia"=>'SI',"Solomon Islands"=>'SB',"Somalia"=>'SO',"South Africa"=>'ZA',"South Georgia and the South Sandwich Islands"=>'GS',"South Sudan"=>'SS',"Spain"=>'ES',"Sri Lanka"=>'LK',"Sudan"=>'SD',"Suriname"=>'SR',"Svalbard and Jan Mayen"=>'SJ',"Swaziland"=>'SZ',"Sweden"=>'SE',"Switzerland"=>'CH',"Syrian Arab Republic"=>'SY',"Taiwan, Province of China"=>'TW',"Tajikistan"=>'TJ',"Tanzania, United Republic of"=>'TZ',"Thailand"=>'TH',"Timor-Leste"=>'TL',"Togo"=>'TG',"Tokelau"=>'TK',"Tonga"=>'TO',"Trinidad and Tobago"=>'TT',"Tunisia"=>'TN',"Turkey"=>'TR',"Turkmenistan"=>'TM',"Turks and Caicos Islands"=>'TC',"Tuvalu"=>'TV',"Uganda"=>'UG',"Ukraine"=>'UA',"United Arab Emirates"=>'AE',"United Kingdom"=>'GB',"United States"=>'US',"United States Minor Outlying Islands"=>'UM',"Uruguay"=>'UY',"Uzbekistan"=>'UZ',"Vanuatu"=>'VU',"Venezuela, Bolivarian Republic of"=>'VE',"Viet Nam"=>'VN',"Virgin Islands, British"=>'VG',"Virgin Islands, U.S."=>'VI',"Wallis and Futuna"=>'WF',"Western Sahara"=>'EH',"Yemen"=>'YE',"Zambia"=>'ZM',"Zimbabwe"=>'ZW'}
    CONTINENT_CODES ={"Africa"=>"002","Europe"=>"150","Americas"=>"019","Asia"=>"142","Oceania"=>"009"}    

		def display_most_popular_pages(ga_dashboard_api,page_starts_with,start_date,end_date,div_id,options={})
			data=ga_dashboard_api.most_popular_pages(page_starts_with,start_date,end_date)
			columns={'Pages'=>'string','PageViews'=>'number','Avg Time Spent'=>'number'}
      draw_table(columns,data,div_id,options)
  	end

    def display_users_from_cities_of_country(ga_dashboard_api,country,start_date,end_date,div_id,format="table",options={})
      data=ga_dashboard_api.users_from_cities_of_country(country,start_date,end_date)
      data_table = GoogleVisualr::DataTable.new
      if format=="table"        
        columns={'Countries'=>'string','Users'=>'number','Sessions'=>'number','Avg Session Duration'=>'number'}
        draw_table(columns,data,div_id,options)
      else
        options=options.merge({:region=>COUNTRY_CODES[country]}) unless options.has_key? :region
        options=options.merge({:displayMode=>'markers'}) unless options.has_key? :displayMode                
        columns={'Countries'=>'string','Users'=>'number'}
        draw_map(columns,data,div_id,options)
      end
    end

    def display_users_from_countries_of_continent(ga_dashboard_api,continent,start_date,end_date,div_id,format="table",options={})      
      data=ga_dashboard_api.users_from_countries_of_continent(continent,start_date,end_date)      
      if format=="table"        
        columns={'Countries'=>'string','Users'=>'number','Sessions'=>'number','Avg Session Duration'=>'number'}
        draw_table(columns,data,div_id,options)
      else
        options=options.merge({:region=>CONTINENT_CODES[continent]}) unless options.has_key? :region
        options=options.merge({:displayMode=>'markers'}) unless options.has_key? :displayMode                
        columns={'Countries'=>'string','Users'=>'number'}
        draw_map(columns,data,div_id,options)
      end      
    end

    def display_users_from_countries_across_world(ga_dashboard_api,start_date,end_date,div_id,format="table",options={})
      data=ga_dashboard_api.users_from_countries_across_world(start_date,end_date)      
      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', 'Countries')
      data_table.new_column('number', 'Users')      
      if format=="table"        
        columns={'Countries'=>'string','Users'=>'number','Sessions'=>'number','Avg Session Duration'=>'number'}
        draw_table(columns,data,div_id,options)
      else
        options=options.merge({:region=>'world'})
        options=options.merge({:displayMode=>'markers'}) unless options.has_key? :displayMode                
        columns={'Countries'=>'string','Users'=>'number'}
        draw_map(columns,data,div_id,options)
      end      
    end

    def display_users_overview(ga_dashboard_api,start_date,end_date,region_type,region,div_id,options={})
      dimension,data=ga_dashboard_api.users_overview(start_date,end_date,region_type,region)                   
      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', 'Time')
      data_table.new_column('number', 'Users')
      data_table.new_column('number', 'sessions')
      dataset=data.collect do |col|                          
        col.each_with_index.collect do |x,i|
          if i==0
            if dimension=="ga:month"
              Date::MONTHNAMES[x.to_i] 
            elsif dimension=="ga:date"
              x[6..7]+"/"+x[4..5]+"/"+x[0..3]              
            else
              x.to_s
            end
          else
            x.to_i
          end            
        end
      end
      data_table.add_rows(dataset)      
      chart = GoogleVisualr::Interactive::LineChart.new(data_table, options)      
      render_chart(chart,div_id)
    end
  		
    def draw_map(columns,data,div_id,options)
      data_table = GoogleVisualr::DataTable.new
      columns.each do |key,value|
        data_table.new_column(value, key)  
      end
      options=options.merge({:displayMode=>'markers'}) unless options.has_key? :displayMode
      dataset=data.collect do |col|                          
        col.each_with_index.collect do |x,i|
          i==0 ? x.to_s : i==1 ? x.to_i : nil          
        end.compact
      end
      data_table.add_rows(dataset)                
      render_chart(GoogleVisualr::Interactive::GeoChart.new(data_table, options),div_id)
    end
  		
    def draw_table(columns,data,div_id,options)
      data_table = GoogleVisualr::DataTable.new
      columns.each do |key,value|
        data_table.new_column(value, key)  
      end          
      dataset=data.collect do |col|                          
        col.each_with_index.collect do |x,i|
          i==0 ? x.to_s : x.to_i
        end
      end
      data_table.add_rows(dataset)
      render_chart(GoogleVisualr::Interactive::Table.new(data_table, options),div_id)  
    end    
	end
end