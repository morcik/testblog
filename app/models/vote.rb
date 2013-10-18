class Vote
  include Mongoid::Document
  
  field :value, type: Integer, default: 0

  belongs_to :user
  belongs_to :comment
  scope :up, where(value: 1)
  scope :down, where(value: -1)
end
