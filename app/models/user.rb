class User < ApplicationRecord
  # Provides builtin methods and accessors to authenticate, hash password etc.

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable


  geocoded_by :address
  after_validation :geocode
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  POSTAL_REGEX = /\A[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1}[ -]?\d{1}[A-Z]{1}\d{1}\z/i

  #validates :password, length: {in: 3..20}
  validates :password, confirmation: true
  #validates :password_confirmation, presence: true
  validates :phone_number, allow_blank: true, numericality: {only_integer: true}
  validates :email, presence: true
  #validates :first_name, :last_name, :password, :street_addr, :city, :postal_code, presence: true
  validates :email, uniqueness: true, format: {with: EMAIL_REGEX}
  #validates :postal_code, format:{with: POSTAL_REGEX}
  has_many :items
  has_many :borrower_reviews
  has_many :lender_reviews
  has_many :connections
  #belongs_to :user_auths

  def address
    [street_addr, city].compact.join(', ')
  end

  def self.find_with_name(name)
    if !name
      self.all
    else
      where(['lower(first_name) = ? OR lower(last_name) = ?', name.downcase, name.downcase])
    end
  end

  #Get the distance from user's address to the item's location
  #Returns a distance if the user is signed in, has valid address and
  #the item's location is valid
  def self.get_distance(user, item_location)
    if !user.nil? and !item_location.nil?
      if !user.longitude.nil? and !user.latitude.nil?
        return user.distance_to(item_location.values, :km)
      end
    end
    return nil
  end
end
