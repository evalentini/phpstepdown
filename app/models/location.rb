class Location < ActiveRecord::Base
  attr_accessible :name, :ishidden
  
  def self.unhiddenLocations
    locationList=[]
    Location.order("name asc").where(:ishidden=>false).each do |location|
      locationList << [location.name, location.id]
    end
    locationList
  end
end
