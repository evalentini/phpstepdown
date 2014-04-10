class Discharge < ActiveRecord::Base
  belongs_to :location
  belongs_to :dropreason
  
  validates_presence_of :facility_id
  validates_presence_of :medikid
  validates_uniqueness_of :medikid
  validates :ipdays, :numericality => {:only_integer => true}
  
  attr_accessible :active, :dropreason_id, :ipdays, :otherdetail, :phpvisits, :facility_id, :medikid, :ishidden, 
                  :ipdischargedate, :phpdischargedate, :phpstartdate
  
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
  
  def self.locFilterWhere(locfilter=-999)
    if locfilter==-999
      return "facility_id is not null"
    else
      return "facility_id=#{locfilter}"
    end
  end
  
  
  def self.activePatients(locfilter=-999)
    Discharge.where(active: true, ishidden: false).where(Discharge.locFilterWhere(locfilter)).order("phpstartdate desc")
  end
  
  def self.droppedOutPatients(locfilter=-999)
    Discharge.where(active: false, ishidden: false, phpvisits: 0).where(Discharge.locFilterWhere(locfilter)).order("ipdischargedate desc")
  end
  
  def self.dischargedPatients(locfilter=-999)
    Discharge.where("active='f' and ishidden='f' and phpvisits>0").where(Discharge.locFilterWhere(locfilter)).order("phpdischargedate desc")
  end
  
  def modIpDischargeDate
    modDate=self.ipdischargedate.strftime("%m-%d-%Y") unless self.ipdischargedate.nil?
    modDate="n/a" if self.ipdays==0 || self.ipdischargedate.nil?
    modDate
  end

  def modPhpStartDate
    modDate=self.phpstartdate.strftime("%m-%d-%Y") unless self.phpstartdate.nil?
    modDate="n/a" if self.phpstartdate.nil?
    modDate
  end

  
  def modPhpDischargeDate
    modDate=self.phpdischargedate.strftime("%m-%d-%Y")
    modDate="n/a-no dropped out w/o starting PHP" if self.phpvisits==0
    modDate
  end
  
  
end
