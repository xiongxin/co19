/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Returns the absolute value of int.
 * @description Checks that the method returns correct value.
 * @author vasya
 * @reviewer msyabro
 * @reviewer rodionov
 */
import "../../../Utils/expect.dart";

main() {
  Expect.equals(0, 0.abs());
  Expect.equals(1, (-1).abs());
  Expect.equals(15, 15.abs());
  Expect.equals(15, (-15).abs());
  Expect.equals(4294967295, (-4294967295).abs());
  Expect.equals(9223372036854775807, (-9223372036854775807).abs());
  Expect.equals(9223372036854775808, 9223372036854775808.abs());
  Expect.equals(18446744073709551617, (-18446744073709551617).abs());
  Expect.equals(0x8000000000000000, (-0x8000000000000000).abs());
}
