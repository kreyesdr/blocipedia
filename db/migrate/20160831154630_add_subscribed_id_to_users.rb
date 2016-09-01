class AddSubscribedIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscribed_id, :string
  end
end
