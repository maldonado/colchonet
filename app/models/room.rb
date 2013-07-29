class Room < ActiveRecord::Base
  attr_accessible :description, :location, :title
  
  validates_presence_of :description, :location, :title
  validates_length_of :description, :minimum => 20, :allow_blank => false
  
  def complete_name
    "#{title}, #{location}"
  end
end
