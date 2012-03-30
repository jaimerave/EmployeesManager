class User < ActiveRecord::Base
  validates_presence_of :name, :mobile, :twitter, :facebook, :phone, :email
  validates_length_of :mobile, in: 10..32
  validates_length_of :phone, in: 7..32
  validates :mobile, format: {with: /\+?(\d|\s)+$/}
  validates :phone, format: {with: /\+?(\d|\s)+$/}
  validates :email, uniqueness: true, format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :facebook, format: {with: /facebook.com\/\w+/}
  validate :valid_twitter?

  has_many :team_members
  has_many :teams, through: :team_members

  before_save :set_profile_picture

  devise :omniauthable

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else # Create a user with a stub password. 
      User.create!(:email => data.email, :password => Devise.friendly_token[0,20]) 
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end

  private

  def valid_twitter?
    name = twitter.scan(/(\w+)$/).join
    if name.present?
      begin
        user = Twitter.user(name)
      rescue Exception => e
        errors.add(:twitter, "does not exists")
      end
    else
      errors.add(:twitter, "is invalid")
    end
  end

  def set_profile_picture
    name = twitter.scan(/(\w+)$/).join
    user = Twitter.user(name)
    self.profile_picture = user.profile_image_url
  end
end
