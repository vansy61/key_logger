class AddColumnLoginTokenToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :login_token, :string
  end
end
