class Note < ApplicationRecord
    has_and_belongs_to_many :hash_tags
end
