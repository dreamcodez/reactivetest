(function(){
  var c2f, f2c, $d, rUnit, rDegrees, rResult;
  c2f = function(degreesC){
    return degreesC * 1.8 + 32;
  };
  f2c = function(degreesF){
    return (degreesF - 32) / 1.8;
  };
  $d = $(document);
  rUnit = $R.state();
  $d.on('change', 'input:radio:checked[name=unit]', function(){
    return rUnit($(this).val());
  });
  rDegrees = $R.state();
  $d.on('keyup', 'input[name=degrees]', function(){
    return rDegrees(parseInt($(this).val()));
  });
  rResult = $R(function(unit, degrees){
    if (degrees) {
      if (unit === 'C') {
        return "<strong>" + c2f(degrees).toFixed(2) + "</strong> degrees <em>Fahrenheit</em>";
      } else {
        return "<strong>" + f2c(degrees).toFixed(2) + "</strong> degrees <em>Celsius</em>";
      }
    } else {
      return "<strong style=\"color:red\">Please enter a valid integer</strong>";
    }
  }).bindTo(rUnit, rDegrees);
  $R(function(res){
    return $('#result').html(res);
  }).bindTo(rResult);
}).call(this);
