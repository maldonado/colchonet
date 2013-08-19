class Room < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :description, :location, :title
  
  scope :most_recent, order("created_at DESC")
  
  validates_presence_of :description, :location, :title
  validates_length_of :description, :minimum => 20, :allow_blank => false
  
  def complete_name
    "#{title}, #{location}"
  end
end
