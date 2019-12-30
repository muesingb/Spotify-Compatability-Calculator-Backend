require 'rspotify/oauth'

Rails.application.config.to_prepare do
  OmniAuth::Strategies::Spotify.include SpotifyOmniauthExtension
end 

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :spotify,
#     Rails.application.credentials.spotify[:client_id],
#     Rails.application.credentials.spotify[:client_secret],
#     scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
# end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], scope: 'user-read-email user-library-read user-read-recently-played user-follow-read playlist-read-private user-top-read'
end