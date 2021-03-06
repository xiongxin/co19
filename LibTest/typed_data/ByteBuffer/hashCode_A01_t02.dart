/*
 * Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion final int hashCode
 * Get a hash code for this object. Hash codes are guaranteed to be
 * the same for objects that are equal when compared using the equality
 * operator ==.
 * @description Checks that [hashCode] is final and can't be set.
 * @author msyabro
 */

import "dart:typed_data";
import "../../../Utils/expect.dart";


main() {
  var list = new Int8List(10);
  var buffer = list.buffer;
  try {
    buffer.hashCode = 1;
    Expect.fail("[hashCode] should be final");
  } on NoSuchMethodError catch(ok) {}
}
