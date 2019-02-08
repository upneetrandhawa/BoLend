class Category < ApplicationRecord
    has_many :items

    def self.get_name (category_id)
        if category_id != nil
            category = Category.find(category_id)
            if category 
                return category.name
            else
                return nil
            end
        else
            return 'No Category'
        end
    end

    def self.get_categories
        return Category.order(:name)
    end
end
