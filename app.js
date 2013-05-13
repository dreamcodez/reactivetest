(function(){
  var c2f, f2c, $d, rUnit, rDegreesStr, rResult;
  c2f = function(degreesC){
    return degreesC * 1.8 + 32;
  };
  f2c = function(degreesF){
    return (degreesF - 32) / 1.8;
  };
  $d = $(document);
  rUnit = $R.state('F');
  $d.on('change', 'input:radio:checked[name=unit]', function(){
    return rUnit($(this).val());
  });
  rDegreesStr = $R.state('');
  $d.on('keyup', 'input[name=degrees]', function(){
    var lastStr, str;
    lastStr = rDegreesStr();
    str = $(this).val();
    if (str !== lastStr) {
      return rDegreesStr(str);
    }
  });
  rResult = $R(function(unit, degreesStr){
    var degrees;
    if (degreesStr === '') {
      return 'Please enter the amount of degrees';
    } else {
      degrees = parseInt(degreesStr);
      if (isNaN(degrees)) {
        return '<strong style="color:red">Please enter a real value for degrees</strong>';
      } else if (unit === 'C') {
        return "<strong>" + c2f(degrees).toFixed(2) + "</strong> degrees <em>Fahrenheit</em>";
      } else if (unit === 'F') {
        return "<strong>" + f2c(degrees).toFixed(2) + "</strong> degrees <em>Celsius</em>";
      }
    }
  }).bindTo(rUnit, rDegreesStr);
  $R(function(res){
    return $('#result').html(res);
  }).bindTo(rResult);
}).call(this);
