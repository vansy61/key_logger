class CreateFbProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :fb_profiles do |t|
      t.string :url
      t.string :uuid
      t.integer :user_id

      t.timestamps
    end
  end
end
