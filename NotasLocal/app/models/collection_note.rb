class CollectionNote < ApplicationRecord
  belongs_to :collection
  belongs_to :note
end
