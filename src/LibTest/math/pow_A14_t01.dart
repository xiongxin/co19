/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion num pow(num x, num y)
 * if [y] is Infinity and [x] is -1, the result is 1.0.
 * @description Checks the result when [x] is -1 and [y] is Infinity.
 * @author pagolubev
 * @reviewer msyabro
 */
import "../../Utils/expect.dart";

import "dart:math" as Math;

main() {
  Expect.equals(1.0, Math.pow(-1, double.INFINITY));
  Expect.equals(1.0, Math.pow(-1.0, double.INFINITY));
}
