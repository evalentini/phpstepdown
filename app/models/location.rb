class Location < ActiveRecord::Base
  attr_accessible :name, :ishidden
  
  def self.unhiddenLocations(locfilter=-999)
    locationList=[]
    Location.order("name asc").where(:ishidden=>false).where(Location.filterWhere(locfilter)).each do |location|
      locationList << [location.name, location.id]
    end
    locationList
  end
  
  def self.unhiddenLocHsh
    locationList={}
    Location.unhiddenLocations(-999).each do |loc|
      locationList[loc[0]]=loc[1]
    end
    locationList
  end
  
  def self.unhiddenLocationsWithAll
    locationList=Location.unhiddenLocations
    locationList.unshift(["All", -999])
    locationList
  end
  
  def self.filterWhere(locfilter=-999)
    if locfilter==-999
      return "id is not null"
    else
      return "id=#{locfilter}"
    end
  end
  
  def self.orderedUnhiddenLocations
    Location.where(ishidden: false).order("name asc")
  end
  
end
