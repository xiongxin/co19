/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion It is compile time error if an actual argument to the prefix 
 * combinator denotes a name that is declared by the importing library.
 * @description Checks that it is a compile-time error if prefix value duplicates
 * a local identifier.
 * @compile-error
 * @author rodionov
 * @needsreview issue 3340, 3481
 */

#import("2_Imports_lib.dart", prefix: "prefix");

main() {
  int prefix;
  try {
    Expect.equals(1, prefix.foo);
  } catch(var e) {}
}