require 'httparty'
# log an admin in to get a session token
login_with_email = 'http://localhost:8080/admin/api/v1/session/loginWithEmail'
login_response = HTTParty.post(login_with_email, body: {email: 'tstark@acme.com', password: 'password'})
session_token = login_response['sessionToken']

# find an admin user and a normal user to reset their passwords:
request_users = 'http://localhost:8080/admin/api/v1/users'
users_response = HTTParty.get(request_users, headers: {'Authorization': "Bearer #{session_token}"})
admin_user = users_response.parsed_response.detect do |user|
  user['accessLevel'] == 3
end
admin_user_email = admin_user['profile']['email']

# request password reset code for an admin
# admin_request_password_reset = 'http://localhost:8080/admin/api/v1/password/reset'
# HTTParty.post(admin_request_password_reset, body: {email: admin_user_email})
# print "enter code for #{admin_user_email}: "
# admin_reset_code = gets.chomp

# admin_reset_password = 'http://localhost:8080/admin/api/v1/password/reset/verify'
# password_reset_verify_response = HTTParty.post(admin_reset_password, body: {confirmationCode: admin_reset_code, newPassword: 'somethingarb'})
# puts password_reset_verify_response

# request password reset code for a normal user
normal_user = users_response.parsed_response.detect do |user|
  user['accessLevel'] == 1
end
normal_user_email = normal_user['profile']['email']

normal_request_password_reset = 'http://localhost:8080/admin/api/v1/password/reset'
HTTParty.post(normal_request_password_reset, body: {email: normal_user_email})
print "enter code for #{normal_user_email}: "
normal_reset_code = gets.chomp

normal_reset_password = 'http://localhost:8080/api/v1/password/reset/verify'
password_reset_verify_response = HTTParty.post(normal_reset_password, body: {confirmationCode: normal_reset_code, newPassword: 'somethingarb'})
puts password_reset_verify_response
