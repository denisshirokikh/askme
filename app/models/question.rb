class Question < ApplicationRecord
  belongs_to :user

  validates :text, presence: true,
            length: { minimum: 4, maximum: 254 }
end
