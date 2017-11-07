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
puts "random_company #{random_company}"
puts "random_company_id #{random_companyId}"


#Create a new normal user
# create_new_user_path = 'http://localhost:8080/admin/api/v1/user'

# puts create_new_user_path
# create_new_user_response = HTTParty.post(create_new_user_path, headers: {'Authorization': "Bearer #{session_token}"}, body: {firstName: 'Tina', lastName: 'Heiligers', email: 'tina.heiligers@tallwave.com', title: 'Developer', companyId: "#{random_companyId}"})

# puts create_new_user_response

# Create a new admin user
# create_new_admin_response = HTTParty.post(create_new_user_path, headers: {'Authorization': "Bearer #{session_token}"}, body: {firstName: 'Tina', lastName: 'Heiligers', email: 'tina.heiligers@gmail.com', title: 'Developer', companyId: "#{random_companyId}", isAdmin: true})


