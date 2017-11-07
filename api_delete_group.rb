get_company_path = "http://localhost:8080/admin/api/v1/company/#{company_id}"

create_new_group_path = "http://localhost:8080/admin/api/v1/company/#{company_id}/group"

get_company_response = HTTParty.get(get_company_path, :headers => {'Authorization': "Bearer #{session_token}"})

admins = get_company_response['admins']
employees = get_company_response['employees']

counter = 1
if File.exist?('api_create_group_counter.txt')
  counter = File.read('api_create_group_counter.txt').to_i + 1
end
File.open('api_create_group_counter.txt', 'w') { |f| f.puts counter }

puts "admins:", admins
puts
puts "employees:", employees

create_new_group_response = HTTParty.post(create_new_group_path, :headers => {'Authorization': "Bearer #{session_token}", 'Content-Type': 'application/json'}, body: {name: "test_group_#{counter}", leads: ["#{admins[0]}"], disciples: ["#{disciples}"]}.to_json)
puts
puts "created a new group:", create_new_group_response
puts

delete_group_path = "http://localhost:8080/admin/api/v1/company/#{company_id}/group/#{group_id}"
delete_group_response = HTTParty.delete(delete_group_path, :headers => {'Authorization': "Bearer #{session_token}"})
