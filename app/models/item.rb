class Item < ApplicationRecord
    has_one_attached :image
    validates :description, :category_id, presence: true
    belongs_to :user
    belongs_to :category
    has_one :active_item

    self.per_page = 6

    
def self.search(search, category, user_id)
    #Get search result based on availavility of the items and user-entered keywords and category

    #If user is not logged in
    if user_id.nil?
        if search && category
            if search.empty?
                if !category.empty?
                    Item.where(["category_id = ? AND taken = ? AND Available = ?", category, false, true])
                else
                    Item.where(["TAKEN = ? AND Available = ?", false, true])
                end
  
            else
                if !category.empty?
                    Item.where(["description LIKE ? AND category_id = ? AND taken = ? AND Available = ?", "%#{search}%", category, false, true])
                else
                    Item.where(["description LIKE ? AND taken = ? AND Available = ?", "%#{search}%", false, true])
                end
            end
        elsif search
            Item.where(["description LIKE ? AND TAKEN = ? AND Available = ?", "%#{search}%", false, true])
        else
            Item.where(["TAKEN = ? AND Available = ?", false, true])
        end

    #If user is logged in, do not get user's own item
    else
        if search && category
            if search.empty?
                if !category.empty?
                    Item.where(["category_id = ? AND taken = ? AND user_id != ? AND Available = ?", category, false, user_id, true])
                else
                    Item.where(["TAKEN = ? AND user_id != ? AND Available = ?", false, user_id, true])
                end
  
            else
                if !category.empty?
                    Item.where(["description LIKE ? AND category_id = ? AND taken = ? AND user_id != ? AND Available = ?", "%#{search}%", category, false, user_id, true])
                else
                    Item.where(["description LIKE ? AND taken = ? AND user_id != ? AND Available = ?", "%#{search}%", false, user_id, true])
                end
            end
        elsif search
            Item.where(["description LIKE ? AND TAKEN = ? AND user_id != ? AND Available = ?", "%#{search}%", false, user_id, true])
        else
            Item.where(["TAKEN = ? AND user_id != ? AND Available = ?", false, user_id, true])
        end
  
    end
  end
  
end
