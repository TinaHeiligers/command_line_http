require 'httparty';
# first log in as an admin
login_with_email = 'http://localhost:8080/admin/api/v1/session/loginWithEmail'
login_response = HTTParty.post(login_with_email, body: {email: 'test+bwayne@tallwave.com', password: 'password'})
session_token = login_response['sessionToken']
admin_companyId = login_response['companyId']
# create some users
create_new_users_path = 'http://localhost:8080/admin/api/v1/users'
new_users = [{"email": "tina.heiligers+105@gmail.com", "firstName": "Tina", "lastName": "Heiligers", "title": "USER103", "isAdmin": false},
  {"email": "tina.heiligers+106@tallwave.com", "firstName": "Tina", "lastName": "Heiligers", "title": "ADMIN204", "isAdmin": true}]
#  send request
create_new_users_response = HTTParty.post(create_new_users_path, headers: {'Authorization': "Bearer #{session_token}", 'Content-Type': "application/json"}, body: { data: new_users, companyId: admin_companyId}.to_json)

# create a group
create_new_group_path = 'http://localhost:8080/admin/api/v1/'
puts create_new_users_response
