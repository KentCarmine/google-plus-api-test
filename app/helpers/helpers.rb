helpers do
  def client(site="https://accounts.google.com")
    OAuth2::Client.new(
      ENV['GOOGLE_CLIENT_ID'],
      ENV['GOOGLE_CLIENT_SECRET'],
      :site => site,
      :token_url => '/o/oauth2/token',
      :authorize_url => '/o/oauth2/auth'
      )
  end
end