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
  
  def self.reasonCount(reason_id=nil, location_id=nil, period=nil, patienttype=nil)
  
   #filtercriteria applicable to all queries here
   filterCrit="ishidden='f' and active='f'"  
    
   #create where criteria for type (default to drop outs)
   logger.info "----#{patienttype}---"
   pattypeCrit="phpvisits=0 and ipdays>0"
   pattypeCrit="phpvisits>0" if patienttype=="discharges"


   #otherwise set date as first day of selected month
   period=Date.new(period.split('-')[1].to_i, period.split('-')[0].to_i,1) unless period.nil?

   #set period to current month if nil
   period=Date.today if period.nil?

   
   #create where criteria for period
   #default to drop out case (use ip discharge date to determine period range)
   periodCrit={:ipdischargedate=>period.beginning_of_month..period.end_of_month} 
   periodCrit={:phpdischargedate=>period.beginning_of_month..period.end_of_month} if patienttype=="discharges"
   
    
   reasonCrit="dropreason_id is not null"
   reasonCrit="dropreason_id=#{reason_id}" unless reason_id.nil?
   
   locationCrit="facility_id is not null"
   locationCrit="facility_id=#{location_id}" unless location_id.nil?
   
   Discharge.where(filterCrit).where(pattypeCrit).where(periodCrit).where(reasonCrit).where(locationCrit).count
  
  end
  
  #class method to return "red" or "green" or "white" based on whether reason over/underindexes versus average
  def self.extValIndex(r_id, loc_id, per, ptype)
    unless Discharge.reasonCount(r_id, nil, per, ptype)==0 || Discharge.reasonCount(nil, loc_id, per, ptype)==0
      totalPct=Discharge.reasonCount(r_id, nil, per,ptype).to_f/Discharge.reasonCount(nil, nil,per,ptype).to_f
      facilityPct=Discharge.reasonCount(r_id, loc_id, per, ptype).to_f/Discharge.reasonCount(nil, loc_id,per,ptype).to_f
      if facilityPct<totalPct*0.80
        "red"
      else
        if facilityPct>totalPct*1.20
          "green"
        else
          "white"
        end
      end
    else
      "white"
    end
  end
  
  
  def self.reportingPeriods
    timePeriods={}
    #reporting period start: April 2014
    mytime=Time.utc(2014,"apr",1,0,1,1)
    loop do
      timePeriods[mytime.strftime("%b-%Y")]=mytime.strftime("%m-%Y")
      mytime=mytime.months_since(1)
      break if mytime>Time.now
    end
    timePeriods
     
  end

  
end
