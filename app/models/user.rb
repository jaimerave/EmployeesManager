class User < ActiveRecord::Base
  validates_presence_of :name, :mobile, :twitter, :facebook, :phone, :email
  validates_length_of :mobile, in: 10..32
  validates_length_of :phone, in: 7..32
  validates :mobile, format: {with: /\+?(\d|\s)+$/}
  validates :phone, format: {with: /\+?(\d|\s)+$/}
  validates :email, uniqueness: true, format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :facebook, format: {with: /facebook.com\/\w+/}
  validate :valid_twitter?

  private

  def valid_twitter?
    name = twitter.scan(/(\w+)$/).join
    if name.present?
      begin
        user = Twitter.user(name)
        profile_picture = user.profile_image_url
      rescue Exception => e
        errors.add(:twitter, "does not exists")
      end
    else
      errors.add(:twitter, "is invalid")
    end
  end
end
