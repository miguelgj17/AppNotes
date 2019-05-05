class AddCollectionidToCollectionNotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :collection_notes, :collection, foreign_key: true
  end
end
