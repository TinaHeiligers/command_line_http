require 'httparty'
login_to_dashboard = 'http://localhost:8080/admin/api/v1/session/loginWithEmail'
login_response = HTTParty.post(login_to_dashboard, :body => {:email => 'bwayne@acme.com', :password => 'password'})
session_token = login_response['sessionToken']
company_id = login_response['companyId']

get_groups = "http://localhost:8080/admin/api/v1/company/#{company_id}/groups"

get_groups_response = HTTParty.get(get_groups, :headers => {'Authorization': "Bearer #{session_token}"})

puts get_groups_response

