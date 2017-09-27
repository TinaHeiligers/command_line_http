require 'httparty'
require 'json'
login_with_email = 'http://localhost:8080/admin/api/v1/session/loginWithEmail'
login_response = HTTParty.post(login_with_email, body: {email: 'bwayne@acme.com', password: 'password'})
session_token = login_response['sessionToken']
admin_companyId = login_response['companyId']

# puts login_response
create_new_users_path = 'http://localhost:8080/admin/api/v1/users'
new_users = [{ "email": "user201@email.com","firstName": "Two","lastName": "Secondone","username": "","title": "Engineer","isAdmin": false}]
# puts new_users
create_new_users_response = HTTParty.post(create_new_users_path, headers: {'Authorization': "Bearer #{session_token}", 'Content-Type'=> "application/json"}, body: { data: new_users, companyId: admin_companyId}.to_json);
puts create_new_users_response
