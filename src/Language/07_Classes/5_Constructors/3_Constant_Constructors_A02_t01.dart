/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion It is a compile-time error if a constant constructor has a body.
 * @description Checks that it is a compile-time error when a constant constructor 
 * declaration has a body.
 * @compile-error
 * @author vasya
 * @reviewer pagolubev
 * @reviewer iefremov
 * @reviewer rodionov
 */

class A {
  const A() {}
}

main() {
  try {
    var a = const A();
  } catch(var x) {}
}