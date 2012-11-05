class PagesController < ApplicationController

  def index
    # templist = TempReading.where(["created_at >= ?", 24.hours.ago]).all
    # @temps = []
    # templist.each do |temp|
    #   @temps << [(temp.created_at.to_i*1000), temp.temperature]
    # end

    @temps = []
    templist = tempodb.read_key("office_temp", 24.hours.ago.utc, Time.now.utc, :interval => "1min")
    templist.data.each do |temp|
      @temps << [(temp.ts.to_i*1000), temp.value]
    end

    # templist2 = TempReading.where(["created_at >= ?", 1.week.ago]).all
    # @temp_week = []
    # templist2.each do |temp|
    #   @temp_week << [(temp.created_at.to_i*1000), temp.temperature]
    # end


    @temp_week = []
    templist = tempodb.read_key("office_temp", 1.week.ago.utc, Time.now.utc, :interval => "15min", :function => "avg")
    templist.data.each do |temp|
      @temp_week << [(temp.ts.to_i*1000), temp.value]
    end

    @hourly = nil
    @hourly_min = nil
    @hourly_max = nil
    @dow = nil

    # Hourly
    # @hourly = chart_grouper TempReading.average(:temperature, :group => "EXTRACT(HOUR from created_at)")    
    # @hourly_min = chart_grouper TempReading.minimum(:temperature, :group => "EXTRACT(HOUR from created_at)")    
    # @hourly_max = chart_grouper TempReading.maximum(:temperature, :group => "EXTRACT(HOUR from created_at)")    

    # # Day of week
    # @dow = chart_grouper TempReading.average(:temperature, :group => "EXTRACT(DOW from created_at)")


    @high = tempodb.read_key("office_temp", 1.year.ago.utc, Time.now.utc, :interval => "1year", :function => "max").data[0]
    @low = tempodb.read_key("office_temp", 1.year.ago.utc, Time.now.utc, :interval => "1year", :function => "min").data[0]
       
    # @high = TempReading.order("temperature DESC").first
    # @low = TempReading.order("temperature ASC").first

    @current = tempodb.read_key("office_temp", 10.minutes.ago, Time.now, :interval => "raw").data.last
    
  end


  private

  def chart_grouper(search)
    group = []
    search.each_pair do |key,val|
      group << [key.to_i, val.to_f]
    end
    group.sort {|a,b| a[0] <=> b[0]}
  end

end
