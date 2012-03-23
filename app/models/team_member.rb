class TeamMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  validates_presence_of :user_id
end
