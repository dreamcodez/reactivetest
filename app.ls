c2f = (degrees-c) ->
  degrees-c * 1.8 + 32

f2c = (degrees-f) ->
  (degrees-f - 32) / 1.8

$d = $ document

window.get-page = ->
  s = History.get-state!
  parser = document.create-element \a
  parser.href = s.url
  window.parser = parser

  # no host, just path
  uri = parser.pathname + parser.search

  {uri, s.title, s.data}

# read-only variable for tracking page info
window.page = get-page!

# setup initial state of rendered html, grab title from document
# this is so title information is correct when on initial loaded page
# normally it is a blank string ''
# eventually we may have an initial history data too.. if we ever use history data
History.replace-state {}, document.title, page.uri

window.r-page = $R.state page

# state changes from back/forward button updates r-page reactive variable
History.Adapter.bind window, \statechange, -> r-page(get-page!)

# read-only variable for tracking page info
$R(-> window.page = it).bind-to r-page

$r-pane = $R.state $('#container')

$d.on \click, '[data-select-pane]', ->
  $r-pane $($(this).data(\select-pane))
  return false

$R(($pane) ->
  $('.pane.active').remove-class 'active'
  $pane.add-class 'active'
  console.log $pane
).bind-to($r-pane)

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
