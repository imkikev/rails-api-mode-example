# Ruby on Rails 5 API mode Example

This code show you how to use a Rails API mode application using [JSON:API specification] (http://jsonapi.org). this example can:

	- Create a session
	- Destroy a session
	- List users featuring pagination, ordering and filtering
	- Create a user
	- Show a user
	- Update a user
	- Delete a user

## Versions

* Ruby version
	2.3.1

* Rails version
	5.0.1

* PostgreSQL	
  9.5.5

Development
--------

### Setup
1. Get the code:
 - `git clone https://github.com/kikewan1/rails-api-mode-example.git`
	

2. Install Gems	
 - bundle install

3. DB configurations	
 - rails db:create
 - rails db:migrate
 - rails db:seed

4. Listing Users
	
	- rails s

 4.1 Basic
  - Show all users by default using pagination defualt values
  - URL = http://localhost:3000/api/v1/users 

 4.2 Filtering
  - For this example I just create a filter (filter_admin scope) in User model
  - URL = http://localhost:3000/api/v1/users?admin=true


 4.3 Pagination
  - This example use "will_paginate" by default, you can set page number and total records by page, but you can't exceed total records define in user model
  - URL: http://localhost:3000/api/v1/users?admin=true&page[number]=1&page[size]=30

 4.4 Ordering 
  - Client can ordering list through any user field, to get descendance ordering only need to put (-) in query string
  - URL DESC:   http://localhost:3000/api/v1/users?admin=true&page[number]=1&page[size]=25&sort=-created_at
  - URL ASC:    http://localhost:3000/api/v1/users?admin=true&page[number]=1&page[size]=25&sort=created_at

5. Sessions
 Client need to create a token session to create, update y delete records, go to console and execute:

 - curl -H "Content-Type: application/vnd.api+json" -X POST -d '{"data": { "type": "sessions", "attributes": { "email": "john@kimpus.com", "password": "test" } }}' http://localhost:3000/sessions

 - Response: {"data":{"id":"1","type":"users","attributes":{"email":"john@kimpus.com","token":"f7SE6x78WV9D6oB8yPgSnMvw","name":"John","lastname":"Wayne"}},"meta":{"licence":"CC-0","authors":["kike"]}}

6. CRUD User (use token already created)
	
 6.1 Show user:
  - curl -H "Content-Type: application/vnd.api+json" -H "X-Api-Key: f7SE6x78WV9D6oB8yPgSnMvw" -X GET  http://localhost:3000/api/v1/users/1

 6.2 Create user:
  - curl -H "Content-Type: application/vnd.api+json" -H "X-Api-Key: f7SE6x78WV9D6oB8yPgSnMvw" -X POST -d '{"data": { "type": "users", "attributes": { "email": "info@kimpus.com", "password": "test", "name":"Enrique", "lastname":"Vargas", "password_confirmation":"test" } }}' http://localhost:3000/api/v1/users
  
 6.3 Update user:
  - Client ll' be able to change name and last name only

  - curl -H "Content-Type: application/vnd.api+json" -H "X-Api-Key: f7SE6x78WV9D6oB8yPgSnMvw" -X PUT -d '{"data": { "type": "users", "attributes": { "email": "test@yahoo.com", "name":"Kike", "lastname":"Vargas A" } }}' http://localhost:3000/api/v1/users/2
  
 6.4 Delete:
  - curl -H "Content-Type: application/vnd.api+json" -H "X-Api-Key: f7SE6x78WV9D6oB8yPgSnMvw" -X DELETE http://localhost:3000/api/v1/users/2


7. Testing
 - This example has testing scripts, to execute:
 - rails test


License
-------
 The project is available as open source under the terms of the MIT License.


Troubleshooting
-------
 Please create an [issue](https://github.com/kikewan1/rails-api-mode-example/issues).	
