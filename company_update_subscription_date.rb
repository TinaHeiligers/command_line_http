require 'httparty'
require 'date'
owner_login_with_email = 'http://localhost:8080/admin/api/v1/session/loginWithEmail'
owner_login_response = HTTParty.post(owner_login_with_email, :body => {:email => 'tstark@acme.com', :password => 'password'})
session_token = owner_login_response['sessionToken']

get_companies = 'http://localhost:8080/admin/api/v1/companies'
companies = HTTParty.get(get_companies, :headers => {'Authorization': "Bearer #{session_token}"})
companyId = companies[1]['id']

update_subscription_path ="http://localhost:8080/admin/api/v1/company/#{companyId}/subscription"
new_date = Date.today().next_year
updatedCompany = HTTParty.patch(update_subscription_path, :headers => {:Authorization => "Bearer #{session_token}"}, :body => {:subscriptionEndDate => new_date})
puts updatedCompany['subscriptionEndDate']
