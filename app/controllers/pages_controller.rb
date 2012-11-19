class PagesController < ApplicationController

  def index
    @temps = []
    templist = tempodb.read_key("office_temp", 24.hours.ago.utc, Time.now.utc, :interval => "1min")
    templist.data.each do |temp|
      @temps << [(temp.ts.to_i*1000), temp.value]
    end

    @temp_week = []
    templist = tempodb.read_key("office_temp", 1.week.ago.utc, Time.now.utc, :interval => "15min", :function => "avg")
    templist.data.each do |temp|
      @temp_week << [(temp.ts.to_i*1000), temp.value]
    end

    @hourly = []
    @hourly_min = []
    @hourly_max = []
    @dow = []

    dow_temp = Hash.new
    
    hourly_temp = Hash.new
    hourly_min_temp = Hash.new
    hourly_max_temp = Hash.new

    24.times do |i|
      hourly_temp[i] = []
      hourly_min_temp[i] = []
      hourly_max_temp[i] = []
    end

    7.times do |i|
      dow_temp[i] = []
    end

    # Hourly
    # @hourly = chart_grouper TempReading.average(:temperature, :group => "EXTRACT(HOUR from created_at)")    
    # @hourly_min = chart_grouper TempReading.minimum(:temperature, :group => "EXTRACT(HOUR from created_at)")    
    # @hourly_max = chart_grouper TempReading.maximum(:temperature, :group => "EXTRACT(HOUR from created_at)")    

    
    hrlist = tempodb.read_key("office_temp", 1.month.ago.utc, Time.now.utc, :interval => "1hour", :function => "avg")
    hrlist.data.each do |temp|
      hourly_temp[(temp.ts.hour)] << temp.value
    end

    hrlist = tempodb.read_key("office_temp", 1.month.ago.utc, Time.now.utc, :interval => "1hour", :function => "min")
    hrlist.data.each do |temp|
      hourly_min_temp[(temp.ts.hour)] << temp.value
    end

    hrlist = tempodb.read_key("office_temp", 1.month.ago.utc, Time.now.utc, :interval => "1hour", :function => "max")
    hrlist.data.each do |temp|
      hourly_max_temp[(temp.ts.hour)] << temp.value
    end

    # calculate all the averages for the hourlies
    24.times do |i|
      @hourly << [i, (hourly_temp[i].inject{ |sum, el| sum + el }.to_f / hourly_temp[i].size)]
      @hourly_min << [i, (hourly_min_temp[i].inject{ |sum, el| sum + el }.to_f / hourly_min_temp[i].size)]
      @hourly_max << [i, (hourly_max_temp[i].inject{ |sum, el| sum + el }.to_f / hourly_max_temp[i].size)]
    end

    @hourly = @hourly.sort {|a,b| a[0] <=> b[0]}
    @hourly_min = @hourly_min.sort {|a,b| a[0] <=> b[0]}
    @hourly_max = @hourly_max.sort {|a,b| a[0] <=> b[0]}

    # # Day of week
    # @dow = chart_grouper TempReading.average(:temperature, :group => "EXTRACT(DOW from created_at)")

    dwlist = tempodb.read_key("office_temp", 1.month.ago.utc, Time.now.utc, :interval => "1day", :function => "avg")
    dwlist.data.each do |temp|
      dow_temp[(temp.ts.wday)] << temp.value
    end
    7.times do |i|
      @dow << [i, (dow_temp[i].inject{ |sum, el| sum + el }.to_f / dow_temp[i].size)]
    end

    @dow = @dow.sort {|a,b| a[0] <=> b[0]}

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
