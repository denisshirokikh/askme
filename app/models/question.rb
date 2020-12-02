class Question < ActiveRecord::Base

  belongs_to :user

  validates :user, presence: true
  validates :text, presence: true,
            length: { minimum: 4, maximum: 254 }

end
