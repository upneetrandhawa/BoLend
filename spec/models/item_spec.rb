require 'rails_helper'

#  Item table schema
#   t.text "description"
#   t.integer "times_used"
#   t.boolean "available"
#   t.boolean "taken"
#   t.string "photo_link"
#   t.integer "user_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.integer "category_id"
#   t.index ["category_id"], name: "index_items_on_category_id"
#   t.index ["user_id"], name: "index_items_on_user_id"

#  Validations for this table
#     has_one_attached :image
#     validates :description, :category_id, presence: true
#     belongs_to :user
#     belongs_to :category
#     has_one :active_item

RSpec.describe Item, type: :model do

  shared_context 'create all' do

  end

  context 'Validations tests' do
    it 'Tests - ensures description presence' do
      user = User.new(email: 'superman@gmail.com', password: 'password', password_confirmation: 'password',
                      first_name: 'John', last_name: 'Singh', phone_number: '6471112222',
                      street_addr: '10 rocky road, Newfoundland', city: 'Toronto',
                      province: 'ON', postal_code: 'M4Y1R6', average_rating: 3.5).save
      category = Category.new(name: 'Toy').save
      item = Item.new(description: 'Has description', user_id: user, category_id: category).save
      expect(item).to eq(true)
    end
  end

end
