require 'test_helper'
require 'json'

class SessionFlowTestTest < ActionDispatch::IntegrationTest
  test "login timeout and meta/logged-in key test" do
    user = users('user_5')
    
    # get new session
    post '/sessions',
         params: {
           data: {
             type: 'sessions',
             attributes: {
               email: user.email,
               password: 'password' }}}.to_json,
         headers: { 'Content-Type' => 'application/vnd.api+json' }

    assert_response 201
    jdata = JSON.parse response.body
    token = jdata['data']['attributes']['token']
    refute_equal user.token, token

  end
end