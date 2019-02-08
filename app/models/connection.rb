class Connection < ApplicationRecord
    #Check if user already exists in the connection
    belongs_to :user
    def self.user_exists(current_user, current_user_has)
        exists = where(["user_id = ? AND follows = ?", current_user, current_user_has])
        if exists.empty?
            return 0
        else
            return exists[0].id
        end
    end
    def self.get_followers(current_user)
        where(["follows = ?", current_user])
    end
end
