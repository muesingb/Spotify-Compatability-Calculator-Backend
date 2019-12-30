class UsersController < ApplicationController

    def index
      redirect_to '/auth/spotify'
    end

    def spotify
      @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
      # User.find_or_create_by(
      #   email: @spotify_user.email
      # )
      
      User.where(:email => @spotify_user.email).first_or_create do |user|
        user.email = @spotify_user.email
        user.display_name = @spotify_user.display_name
      end

      @spotify_user.top_artists(limit: 100, offset: 0, time_range: 'medium_term').each do |artist|
        puts artist.name
        Artist.where(:name => artist.name).first_or_create do |artist| 
          artist.name = artist.name
          artist.user_id = User.find_by(email: @spotify_user.email).id
        end
      end
      
      @spotify_user.top_tracks(limit: 100, offset: 0, time_range: 'medium_term').each do |track|
        puts track.name
        Track.where(:name => track.name).first_or_create do |track| 
          track.name = track.name
          track.user_id = User.find_by(email: @spotify_user.email).id
        end
      end
  
      # render json: {"redirect":true,"redirect_url": redirect_url}, status:200

      # success: function(data, success, xhr) {
      #   window.location.href = data.redirect_url;
      # }
  
      render "spotify"
    end
  end