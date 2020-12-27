class AddProfileColorToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :profile_color, :string, default: '#005f55'
  end
end
