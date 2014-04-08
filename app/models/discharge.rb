class Discharge < ActiveRecord::Base
  belongs_to :location
  belongs_to :dropreason
  
  validates_presence_of :facility_id
  validates_presence_of :medikid
  validates_uniqueness_of :medikid
  validates :ipdays, :numericality => {:only_integer => true}
  
  attr_accessible :active, :dropreason_id, :ipdays, :otherdetail, :phpvisits, :facility_id, :medikid, :ishidden, 
                  :ipdischargedate, :phpdischargedate
  
  def self.ipDayOptions
    ipDayOptionArray=[]
    ipDayOptionArray << ["0-was not IP patient", 0]
    (1..11).each do |day|
      ipDayOptionArray<<[day,day]
    end
    ipDayOptionArray << ["12+", 12]
    ipDayOptionArray
  end
  
  def self.phpVisitOptions
    phpVisitOptionArray=[]
    phpVisitOptionArray << ["0-dropped out before starting PHP", 0]
    (1..10).each do |day|
      phpVisitOptionArray << [day, day]
    end
    phpVisitOptionArray << [">10", 11]
    phpVisitOptionArray
  end
  
  def self.phpVisitCodeLookup(codenum)

    codeArray=Discharge.phpVisitOptions
    codeArray.each do |elem|
      return elem[0] if elem[1]==codenum
    end
  end
  
  def modIpDischargeDate
    modDate=self.ipdischargedate.strftime("%m-%d-%Y")
    modDate="n/a-no IP treatment @ Springstone" if self.ipdays==0
    modDate
  end
  
  def modPhpDischargeDate
    modDate=self.phpdischargedate.strftime("%m-%d-%Y")
    modDate="n/a-no dropped out w/o starting PHP" if self.phpvisits==0
    modDate
  end
  
  
  
end
