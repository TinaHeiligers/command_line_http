require 'httparty'
login_with_email = 'http://localhost:8080/admin/api/v1/session/loginWithEmail'
login_response = HTTParty.post(login_with_email, :body => {:email => 'test+bwayne@tallwave.com', :password => 'password'})
session_token = login_response['sessionToken']
company_id = login_response['companyId']

get_company_path = "http://localhost:8080/admin/api/v1/company/#{company_id}"

create_new_group_path = "http://localhost:8080/admin/api/v1/company/#{company_id}/group"

get_company_response = HTTParty.get(get_company_path, :headers => {'Authorization': "Bearer #{session_token}"})

admins = get_company_response['admins']
employees = get_company_response['employees']

counter = 1
if File.exist?('api_create_group_counter.txt')
  counter = File.read('api_create_group_counter.txt').to_i + 1
end
File.open('api_create_group_counter.txt', 'w') { |f| f.puts counter }

puts "admins:", admins
puts
puts "employees:", employees

create_new_group_response = HTTParty.post(create_new_group_path, :headers => {'Authorization': "Bearer #{session_token}", 'Content-Type': 'application/json'}, body: {name: "test_group_#{counter}", leads: ["#{admins[0]}"], disciples: ["#{disciples}"]}.to_json)
puts
puts "created a new group:", create_new_group_response
puts
