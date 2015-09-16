(function() {
  var Test;

  Test = (function() {
    function Test() {}

    Test.eng = 'hello';

    return Test;

  })();

  console.log(Test.eng);

}).call(this);
