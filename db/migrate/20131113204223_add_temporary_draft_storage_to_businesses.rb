class AddTemporaryDraftStorageToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :temporary_draft_storage, :text
  end
end
