class UsersController < ApplicationController

    def index
      @users = User.all
      render json: @users
      # redirect_to '/auth/spotify'
    end

    def show
      @user = User.find(params[:id]) 
      render json: {user: @user, artists: @user.artists, tracks: @user.tracks}
    end 

    def spotify
      @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])

      #Update the user access/refresh_tokens
        # if @spotify_user.access_token_expired?
        #   @spotify_user.refresh_access_token
        # else
        #   @user.update(
        #     access_token: auth_params["access_token"],
        #     refresh_token: auth_params["refresh_token"])
        # end
      
      #create user in DB
      User.where(:email => @spotify_user.email).first_or_create do |user|
        user.email = @spotify_user.email
        user.display_name = @spotify_user.display_name
        user.followers = @spotify_user.followers.total
        user.image = @spotify_user.images[0].url
      end

      #save users top artist in DB
      #needs differing algorithm so that when user logs in after awhile, it will have new top artists for user
      @spotify_user.top_artists(limit: 100, offset: 0, time_range: 'medium_term').each do |artist|
        # puts artist.name
        Artist.where(:name => artist.name).first_or_create do |artist| 
          artist.name = artist.name
          artist.user_id = User.find_by(email: @spotify_user.email).id
          # artist.image = artist.images
        end
      end
      
      #save users top tracks in DB
      @spotify_user.top_tracks(limit: 100, offset: 0, time_range: 'medium_term').each do |track|
        # puts track.name
        Track.where(:name => track.name).first_or_create do |track| 
          track.name = track.name
          track.user_id = User.find_by(email: @spotify_user.email).id
        end
      end      

      @user = User.find_by(email: @spotify_user.email)
      redirect_to "http://localhost:3001/user/#{@user.id}"

      # @test = @spotify_user.top_artists
      # render "spotify"
      # render json: @test
    end
  end