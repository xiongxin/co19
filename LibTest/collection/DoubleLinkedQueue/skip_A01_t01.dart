/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Iterable<E> skip(int n)
 * Returns an Iterable that skips the first n elements.
 * @description checks that an Iterable that skips the first n elements is returned.
 * @author kaigorodov
 */

import "dart:collection";
import "../../../Utils/expect.dart";

check(List a, int n) {
  DoubleLinkedQueue queue = new DoubleLinkedQueue.from(a);
  Iterable it=queue.skip(n);
  Expect.equals(queue.length-n, it.length);
  int k=0;
  for (var el in it) {
    Expect.equals(queue.elementAt(n+k), el);
    k++;
  }      
}

main() {
  check([1,2,-3,4], 4);
  check([1,2,-3,4], 0);
  check([11,2,-3,4], 2);
  check([1,22,-3,4], 4);
  check(const[1,2,-5,-6, 100], 0);
  check(const[1, -1, 2,-5,-6], 1);
  check(const[0,0,1,2,-5,-6], 2);
  check(const[0,0,1,2,-5,-6], 6);
}