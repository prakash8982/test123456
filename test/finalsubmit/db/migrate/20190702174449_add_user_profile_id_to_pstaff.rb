class AddUserProfileIdToPstaff < ActiveRecord::Migration[5.2]
  def change
    add_column :pstaffs, :user_profile_id, :integer
  end
end
