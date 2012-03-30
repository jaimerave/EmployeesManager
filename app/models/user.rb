class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable

  validates_presence_of :name, :email, :mobile, :phone, :twitter, :facebook
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

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      signed_in_resource.update_attributes(:uid => access_token[:uid], :facebook => "facebook.com/#{data.username}")
      user
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end

  def password_required?
    false
  end

  private

  def valid_twitter?
    name = twitter.scan(/(\w+)$/).join if twitter
    if name.present?
      begin
        user = Twitter.user(name)
      rescue Exception => e
        errors.add(:twitter, "does not exists")
      end
    end
  end

  def set_profile_picture
    name = twitter.scan(/(\w+)$/).join
    user = Twitter.user(name)
    self.profile_picture = user.profile_image_url
  end
end