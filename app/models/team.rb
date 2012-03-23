class Team < ActiveRecord::Base
  has_many :team_members
  has_many :users, through: :team_members
  accepts_nested_attributes_for :team_members, allow_destroy: true

  validates_presence_of :name
  validate :must_have_members

  private

  def must_have_members
    if team_members.empty? or team_members.all? {|member| member.marked_for_destruction? }
      errors[:base] << "Must have at least one member"
    end
  end
end
