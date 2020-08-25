class AddRtIdToTweet < ActiveRecord::Migration[5.1]
  def change
    add_column :tweets, :rt_ref, :integer
  end
end
