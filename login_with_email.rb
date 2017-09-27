require 'httparty'
login_to_web = 'http://localhost:8080/admin/api/v1/session/loginWithEmail'
# login_response = HTTParty.post(login_to_web, body: {:email => 'bwayne@acme.com', :password => 'password'})
# puts login_response

incorrect_login_response = HTTParty.post(login_to_web, body: {:email => 'bwayne@acme.com', :password => 'duplicate'})
puts incorrect_login_response
