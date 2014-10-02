/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @description Input type=url validation test
 */
import "dart:html";
import "../../testcommon.dart";
import "../../../Utils/async_utils.dart";

main() {
  var i;

  check(value, mismatchExpected, [disabled=false]) {
    i.value = value;
    i.disabled = disabled;
    var actual = i.validity.typeMismatch;
    var didPass = actual == mismatchExpected;
    var resultText = value + ' is ' + (didPass ? 'a correct ' : 'an incorrect ') + (actual ? 'invalid' : 'valid') + ' url' + (disabled ? ' when disabled.' : '.');
    if (didPass)
      testPassed(resultText);
    else
      testFailed(resultText);
  }

  expectValid(value, [disabled=false]) {
    check(value, false, disabled);
  }

  expectInvalid(value) {
    check(value, true);
  }

  i = document.createElement('input');
  i.type = 'url';

  // Valid values
  expectValid('http://www.google.com');
  expectValid('http://foo:bar@www.google.com:80');
  expectValid('http://localhost');
  expectValid('http://127.0.0.1');
  expectValid('http://[0000:0000:0000:0000:0000:0000:7f00:0001]/');
  expectValid('http://[0000:0000:0000:0000:0000:0000:127.0.0.1]/');
  expectValid('http://[::7f00:0001]/');
  expectValid('http://[1::2:3]/');
  expectValid('http://[0000:0::ffff:10.0.0.1]/');
  expectValid('http://a');
  expectValid('http://www.google.com/search?rls=en&q=WebKit&ie=UTF-8&oe=UTF-8');
  expectValid('ftp://ftp.myhost.com');
  expectValid('ssh://ssh.myhost.com');
  expectValid('mailto:tkent@chromium.org');
  expectValid('mailto:tkent@chromium.org?body=hello');
  expectValid('file:///Users/tkent/.zshrc');
  expectValid('file:///C:/human.sys');
  expectValid('tel:+1-800-12345;ext=9999');
  expectValid('tel:03(1234)5678');
  expectValid('somescheme://ssh.myhost.com');
  expectValid('http://a/\\\/\'\'*<>/');
  expectValid('http://a/dfs/\kds@sds');
  expectValid('http://a.a:1/search?a&b');
  expectValid('http://www.google.com/#top');
  expectValid('http://\u30C6\u30B9\u30C8\u3002jp/\u30D1\u30B9?\u540D\u524D=\u5024');

  // Invalid values
  expectInvalid('www.google.com');
  expectInvalid('127.0.0.1');
  expectInvalid('.com');
  expectInvalid('http://www.google.com:aaaa');
  expectInvalid('://');
  expectInvalid('/http://www.google.com');
  expectInvalid('----ftp://a');
  expectInvalid('scheme//a');
  expectInvalid('http://[v8.:::]/');

  // KURL's host name restriction is stricter than RFC 3986. KURLGoogle is not.
  i.value = 'http://www.g**gle.com';
  var strictHost = i.validity.typeMismatch;
  if (strictHost) {
    expectInvalid('http:// www.google.com');
    expectInvalid('http://www .google.com');
    expectInvalid('http://www.&#10;google.&#13;com');
    expectInvalid('http://host+');
    expectInvalid('http://myurl!');
  } else {
    expectValid('http:// www.google.com');
    expectValid('http://www .google.com');
    expectValid('http://www.&#10;google.&#13;com');
    expectValid('http://host+');
    expectValid('http://myurl!');
  }

  // Disabled
  expectValid('invalid', true);
}
