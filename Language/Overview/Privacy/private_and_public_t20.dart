/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Dart supports two levels of privacy: public and private. 
 * A declaration is private iff its name is private, otherwise it is public.
 * A name q is private iff any one of the identifiers that comprise q is 
 * private, otherwise it is public.
 * An identifier is private iff it begins with an underscore (the _ character) 
 * otherwise it is public.
 * A declaration m is accessible to library L if m is declared in L or if m is 
 * public.
 * @description Checks that an appropriate error (and warning) is produced 
 * when trying to access a private factory constructor that is not accessible 
 * to the current script.
 * @static-warning
 * @author iefremov
 * @reviewer rodionov
 */
import "../../../Utils/expect.dart";

import "../lib.dart";

main() {
  try {
    new ClassWithPrivateMembers._named2(); /// static warning not accessible
    Expect.fail("NoSuchMethodError expected");
  } on NoSuchMethodError {}
}
