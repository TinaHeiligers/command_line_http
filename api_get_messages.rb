require 'httparty'
login_to_dashboard = 'http://localhost:8080/admin/api/v1/session/loginWithEmail'
login_response = HTTParty.post(login_to_dashboard, :body => {:email => 'test+bwayne@tallwave.com', :password => 'password'})
session_token = login_response['sessionToken']
company_id = login_response['companyId']

get_messages = "http://localhost:8080/admin/api/v1/messages/#{company_id}"

get_messages_response = HTTParty.get(get_messages, :headers => {'Authorization': "Bearer #{session_token}"})

puts get_messages_response
