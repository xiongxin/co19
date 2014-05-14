// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library Expect;
import "dart:async";
part "../../Utils/expect_common.dart";

/**
 * some functions from harness.js ported 
 */

 void _fail(String message) {
    throw new ExpectException(message);
 }

void assert_equals(var actual, var expected, [String diag]) {
  Expect.equals(expected, actual, diag);
}

void assert_not_equals(var actual, var expected, [String diag]) {
  Expect.notEquals(expected, actual, diag);
}

void assert_true(var actual, [String diag]) {
  Expect.isTrue(actual, diag);
}

void assert_false(var actual, [String diag]) {
  Expect.isFalse(actual, diag);
}

void assert_throws(String expectedExceptionName, var function, [String diag]) {
  Expect.throws(function, (e)=>e.toString().contains(expectedExceptionName), diag);
}

void assert_array_equals(var actual, var expected, [String diag]) {
  Expect.listEquals(expected, actual, diag);
}

String failures="";

void test(void func(), String name, [properties]) {
  try {
    func();
  } catch (exc) {
    failures="$failures\nTest failed: $name\n$exc\n";
  }
}

void checkTestFailures() {
  if (failures=="") return;
  _fail(failures);
}


/*
 * Convert a value to a nice, human-readable string
 */
String format_value(val) {
  return val.toString(); // TODO
}

/***************** analogue of co19/tests/co19/src/Utils/async_utils.dart: *****/

const ONE_MS = const Duration(milliseconds: 1);

Duration durationMs(delay) {
  return delay == null? Duration.ZERO : ONE_MS * delay;
}


/**
 * Let the test driver know the test is asynchronous and
 * continues after the method main() exits.  
 * see co19 issue #423
 * http://code.google.com/p/co19/issues/detail?id=423
 */
var _completer = new Completer();
var asyncCompleted = _completer.future;

int _asyncTestStart() {
  print("unittest-suite-wait-for-done");
  return 0;
}

int _asyncCounter=_asyncTestStart();

void  asyncStart() {
  _asyncCounter++;
//  print("asyncStart");
}

void  asyncMultiStart(int delta) {
//  print("asyncMultiStart $delta");
  _asyncCounter+=delta;
}

void  asyncEnd() {
//  print("asyncEnd");
  Expect.isFalse(_asyncCounter==0, "asyncEnd: _asyncCounter==0");
  _asyncCounter--;
  if (_asyncCounter==0) {
    print("unittest-suite-success");
    _completer.complete(null);
  }
}