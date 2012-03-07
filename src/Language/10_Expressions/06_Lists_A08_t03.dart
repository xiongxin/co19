/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion A runtime list literal <E>[e1... en]  is evaluated as follows:
 *   First, the expressions e1... en are evaluated in left to right order, yielding objects o1... on.
 *   A fresh instance a that implements the built-in interface List<E> is allocated.
 *   The ith element of a is set to oi+1, 0 <= i < n.
 *   The result of the evaluation is a.
 * @description Checks that ith element is set to o(i+1), o <= i < n.
 * @author msyabro
 * @reviewer rodionov
 */

main() {
  var l = [0, 1, 2, 3, 4, 5, 5 + 1, 5 + 2, 9 - 1, 9, 2 * 5];
  for(int i = 0; i <= 10; i++) {
    Expect.equals(i, l[i]);
  }

  l = <bool>[false, true];
  Expect.equals(false, l[0]);
  Expect.equals(true, l[1]);

  l = [];
  Expect.isTrue(l.isEmpty());

  l = ["a", "b", "c"];
  Expect.equals("a", l[0]);
  Expect.equals("b", l[1]);
  Expect.equals("c", l[2]);
}