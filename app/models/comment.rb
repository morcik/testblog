class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :abusive, type: Boolean
  field :abuse_overridden, type: Boolean
  validates_presence_of :body

  
  belongs_to :user
  belongs_to :post
  has_many :votes, :dependent => :destroy

  def reported_abusive?
    self.votes.up.count - self.votes.down.count <= -3
  end

  def mark_as_not_abusive!
    self.abusive = false
    self.abuse_overridden = true
    self.save
  end
end
