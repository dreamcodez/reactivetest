c2f = (degrees-c) ->
  degrees-c * 1.8 + 32

f2c = (degrees-f) ->
  (degrees-f - 32) / 1.8

$d = $ document

r-unit = $R.state 'F'
$d.on \change, 'input:radio:checked[name=unit]', -> r-unit $(this).val!

r-degrees-str = $R.state ''
$d.on \keyup, 'input[name=degrees]', ->
  last-str = r-degrees-str!
  str = $(this).val!
  if str != last-str
    r-degrees-str str

r-result = $R((unit, degrees-str) ->
  if degrees-str is ''
    'Please enter the amount of degrees'
  else
    degrees = parse-int degrees-str
    if is-NaN degrees
      '<strong style=\"color:red">Please enter a real value for degrees</strong>'
    else if unit is \C
      "<strong>#{c2f(degrees).to-fixed 2}</strong> degrees <em>Fahrenheit</em>"
    else if unit is \F
      "<strong>#{f2c(degrees).to-fixed 2}</strong> degrees <em>Celsius</em>"
).bind-to r-unit, r-degrees-str

$R((res) ->
  $ '#result' .html res
).bind-to r-result
