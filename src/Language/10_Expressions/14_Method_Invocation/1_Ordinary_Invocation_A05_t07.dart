/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion If the method lookup has failed, then let g be the result of looking up getter
 * m in vo with respect to L. If the getter lookup succeeded, let vg be the value of
 * the getter invocation o:m. Then let c be the result of looking up method call
 * in vg with respect to the current library L.
 * Next, c is executed with respect to the bindings of the evaluated argument
 * list. The value of i is the value returned after c is executed.
 * If getter lookup has also failed, then a new instance im  of the predefined interface
 * InvocationMirror is created by calling its factory constructor with arguments
 * �m�,  this, [o1, �, on] and {xn+1:on+1, �, xn+k : on+k}. Then the
 * method noSuchMethod() is looked up in o and invoked with argument im, and
 * the result of this invocation is the result of evaluating i.
 * @description Checks that noSuchMethod() is invoked on functions if the method and getter lookup has failed.
 * @static-warning
 * @author msyabro
 * @reviewer iefremov
 */

func() {}

class C {
  method() {}
}

main()  {
  localFunc() {}

  try {
    func.someMethod();
    Expect.fail("NoSuchMethodException is expected");
  } catch(NoSuchMethodException e) {}

  try {
    localFunc.someMethod();
    Expect.fail("NoSuchMethodException is expected");
  } catch(NoSuchMethodException e) {}

  try {
    new C().method.someMethod();
    Expect.fail("NoSuchMethodException is expected");
  } catch(NoSuchMethodException e) {}
}