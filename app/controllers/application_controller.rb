class ApplicationController < ActionController::Base
  #protect_from_forgery

  helper_method :tempodb

  def tempodb
    @tempodb ||= TempoDB::Client.new("9b0a49737bc34b1b89717d3f1517dca2", "58619f23df9d455e9c7706d21ee893da")
  end

end
