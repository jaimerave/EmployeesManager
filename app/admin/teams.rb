ActiveAdmin.register Team do
  show do |team|
    h3 team.name
    panel "Members" do
    table_for team.team_members do
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
    f.inputs "Details" do
      f.input :name
    end

    f.has_many :team_members do |t|
      t.inputs "" do
        t.input :user
      end
    end
    f.buttons
  end
end
