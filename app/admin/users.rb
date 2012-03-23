ActiveAdmin.register User do
  filter :name
  filter :email
  filter :twitter

  index do
    column "", :profile_picture do |user|
      image_tag user.profile_picture
    end
    column :name
    column :email
    column :phone
    column :mobile
    column :twitter
    column :facebook
    default_actions
  end

  show do |user|
    attributes_table do
      row :profile_picture do
        image_tag(user.profile_picture)
      end
      row :name
      row :email
      row :phone
      row :mobile
      row :twitter do
        link_to user.twitter, "http://twitter.com/#{user.twitter.scan(/(\w+)$/).join}"
      end
      row :facebook do
        link_to user.facebook, "http://#{user.facebook}"
      end
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :email
      f.input :phone
      f.input :mobile
    end
    f.inputs "Social Networks" do
      f.input :twitter, hint: "@your_twitter"
      f.input :facebook, hint: "facebook.com/yourprofile"
    end
    f.buttons
  end
end
