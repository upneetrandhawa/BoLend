require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context 'validation tests' do

    it 'Tests - ensures first name presence' do
      user = User.new(email: 'super@gmail.com', password: 'password', password_confirmation: 'password',
                      first_name: '', last_name: 'Smith', phone_number: '6471112222',
                      street_addr: '10 rocky road, Newfoundland', city: 'Toronto',
                      province: 'ON', postal_code: 'M4Y1R6', average_rating: 3.5).save
      expect(user).to eq(false)
    end

    it 'Tests - ensures last name presence' do
      user = User.new(email: 'super@gmail.com', password: 'password', password_confirmation: 'password',
                      first_name: 'John', last_name: '', phone_number: '6471112222',
                      street_addr: '10 rocky road, Newfoundland', city: 'Toronto',
                      province: 'ON', postal_code: 'M4Y1R6', average_rating: 3.5).save
      expect(user).to eq(false)
    end

    it 'Tests - ensures email presence' do
      user = User.new(email: '', password: 'password', password_confirmation: 'password',
                      first_name: 'John', last_name: 'Smith', phone_number: '6471112222',
                      street_addr: '10 rocky road, Newfoundland', city: 'Toronto',
                      province: 'ON', postal_code: 'M4Y1R6', average_rating: 3.5).save
      expect(user).to eq(false)
    end

    it 'Tests - ensures password presence' do
      user = User.new(email: 'super@gmail.com', password: '', password_confirmation: 'password',
                      first_name: 'John', last_name: 'Smith', phone_number: '6471112222',
                      street_addr: '10 rocky road, Newfoundland', city: 'Toronto',
                      province: 'ON', postal_code: 'M4Y1R6', average_rating: 3.5).save
      expect(user).to eq(false)
    end

    it 'Tests - ensures password_confirmation presence' do
      user = User.new(email: 'super@gmail.com', password: 'password', password_confirmation: '',
                      first_name: 'John', last_name: 'Smith', phone_number: '6471112222',
                      street_addr: '10 rocky road, Newfoundland', city: 'Toronto',
                      province: 'ON', postal_code: 'M4Y1R6', average_rating: 3.5).save
      expect(user).to eq(false)
    end

    it 'Tests - ensures phone_number absence' do
      user = User.new(email: 'super@gmail.com', password: 'password', password_confirmation: 'password',
                      first_name: 'John', last_name: 'Smith', phone_number: '',
                      street_addr: '10 rocky road, Newfoundland', city: 'Toronto',
                      province: 'ON', postal_code: 'M4Y1R6', average_rating: 3.5).save
      expect(user).to eq(true)
    end

    it 'Tests - user save successfully' do
      user = User.new(email: 'super@gmail.com', password: 'password', password_confirmation: 'password',
                      first_name: 'John', last_name: 'Smith', phone_number: '6471112222',
                      street_addr: '10 rocky road, Newfoundland', city: 'Toronto',
                      province: 'ON', postal_code: 'M4Y1R6', average_rating: 3.5).save
      expect(user).to eq(true)
    end
  end

  context 'scope tests' do
  end
end