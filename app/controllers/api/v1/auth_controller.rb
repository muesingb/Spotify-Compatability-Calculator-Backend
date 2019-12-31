class Api::V1::AuthController < ApplicationController
    def spotify_request
        url = "https://accounts.spotify.com/authorize"
        query_params = {
          client_id: ENV['CLIENT_ID'],
          response_type: 'code',
          redirect_uri: 'http://localhost:3000/auth/spotify/callback',
          scope: "user-read-email 
          user-library-read 
          user-read-recently-played 
          user-follow-read 
          playlist-read-private 
          user-top-read",
         show_dialog: true
        }
        redirect_to "#{url}?#{query_params.to_query}"
      end
end
