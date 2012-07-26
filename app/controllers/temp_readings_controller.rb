class TempReadingsController < ApplicationController
  # GET /temp_readings
  # GET /temp_readings.json
  def index
    @temp_readings = TempReading.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @temp_readings }
    end
  end

  # GET /temp_readings/1
  # GET /temp_readings/1.json
  def show
    @temp_reading = TempReading.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @temp_reading }
    end
  end

  # GET /temp_readings/new
  # GET /temp_readings/new.json
  def new
    @temp_reading = TempReading.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @temp_reading }
    end
  end

  # GET /temp_readings/1/edit
  def edit
    @temp_reading = TempReading.find(params[:id])
  end

  # POST /temp_readings
  # POST /temp_readings.json
  def create
    @temp_reading = TempReading.new(params[:temp_reading])

    respond_to do |format|
      if @temp_reading.save
        format.html { redirect_to @temp_reading, notice: 'Temp reading was successfully created.' }
        format.json { render json: @temp_reading, status: :created, location: @temp_reading }
      else
        format.html { render action: "new" }
        format.json { render json: @temp_reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /temp_readings/1
  # PUT /temp_readings/1.json
  def update
    @temp_reading = TempReading.find(params[:id])

    respond_to do |format|
      if @temp_reading.update_attributes(params[:temp_reading])
        format.html { redirect_to @temp_reading, notice: 'Temp reading was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @temp_reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /temp_readings/1
  # DELETE /temp_readings/1.json
  def destroy
    @temp_reading = TempReading.find(params[:id])
    @temp_reading.destroy

    respond_to do |format|
      format.html { redirect_to temp_readings_url }
      format.json { head :no_content }
    end
  end
end
