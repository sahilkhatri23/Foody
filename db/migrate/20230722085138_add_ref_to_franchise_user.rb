class AddRefToFranchiseUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :franchises, :user, foreign_key: true
  end
end
