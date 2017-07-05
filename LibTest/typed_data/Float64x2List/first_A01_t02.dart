/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion E first
 * Returns the first element.
 * @description Checks that [first] is read-only and can't be set.
 * @author ngl@unipro.ru
 */

import "dart:typed_data";
import "../../../Utils/expect.dart";

Float64x2 f64x2(v) => new Float64x2.splat(v);

void check(List<Float64x2> array) {
  dynamic l = new Float64x2List.fromList(array);
  try {
    l.first = f64x2(11.0);
    Expect.fail("[first] should be read-only");
  } on NoSuchMethodError {}
}

void checkClear(int length) {
  dynamic l = new Float64x2List(length);
  try {
    l.first = f64x2(12.0);
    Expect.fail("[first] should be read-only");
  } on NoSuchMethodError {}
}

main() {
  check([f64x2(1.0)]);
  check([f64x2(1.0), f64x2(2.0), f64x2(3.0), f64x2(4.0), f64x2(5.0)]);
  check([
    f64x2(1.0), f64x2(0.0), f64x2(0.0), f64x2(0.0), f64x2(0.0), f64x2(0.0),
    f64x2(0.0), f64x2(0.0), f64x2(0.0), f64x2(0.0), f64x2(0.0), f64x2(0.0),
    f64x2(0.0), f64x2(0.0), f64x2(0.0)
  ]);

  checkClear(1);
  checkClear(100);
}
