/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion StreamSubscription<T> listen(void onData(T event),
 *   {Function onError, void onDone(), bool cancelOnError})
 * The onError callback must be of type void onError(error) or
 * void onError(error, StackTrace stackTrace). If onError accepts two
 * arguments it is called with the stack trace (which could be null if the
 * stream itself received an error without stack trace). Otherwise
 * it is called with just the error object.
 * @description Checks that onError callback with two parameters can be used
 * in which case the second parameter is a stack trace.
 * @author ilya
 */
import "dart:async";
import "../../../Utils/async_utils.dart";
import "../../../Utils/expect.dart";

const N = 10;

main() {
  Stream<int> s = new Stream.fromIterable(new Iterable.generate(N, (x) => x));

  List errors = [];
  List stackTraces = [];
  Stream<int> s2 = s.map((event) {
    try {
      throw new Error();
    } catch (e, st) {
      errors.add(e);
      stackTraces.add(st);
      rethrow; // error and stack trace are the same as e and st
    }
  });

  asyncMultiStart(N);

  s2.listen((_) {
    Expect.fail('unexpected call to onData');
  }, onError: (e, st) {
    Expect.identical(errors.removeAt(0), e);
    Expect.identical(stackTraces.removeAt(0), st);
    asyncEnd();
  });
}
