require 'httparty'
login_to_mobile = 'http://localhost:8080/api/v1/session'
login_response = HTTParty.post(login_to_mobile, body: {email: 'test+bwayne@tallwave.com', password: 'password'})
session_token = login_response['sessionToken']
admin_companyId = login_response['companyId']

get_users_path = 'http://localhost:8080/api/v1/users'
get_users_response = HTTParty.get(get_users_path, headers: {'Authorization': "Bearer #{session_token}"})
# puts get_users_response
userId = get_users_response[0]["id"]

get_user_path = "http://localhost:8080/api/v1/user/#{userId}"
get_user_response = HTTParty.get(get_user_path, headers: {'Authorization': "Bearer #{session_token}"})
puts get_user_response
