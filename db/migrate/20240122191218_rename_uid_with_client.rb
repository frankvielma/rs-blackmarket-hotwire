# frozen_string_literal: true

class RenameUidWithClient < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :uid, :client
  end
end
