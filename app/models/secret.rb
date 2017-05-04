class Secret < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes 

  validates :content, presence: true, length: { in: 2..144 }
end
