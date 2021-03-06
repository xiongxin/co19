/*
 * Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion final E single
 * If [this] is empty or has more than one element throws a [StateError].
 * @description Checks that a [StateError] is thrown if [this]
 * has more than one element.
 * @author msyabro
 */
import "dart:typed_data";
import "../../../Utils/expect.dart";

pack(v) => new Float32x4.splat(v);

check(array) {
  var l = new Float32x4List.fromList(array);
  try {
    l.single;
    Expect.fail("StateError is expected");
  } on StateError catch(ok) {}
}

main() {
  check([pack(1.0), pack(2.0)]);
  check([pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0),
         pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0),
         pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0),
         pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0),
         pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0), pack(1.0)]);
}
