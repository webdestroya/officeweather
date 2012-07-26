OfficeGraphs = {}

OfficeGraphs.DAY_OF_WEEK = ["Sun","Mon", "Tue", "Wed", "Thur", "Fri", "Sat"]

OfficeGraphs.default_temp_tick = (temp) ->
  "#{temp}F"

OfficeGraphs.overall_temperature = (container, data) =>
  graph = Flotr.draw container, [data], 
    xaxis: 
      mode: 'time'
      noTicks: 10
      minorTickFreq: 20
      tickFormatter: (num) ->
        moment(parseInt(num)).format("M/D h:mmA")
    grid:
      minorVerticalLines: true
    yaxis:
      noTicks: 10
      tickFormatter: OfficeGraphs.default_temp_tick
    HtmlText: true
    title: "Office Temperature"
    mouse: 
      track: true
      sensibility: 10
      radius: 5
      trackFormatter: (point) ->
        time = moment(parseInt(point.x))
        time.format("ddd M/D/YY, h:mm A")+": #{point.y}F"
  graph

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
    title: "Average Temperature by Hour"
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
    title: "Average Temperature by Day"
    mouse: 
      track: true
      relative: true
      sensibility: 5
      radius: 5
      trackFormatter: (point) ->
        dow = parseInt(point.x)
        "#{OfficeGraphs.DAY_OF_WEEK[dow]}: #{point.y}F"
        


window.OfficeGraphs = OfficeGraphs