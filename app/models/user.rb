class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  validates_presence_of :name, :email
  validates_length_of :mobile, in: 10..32, allow_blank: true
  validates_length_of :phone, in: 7..32, allow_blank: true
  validates :mobile, format: {with: /\+?(\d|\s)+$/}, allow_blank: true
  validates :phone, format: {with: /\+?(\d|\s)+$/}, allow_blank: true
  validates :email, uniqueness: true, format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }, allow_blank: true
  validates :facebook, format: {with: /facebook.com\/\w+/}, allow_blank: true
  validate :valid_twitter?

  has_many :team_members
  has_many :teams, through: :team_members

  before_save :set_profile_picture

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      signed_in_resource.update_attributes(:uid => access_token[:uid], :name => data.name, :facebook => "facebook.com/#{data.username}")
      user
    else # Create a user with a stub password.
      User.create!(:email => data.email, :name => data["name"], :password => Devise.friendly_token[0,20])
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
