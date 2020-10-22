# https://stackoverflow.com/questions/5658035/how-to-add-a-variable-to-an-existing-model-ruby-on-rails
# https://stackoverflow.com/questions/54913752/how-i-can-change-the-model-attribute-name-on-ruby-on-rails

class UpdateSessionTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :sessions, :token
    add_column :sessions, :access_token, :string
    add_column :sessions, :token_type, :string
    add_column :sessions, :expires_in, :string
    add_column :sessions, :refresh_token, :string
    add_column :sessions, :scope, :string
  end
end