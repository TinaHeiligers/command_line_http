require 'httparty'
login_with_email = 'http://localhost:8080/admin/api/v1/session/loginWithEmail'
login_response = HTTParty.post(login_with_email, body: {email: 'bwayne@acme.com', password: 'password'})
session_token = login_response['sessionToken']
admin_companyId = login_response['companyId']
# puts session_token
# puts admin_companyId

#Create a new normal user
create_new_user_path = 'http://localhost:8080/admin/api/v1/user'

# puts create_new_user_path
# create_new_user_response = HTTParty.post(create_new_user_path, headers: {'Authorization': "Bearer #{session_token}"}, body: {firstName: 'Tina', lastName: 'Heiligers', email: 'tina.heiligers@tallwave.com', title: 'Developer', companyId: "#{admin_companyId}"})

# puts create_new_user_response

# Create a new admin user
create_new_admin_response = HTTParty.post(create_new_user_path, headers: {'Authorization': "Bearer #{session_token}"}, body: {firstName: 'Tina', lastName: 'Heiligers', email: 'tina.heiligers@gmail.com', title: 'Developer', companyId: "#{admin_companyId}", isAdmin: true})

puts create_new_admin_response
