class AddNeedTwoFactorAuthValidationToSession < ActiveRecord::Migration[6.0]
  def change
    add_column :sessions, :need_two_factor_auth_validation, :boolean, :default => false
  end
end
