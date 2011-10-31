/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Assigns the index'th element of the list to the given value.
 * @description Checks that needed element is correctly assigned in fixed size lists. 
 * @author iefremov
 * @reviewer msyabro
 * @reviewer varlax
 */

void arrayEquals(List expected, List actual) {
  Expect.isTrue(expected.length == actual.length);
  for(var i = 0; i < expected.length; i+=1) {
    Expect.isTrue(expected[i] === actual[i]);
    Expect.isTrue(expected[i] == actual[i]);
  }
}

main() {
  List a = [null];
  a[0] = 1;
  Expect.isTrue(1 === a[0]);
  a[0] = null;
  Expect.isTrue(null == a[0]);
  a[0] = a;
  Expect.isTrue(a === a[0]);

  a = new List(3);
  a[0] = 1;a[2] = 3;
  arrayEquals([1, null, 3], a);
  a[2] = null;
  arrayEquals([1, null, null], a);
  a[0] = null;
  arrayEquals([null, null, null], a);
  a[1] = 100500;
  arrayEquals([null, 100500, null], a);
}
