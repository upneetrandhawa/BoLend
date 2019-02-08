class ActiveItem < ApplicationRecord
  belongs_to :item
  
  def start_time
    start_date
  end
end
