/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Future firstWhere(bool test(T element), {Object defaultValue()})
 * If an error occurs, or if this stream ends without finding a match and with
 * no defaultValue function provided, the future will receive an error.
 * @description Checks that if this stream ends without finding a match and
 * defaultValue function throws error, the future will receive that error.
 * @author a.semenov@unipro.ru
 */
library firstWhere_A03_t04;
import "dart:async";
import "../../../Utils/async_utils.dart";

void check(Stream<int> s, bool test(int element)) {
  Error expected = new CastError();
  AsyncExpect.error(expected, s.firstWhere(test, defaultValue:() => throw expected));
}

void test(CreateStreamFunction create) {
  check(create([]), (int element) => true);
  check(create([1, 2, 3]), (int element) => element == null);
  check(create([null, null]), (int element) => element != null);
  check(create(new Iterable.generate(0, (int index) => index)),
      (int element) => false);
  check(create(new Iterable.generate(10, (int index) => index)),
      (int element) => false);
  check(create(new Iterable.generate(10, (int index) => index * 5)),
      (int element) => element < 0);
  check(create(new Iterable.generate(10, (int index) => index * 5)),
      (int element) => element == 300);
}
