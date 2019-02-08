class TimePeriodCategory < ApplicationRecord
    def self.get_categories
        return TimePeriodCategory.all
    end
end
