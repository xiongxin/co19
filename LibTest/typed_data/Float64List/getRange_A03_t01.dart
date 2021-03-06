/*
 * Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Iterable<E> getRange(int start, int end)
 * It is an error if end is before start.
 * @description Checks that an error is thrown.
 * @author msyabro
 */
import "dart:typed_data";
import "../../../Utils/expect.dart";

main() {
  var l = new Float64List.fromList([0.0, 0.0, 0.0, 0.0, 0.0]);

  Expect.throws( () {
    var res = l.getRange(1, 0);
  });
}
