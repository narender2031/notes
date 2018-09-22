class HashTagsNote < ApplicationRecord
  belongs_to :hash_tag
  belongs_to :note
end
