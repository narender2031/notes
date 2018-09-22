class CreateHashTags < ActiveRecord::Migration[5.1]
  def change
    create_table :hash_tags do |t|
      t.string :hash_tag
      t.timestamps
    end
  end
end
