class CreateTimePeriodCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :time_period_categories do |t|

      t.timestamps
    end
  end
end
