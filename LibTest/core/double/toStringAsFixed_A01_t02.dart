/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion String toStringAsFixed(int fractionDigits)
 * @description Checks that for positive and negative infinity the method
 * returns 'Infinity' and '-Infinity' respectively regardless of the
 * 'fractionDigits' value.
 * @author pagolubev
 * @reviewer msyabro
 */
import "../../../Utils/expect.dart";


main() {
  double inf = 1 / 0;

  for(int i = 0; i < 10; i++) {
    Expect.equals('Infinity', inf.toStringAsFixed(i));
    Expect.equals('-Infinity', (-inf).toStringAsFixed(i));
  }
}
