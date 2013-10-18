class Vote
  include Mongoid::Document
  before_save :allow_voting?
  field :value, type: Integer, default: 0

  belongs_to :user
  belongs_to :comment
  scope :up, where(value: 1)
  scope :down, where(value: -1)

  def allow_voting?
    self.comment.votes.where(user: self.user).empty?
  end
  def mark_abusive_comment
    c = self.comment
    if !c.abuse_overridden? && c.reported_abusive? then
      c.abusive = true
      c.save
    end
  end

end
