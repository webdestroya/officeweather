class TempReading < ActiveRecord::Base
  attr_accessible :temperature

  def display_temp
    "#{self.temperature.round(1)}F"
  end

end
