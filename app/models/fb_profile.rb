class FbProfile < ApplicationRecord
  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "updated_at", "url", "user_id", "uuid"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
end
