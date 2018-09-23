class HashTag < ApplicationRecord
    has_many :hash_tags_notes
    has_many :notes, through: :hash_tags_notes, dependent: :destroy
end
