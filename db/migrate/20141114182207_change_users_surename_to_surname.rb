class ChangeUsersSurenameToSurname < ActiveRecord::Migration
  def change
    rename_column :users, :surename, :surname
  end
end
