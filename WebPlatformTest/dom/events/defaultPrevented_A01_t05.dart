/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/*
 * Portions of this test are derived from code under the following license:
 *
 * Web-platform-tests are covered by the dual-licensing approach described in:
 * http://www.w3.org/Consortium/Legal/2008/04-testsuite-copyright.html
 */
/**
 * after web-platform-tests/dom/events/Event-defaultPrevented.html
 *
 * @description preventDefault() should change defaultPrevented if cancelable is false.
 */

import 'dart:html';
import "../../../Utils/expect.dart";

void main() {
  var ev = new Event("foo", canBubble:true, cancelable:true);
  Expect.isTrue(ev.cancelable, "cancelable (before)");
  ev.preventDefault();
  Expect.isTrue(ev.cancelable, "cancelable (after)");
  Expect.isTrue(ev.defaultPrevented, "defaultPrevented");
}
