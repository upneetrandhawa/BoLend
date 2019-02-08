require 'rails_helper'

# Schema Category table
#   t.string "name"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false

#    has_many :items

RSpec.describe Category, type: :model do
  context 'validation text' do
    it 'Tests - ensure saves with and without category' do
      category = Category.new(name: 'Automobile').save
      expect(category).to eq(true)
      category = Category.new(name: '').save
      expect(category).to eq(true)
    end
  end
end
