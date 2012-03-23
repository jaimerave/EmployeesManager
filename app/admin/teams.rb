ActiveAdmin.register Team do
  show do |team|
    h3 team.name
    panel "Members" do
      table_for team.team_members do
        column "Name" do |member|
          image_tag member.user.profile_picture
        end
        column "Name" do |member|
          member.user.name
        end
        column "Email" do |member|
          member.user.email
        end
      end
    end
  end

  form do |f|
    if f.object.errors.any?
      f.inputs "Error" do
        f.label f.object.errors.full_messages.to_sentence
      end
    end
    f.inputs "Details" do
      f.input :name
    end
    f.has_many :team_members do |t|
      t.input :user
      if !t.object.nil?
        t.input :_destroy, :as => :boolean, :label => "Delete?"
      end
    end
    f.buttons
  end
end
