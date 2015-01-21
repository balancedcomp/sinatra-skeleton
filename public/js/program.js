(function() {
  var Test;

  Test = (function() {
    function Test() {}

    Test.eng = 'hello';

    Test.ja = 'こんにちわ';

    return Test;

  })();

  console.log(Test.eng);

  console.log(Test.ja);

}).call(this);
