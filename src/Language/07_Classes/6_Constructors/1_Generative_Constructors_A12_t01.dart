/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Execution of an initializer of the form this.v = e proceeds as follows:
 * First, the expression e is evaluated to an object o. Then, the instance variable
 * v of the object denoted by this is bound to o.
 * An initializer of the form v = e is equivalent to an initializer of the form
 * this.v = e.
 * @description Checks that RHS expression is evaluated in both forms of an initializer.
 * @author iefremov
 * @reviewer rodionov
 */

bool ok;
f() {
  ok = true;
}

class C {
  C() : this.x = f() {}
  C.c2() : x = f() {}
  var x;
}

main() {
  var x = new C();
  Expect.isTrue(ok, "Expression in initializer was not evaluated!");
  ok = false;
  x = new C.c2();
  Expect.isTrue(ok, "Expression in initializer was not evaluated!");
}
