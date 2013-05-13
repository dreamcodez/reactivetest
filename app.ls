c2f = (degrees-c) ->
  degrees-c * 1.8 + 32

f2c = (degrees-f) ->
  (degrees-f - 32) / 1.8

$d = $ document

r-unit = $R.state!
$d.on \change, 'input:radio:checked[name=unit]', -> r-unit $(this).val!

r-degrees = $R.state!
$d.on \keyup, 'input[name=degrees]', -> r-degrees parse-int($(this).val!)

r-result = $R((unit, degrees) ->
  if degrees
    if unit is \C
      "<strong>#{c2f(degrees).to-fixed 2}</strong> degrees <em>Fahrenheit</em>"
    else
      "<strong>#{f2c(degrees).to-fixed 2}</strong> degrees <em>Celsius</em>"
  else
    "<strong style=\"color:red\">Please enter a valid integer</strong>"
).bind-to r-unit, r-degrees

$R((res) ->
  $ '#result' .html res
).bind-to r-result
