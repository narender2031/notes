class CreateHashTagsNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :hash_tags_notes do |t|
      t.references :hash_tag, foreign_key: true
      t.references :note, foreign_key: true

      t.timestamps
    end
  end
end
