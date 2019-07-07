class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profiles do |t|
      t.string :name
      t.string :unique_id
      t.string :gender
      t.string :mobile_no
      t.string :department
      t.string :applicant_type
      t.string :address

      t.timestamps
    end
  end
end
