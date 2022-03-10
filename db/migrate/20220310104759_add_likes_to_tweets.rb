class AddLikesToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :likes, :integer, default: 0
  end
end
