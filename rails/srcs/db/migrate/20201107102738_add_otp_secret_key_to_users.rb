class AddOtpSecretKeyToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :otp_secret_key, :string
    add_column :users, :enabled_two_factor_auth, :boolean, :default => false
  end
end
