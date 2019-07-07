class AddAttachmentPhotoIdProofToUserProfiles < ActiveRecord::Migration[5.2]
  def self.up
    change_table :user_profiles do |t|
      t.attachment :photo
      t.attachment :id_proof
    end
  end

  def self.down
    remove_attachment :user_profiles, :photo
    remove_attachment :user_profiles, :id_proof
  end
end
