require 'httparty'
# log in as owner
login_with_email = 'http://localhost:8080/admin/api/v1/session/loginWithEmail'
login_response = HTTParty.post(login_with_email, body: {email: 'tstark@acme.com', password: 'password'})
session_token = login_response['sessionToken']

#  need to get a company because an owner does not have a company
get_company_url = 'http://localhost:8080/admin/api/v1/companies'
get_companies_response = HTTParty.get(get_company_url, headers: {'Authorization': "Bearer #{session_token}"})

random_companyId = get_companies_response[0]['id']
random_company = get_companies_response[0]
# puts session_token
# puts "random_company #{random_company}"
# puts "random_company_id #{random_companyId}"

create_new_user_path = 'http://localhost:8080/admin/api/v1/user'

Create a new admin user
create_new_admin_response = HTTParty.post(create_new_user_path, headers: {'Authorization': "Bearer #{session_token}"}, body: {firstName: 'Tina01', lastName: 'Heiligers', email: 'tina.heiligers+111@gmail.com', title: 'Developer01', companyId: "#{random_companyId}", isAdmin: true})

puts 'FIRST ADMIN'
puts create_new_admin_response

#  Try to create an admin using the new admin's email address
try_new_admin_response = HTTParty.post(create_new_user_path, headers: {'Authorization': "Bearer #{session_token}"}, body: {firstName: 'Tina02', lastName: 'Heiligers', email: 'tina.heiligers+111@gmail.com', title: 'Developer02', companyId: "#{random_companyId}", isAdmin: true})

puts 'SECOND ADMIN'
puts try_new_admin_response

#  Try to create a user using the new admins's email address

# Create a new normal user
create_new_user_response = HTTParty.post(create_new_user_path, headers: {'Authorization': "Bearer #{session_token}"}, body: {firstName: 'Tina', lastName: 'Heiligers', email: 'tina.heiligers+101@tallwave.com', title: 'Developer', companyId: "#{random_companyId}"})
puts 'FIRST USER'
puts create_new_user_response

try_new_user_response = HTTParty.post(create_new_user_path, headers: {'Authorization': "Bearer #{session_token}"}, body: {firstName: 'Tina', lastName: 'Heiligers', email: 'tina.heiligers+101@tallwave.com', title: 'Developer', companyId: "#{random_companyId}"})
puts 'SECOND USER'
puts try_new_user_response

#  Try to create an admin using the new user's email address
try_new_admin_response = HTTParty.post(create_new_user_path, headers: {'Authorization': "Bearer #{session_token}"}, body: {firstName: 'Tina02', lastName: 'Heiligers', email: 'tina.heiligers+111@gmail.com', title: 'Developer02', companyId: "#{random_companyId}", isAdmin: true})
puts 'NEW USER WITH EXISTING ADMIN EMAIL ADDRESS'
puts try_new_admin_response

#  Try to create an admin using the new user's email address
try_new_admin_response = HTTParty.post(create_new_user_path, headers: {'Authorization': "Bearer #{session_token}"}, body: {firstName: 'Tina02', lastName: 'Heiligers', email: 'tina.heiligers+101@tallwave.com', title: 'Developer02', companyId: "#{random_companyId}", isAdmin: true})
puts 'NEW ADMIN WITH EXISTING USER EMAIL ADDRESS'
puts try_new_admin_response

#  Try to create a user using an owner's email address
try_new_user_response = HTTParty.post(create_new_user_path, headers: {'Authorization': "Bearer #{session_token}"}, body: {firstName: 'Tina02', lastName: 'Heiligers', email: 'natalie@getlevelhead.com', title: 'Developer02', companyId: "#{random_companyId}"})
puts 'NEW USER WITH OWNER EMAIL ADDRESS'
puts try_new_user_response

#  Try to create an admin using an owner's email address
try_new_user_response = HTTParty.post(create_new_user_path, headers: {'Authorization': "Bearer #{session_token}"}, body: {firstName: 'Tina02', lastName: 'Heiligers', email: 'natalie@getlevelhead.com', title: 'Developer02', companyId: "#{random_companyId}", isAdmin: true})
puts 'NEW USER WITH OWNER EMAIL ADDRESS'
puts try_new_user_response
