json.extract! user_profile, :id, :name, :unique_id, :gender, :mobile_no, :department, :applicant_type, :address, :created_at, :updated_at
json.url user_profile_url(user_profile, format: :json)
