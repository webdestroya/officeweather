OfficeGraphs = {}

OfficeGraphs.DAY_OF_WEEK = ["Sun","Mon", "Tue", "Wed", "Thur", "Fri", "Sat"]

# Default function to print the temp
OfficeGraphs.default_temp_tick = (temp) ->
  "#{temp}F"

# Format the x ticks
OfficeGraphs.overall_tick_format = (num) ->
  moment(parseInt(num)).format("M/D<br>h:mmA")


# Overall temperature
OfficeGraphs.overall_temperature = (container, data) ->
  options = 
    selection:
      mode: "x"
    xaxis: 
      mode: 'time'
      noTicks: 10
      minorTickFreq: 20
      tickFormatter: OfficeGraphs.overall_tick_format
    grid:
      minorVerticalLines: true
    yaxis:
      noTicks: 10
      tickDecimals: 1
      tickFormatter: OfficeGraphs.default_temp_tick
    HtmlText: true
    mouse: 
      track: true
      sensibility: 10
      radius: 5
      trackFormatter: (point) ->
        time = moment(parseInt(point.x))
        time.format("ddd M/D/YY, h:mm A")+": #{point.y}F"

  drawGraph = (opts) ->
    new_opts = Flotr._.extend(Flotr._.clone(options), opts || {})
    Flotr.draw(container, [data], new_opts)

  graph = drawGraph()

  Flotr.EventAdapter.observe container, "flotr:select", (area) ->
    graph = drawGraph
      xaxis: 
        min: area.x1
        max: area.x2
        mode: "time"
        tickFormatter: OfficeGraphs.overall_tick_format
      yaxis:
        min: area.y1
        max: area.y2
    return

  Flotr.EventAdapter.observe container, "flotr:click", () ->
    graph = drawGraph()
    return

  graph



# Hourly Temperature
OfficeGraphs.hourly_temperature = (container, data) =>
  Flotr.draw container, [data], 
    bars:
      show: true
      centered: true
    xaxis: 
      min: 0
      max: 24
      noTicks: 24
      tickDecimals: 0
    yaxis:
      tickFormatter: OfficeGraphs.default_temp_tick
    mouse: 
      track: true
      relative: true
      sensibility: 5
      radius: 5
      trackFormatter: (point) ->
        hour = parseInt(point.x)

        if hour > 12
          return "#{(hour-12)}PM: #{point.y}F"
        else
          return "#{hour}AM: #{point.y}F"


# Day of the week graph
OfficeGraphs.dow_temperature = (container, data) =>
  Flotr.draw container, [data], 
    bars:
      show: true
    yaxis:
      tickFormatter: OfficeGraphs.default_temp_tick
    xaxis: 
      min: 0
      max: 6
      noTicks: 6
      tickDecimals: 0
      tickFormatter: (dow) ->
        OfficeGraphs.DAY_OF_WEEK[dow]
    mouse: 
      track: true
      relative: true
      sensibility: 5
      radius: 5
      trackFormatter: (point) ->
        dow = parseInt(point.x)
        "#{OfficeGraphs.DAY_OF_WEEK[dow]}: #{point.y}F"
        


window.OfficeGraphs = OfficeGraphs