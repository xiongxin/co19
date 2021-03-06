/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion num pow(num x, num y)
 * if [y] is -Infinity, the result is 1/pow([x], Infinity).
 * @description Checks the result when [y] is -Infinity.
 * @author pagolubev
 * @reviewer msyabro
 */
import "../../Utils/expect.dart";

import "dart:math" as Math;

main() {
  Expect.equals(double.INFINITY, Math.pow(0.9999999999999999, double.NEGATIVE_INFINITY));
  Expect.equals(double.INFINITY, Math.pow(-0.9999999999999999, double.NEGATIVE_INFINITY));
  Expect.equals(double.INFINITY, Math.pow(0.5, double.NEGATIVE_INFINITY));
  Expect.equals(double.INFINITY, Math.pow(-0.5, double.NEGATIVE_INFINITY));
  Expect.equals(double.INFINITY, Math.pow(4.9406564584124654e-324, double.NEGATIVE_INFINITY));
  Expect.equals(double.INFINITY, Math.pow(-4.9406564584124654e-324, double.NEGATIVE_INFINITY));

  Expect.equals(1.0, Math.pow(-1, double.NEGATIVE_INFINITY));
  Expect.equals(1.0, Math.pow(-1.0, double.NEGATIVE_INFINITY));

  Expect.equals(.0, Math.pow(1.0000000000000002, double.NEGATIVE_INFINITY));
  Expect.equals(.0, Math.pow(-1.0000000000000002, double.NEGATIVE_INFINITY));
  Expect.equals(.0, Math.pow(2, double.NEGATIVE_INFINITY));
  Expect.equals(.0, Math.pow(-2, double.NEGATIVE_INFINITY));
  Expect.equals(.0, Math.pow(123.123, double.NEGATIVE_INFINITY));
  Expect.equals(.0, Math.pow(-123.123, double.NEGATIVE_INFINITY));
  Expect.equals(.0, Math.pow(1.7976931348623157e308, double.NEGATIVE_INFINITY));
  Expect.equals(.0, Math.pow(-1.7976931348623157e308, double.NEGATIVE_INFINITY));
}
