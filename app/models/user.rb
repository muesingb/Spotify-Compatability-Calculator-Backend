class User < ApplicationRecord
    has_many :artists
    has_many :tracks

    def access_token_expired?
        puts (Time.now - self.credentials.expires_at)
    end
end
