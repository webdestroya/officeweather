class PagesController < ApplicationController

  def index
    templist = TempReading.where(["created_at >= ?", 1.month.ago]).all

    @temps = []
    templist.each do |temp|
      @temps << [(temp.created_at.to_i*1000), temp.temperature]
    end

    #TempReading.average(:temperature, :group => " strftime('%H',created_at)")
    hourlyavgs = TempReading.average(:temperature, :group => "EXTRACT(HOUR from created_at)")
    @hourly = []
    hourlyavgs.each_pair do |key,val|
      @hourly << [key.to_i, val.to_f]
    end

    dowavgs = TempReading.average(:temperature, :group => "EXTRACT(dow from created_at)")
    @dow = []
    dowavgs.each_pair do |key,val|
      @dow << [key.to_i, val.to_f]
    end

  end

end
