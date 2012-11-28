/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion "throw" is a reserved word.
 * @description Checks that it is a compile-time error when a reserved word "throw"
 * is used as a label name.
 * @compile-error
 * @author rodionov
 * @reviewer kaigorodov
 */

main() {
  try {
    throw:
    do {
      break throw;
    } while(false);
  } catch(x) {}
}
