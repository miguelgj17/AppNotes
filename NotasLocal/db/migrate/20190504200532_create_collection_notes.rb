class CreateCollectionNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :collection_notes do |t|
      t.references :collection, foreign_key: true
      t.references :note, foreign_key: true

      t.timestamps
    end
  end
end
