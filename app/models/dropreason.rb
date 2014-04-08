class Dropreason < ActiveRecord::Base
  attr_accessible :name, :ishidden
  
  validates_uniqueness_of :name 
  validates_presence_of :name 
  
  def self.unhiddenReasons
    reasonList=[]
    Dropreason.order("name asc").where(:ishidden=>false).each do |reason|
      reasonList << [reason.name, reason.id]
    end
    reasonList
  end
  
end
