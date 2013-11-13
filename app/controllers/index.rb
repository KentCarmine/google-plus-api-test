get '/' do
  erb :index
end

get '/auth' do
  oauth_redirect_url = client.auth_code.authorize_url(
      :redirect_uri => 'http://localhost:9393/oauth2callback',
      :scope => "https://www.googleapis.com/auth/plus.login"
    )

  redirect to oauth_redirect_url
end

get '/oauth2callback' do

  user_access_token = client.auth_code.get_token(params["code"],
      { :redirect_uri => 'http://localhost:9393/oauth2callback', :token_method => :post }
    )

  api_access_token = OAuth2::AccessToken.new(client("https://www.googleapis.com"), user_access_token.token)
  @user_profile = JSON.parse(api_access_token.get("plus/v1/people/me").body)

  erb :user_profile
end

get '/logout' do
  session.clear

  redirect to "https://www.google.com/accounts/Logout"
end