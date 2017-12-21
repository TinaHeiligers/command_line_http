require 'httparty'
login_to_dashboard = 'http://localhost:8080/admin/api/v1/session/loginWithEmail'
login_response = HTTParty.post(login_to_dashboard, :body => {:email => 'test+bwayne@tallwave.com', :password => 'password'})
session_token = login_response['sessionToken']
company_id = login_response['companyId']
get_company_url = "http://localhost:8080/admin/api/v1/company/#{company_id}"
get_company_response = HTTParty.get(get_company_url, headers: {'Authorization': "Bearer #{session_token}"})
company_user = get_company_response["employees"][0]["id"]

create_new_message_path = "http://localhost:8080/admin/api/v1/messages/#{company_id}/message"
create_new_message_response = HTTParty.post(create_new_message_path, :headers => {'Authorization': "Bearer #{session_token}", 'Content-Type': 'application/json'}, body: {recipients: [{recipientType: "user", id: "#{company_user}"}], companyId: login_response['companyId'], messageType: "Push", body: "A message from Ruby script", subject: "new message", scheduledDate: "2017-12-20T23:53:04.717Z", sentDate: "2017-12-20T23:53:04.717Z", messageState: "new"}.to_json)
puts create_new_message_response
