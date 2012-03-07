/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Evaluation of e proceeds as follows:
 * First, if e is of the form const T.id(a1, .., an, xn+1: an+1, …, xn+k: an+k)
 * then let i be the value of the expression new T.id(a1, .., an, xn+1: an+1, …, xn+k: an+k).
 * Otherwise, e must be of the form  const T(a1, .., an, xn+1: an+1, …, xn+k: an+k),
 * in which case let i be the result of evaluating new T(a1, .., an, xn+1: an+1, …, xn+k: an+k) .
 * Then:
 * If during execution of the program, a constant object expression has already evaluated to an
 * instance j of class C with type arguments Vi 1 <= i <= m, then:
 *   For each instance variable f of i, let vif be the value of the f in i, and let vjf be the
 *   value of the field f in j. If  vif  === vjf for all fields f in i, then the value of e is j,
 *   otherwise the value of e is i.
 * Otherwise the value of e is i.
 * @description Checks that a fresh instance of an object is created
 * if not all fields in i are identical to the fields in j.
 * @author msyabro
 */

class A {
  const A(p1): x = p1, y = 3;
  final x;
  final y;
}


main() {
  var o1 = const A(1);
  var o2 = const A(2);
  Expect.isFalse(o1 === o2);

  for(int i = 0; i < 10; i++) {
    Expect.isTrue(const A(1) === o1);
    Expect.isFalse(const A(1) === o2);
    Expect.isTrue(const A(2) === o2);
    Expect.isFalse(const A(2) === o1);
  }
}