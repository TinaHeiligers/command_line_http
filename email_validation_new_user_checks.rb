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

# Valid Email addresses
valid = ["email@domain.com","firstname.lastname@domain.com","email@subdomain.domain.com","firstname+lastname@domain.com","email@123.123.123.125","email@[123.123.123.123]","email@domain.com","1234567890@domain.com","email@domain-one.com","_______@domain.com","email@domain.name","email@domain.co.jp","firstname-lastname@domain.com"]
# create_new_user_response2 = HTTParty.post(create_new_user_path, headers: {'Authorization': "Bearer #{session_token}"}, body: {firstName: 'Tina', lastName: 'Heiligers', email: valid[6], title: 'Developer', companyId: "#{admin_companyId}", isAdmin: true})
#   puts create_new_user_response2
# puts valid.length
valid.each do |value|
  create_new_user_response2 = HTTParty.post(create_new_user_path, headers: {'Authorization': "Bearer #{session_token}"}, body: {firstName: 'Tina', lastName: 'Heiligers', email: value, title: 'Developer', companyId: "#{admin_companyId}", isAdmin: true})
  puts create_new_user_response2
  puts value
end



# Invalid Email addresses
invalid = ["plainaddress","@%^%#$@#$@#.com","@domain.com","Joe Smith <email@domain.com>","email.domain.com","email@domain@domain.com",".email@domain.com","email.@domain.com","email..email@domain.com","あいうえお@domain.com","email@domain.com (Joe Smith)","email@domain","email@-domain.com","email@domain.web","email@111.222.333.44444","email@domain..com"]

invalid.each do |value|
  puts value
  create_new_user_response1 = HTTParty.post(create_new_user_path, headers: {'Authorization': "Bearer #{session_token}"}, body: {firstName: 'Tina', lastName: 'Heiligers', email: value, title: 'Developer', companyId: "#{admin_companyId}", isAdmin: true})
  puts create_new_user_response1
end

