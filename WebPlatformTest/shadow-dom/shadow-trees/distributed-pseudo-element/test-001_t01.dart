/*
 * Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
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
 * @assertion Matching Children, Distributed To Insertion Points
 */

import 'dart:html';
import "../../../../Utils/expect.dart";
import '../../testcommon.dart';

main() {
  var d = document;
  d.body.setInnerHtml(bobs_page,
      treeSanitizer: new NullTreeSanitizer());

  //make shadow tree
  var ul = d.querySelector('ul.stories');
  var s = createSR(ul);
  var subdiv1 = d.createElement('div');
  subdiv1.setInnerHtml('<ul><content select="li"></content></ul>',
      treeSanitizer: new NullTreeSanitizer());
  s.append(subdiv1);

  var shadowStyle = new Element.html('''
      <style>*::distributed(.shadow) { display:none; }</style>''',
      treeSanitizer: new NullTreeSanitizer());
  s.append(shadowStyle);

  //The order of DOM elements should be the following:
  //li3, li6 - invisible. Other elements visible
  var li3 = d.querySelector('#li3');
  var li6 = d.querySelector('#li6');
  assert_equals(li3.getComputedStyle().display, "none",
      'Point 1: Elements that don\'t mach insertion point criteria participate in distribution');
  assert_equals(li6.getComputedStyle().display, "none",
      'Point 2: Elements that don\'t mach insertion point criteria participate in distribution');

  var li1 = d.querySelector('#li1');
  var li2 = d.querySelector('#li2');
  var li4 = d.querySelector('#li4');
  var li5 = d.querySelector('#li5');
  assert_not_equals(li1.getComputedStyle().display, "none",
      'Point 3: ::distributed() pseudo-element should be a valid insertion point matching criteria, element should be visible');
  assert_not_equals(li2.getComputedStyle().display, "none",
      'Point 4: ::distributed() pseudo-element should be a valid insertion point matching criteria, element should be visible');
  assert_not_equals(li4.getComputedStyle().display, "none",
      'Point 5: ::distributed() pseudo-element should be a valid insertion point matching criteria, element should be visible');
  assert_not_equals(li5.getComputedStyle().display, "none",
      'Point 6: ::distributed() pseudo-element should be a valid insertion point matching criteria, element should be visible');
}
