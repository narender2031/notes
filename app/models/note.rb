class Note < ApplicationRecord
    has_many :hash_tags_notes
    has_many :hash_tags, through: :hash_tags_notes, dependent: :destroy

end
