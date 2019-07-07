class UserProfile < ApplicationRecord
  belongs_to :user
  has_many   :pstaffs

  validates :name , :gender, :unique_id,:department ,:address, presence: true
    validates :mobile_no,:presence => true,:numericality => true,
     :length => { :minimum => 10, :maximum => 15 }

  has_attached_file :photo
  validates_attachment :photo, :content_type=>{ :content_type => %w(application/pdf image/jpg image/jpeg image/png application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) }

  has_attached_file :id_proof
  validates_attachment :id_proof,:content_type=>{ :content_type => %w(application/pdf image/jpg image/jpeg image/png application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) }

  GENDER = ['Male','Female','Others']

  TEMP = ['MACS', 'Computer Science', 'Mechanical','Civil','Electronic','Mining','Library','Academic','Account','Hostel','CCC','Audit','Administrator']
  TEMP1 = ['MACS', 'Computer Science', 'Mechanical','Civil','Electronic','Mining']
  TEMP2 = ['HCC', 'Guest House', 'Sports','Post Office','Placement','Garden','Compretive Society']

end
