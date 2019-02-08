class AddValueToTimePeriodCategories < ActiveRecord::Migration[5.2]
  def change
  	add_column :time_period_categories, :name, :string
  end
end
