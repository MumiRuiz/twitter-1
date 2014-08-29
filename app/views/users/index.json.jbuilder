json.array!(@users) do |user|
  json.extract! user, :id, :username, :email, :password, :cover_photo, :profile_picture, :location, :private, :bio, :website, :timezone, :language, :phone, :verified, :name
  json.url user_url(user, format: :json)
end
