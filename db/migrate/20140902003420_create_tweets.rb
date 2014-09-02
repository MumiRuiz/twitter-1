class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.references :user, index: true
      t.string :attachment
      t.string :location

      t.timestamps null: false
    end
  end
end
