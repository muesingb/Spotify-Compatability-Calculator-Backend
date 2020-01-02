class User < ApplicationRecord
    has_many :artists
    has_many :tracks

    def find_match
        2
    end

    def set_match
        User.find(self.id).update(top_match: self.find_match)
    end
end
