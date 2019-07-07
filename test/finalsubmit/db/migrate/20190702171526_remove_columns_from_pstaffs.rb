class RemoveColumnsFromPstaffs < ActiveRecord::Migration[5.2]
  def change
    remove_column :pstaffs, :name, :string
    remove_column :pstaffs, :gender, :string
    remove_column :pstaffs, :unique_id, :string
    remove_column :pstaffs, :mobile_no, :string
    remove_column :pstaffs, :department, :string
    remove_column :pstaffs, :address, :string
    remove_column :pstaffs, :user_id, :integer
    remove_column :pstaffs, :type_applicant, :string
  end
end
