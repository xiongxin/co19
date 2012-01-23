/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion The function type (T1, ... Tn, [Tx1 x1, ..., Txk xk]) -> T is a subtype of the function
 * type (S1, ..., Sn, [Sy1 y1, ..., Sym ym ]) -> S, if all of the following conditions are met:
 * 1. Either S is void, or T <=> S.
 * 2. For all i 1 <= i <= n, Ti <=> Si.
 * 3. k >= m and xi = yi , for each i in 1..m.
 * 4. For all y, {y1 , . . . , ym} Sy <=> Ty
 * @description Checks that function type t1 is not a subtype of function type t2 
 * even if just one of t1's optional parameters has a type that is not mutually assignable with
 * the type of t2's corresponding optional parameter.
 * @author iefremov
 * @reviewer rodionov
 */

interface B {}

typedef B func(Object o);
typedef B f1(int i, B b, Map<int, num> m, var x, [var ox, B ob, List<num> ol, bool obool]);


main() {
  Expect.isFalse(B f(int i, B b, Map<int, num> m, var x, [var ox, func ob, List<num> ol, bool obool]) {} is f1);
  //                                                              ^^^ func <=/=> B
  Expect.isFalse(B f(int i, B b, Map<int, num> m, var x, [var ox, B ob, List<B> ol, bool obool]) {} is f1);
  //                                                                        ^^^ B <=/=> num
  Expect.isFalse(B f(num i, B b, Map<int, num> m, var x, [var ox, B ob, List<num> ol, int obool]) {} is f1);
  //                                                                                  ^^^ int <=/=> bool
}