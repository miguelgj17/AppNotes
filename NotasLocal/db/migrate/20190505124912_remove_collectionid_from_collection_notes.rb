class RemoveCollectionidFromCollectionNotes < ActiveRecord::Migration[5.2]
  def change
    remove_reference :collection_notes, :collection_id, foreign_key: true
  end
end
