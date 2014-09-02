json.array!(@tweets) do |tweet|
  json.extract! tweet, :id, :text, :user_id, :attachment, :location
  json.url tweet_url(tweet, format: :json)
end
