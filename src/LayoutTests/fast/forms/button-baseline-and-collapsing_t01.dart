/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @description 
 */
import "dart:html";
import "../../testcommon.dart";
import "../../../Utils/async_utils.dart";

main() {
  var f = new DocumentFragment.html('''
      <style>
        #test, button {
          font: 10px Ahem;
        }
        button, span, input { -webkit-appearance: none; }
        #b1 { margin-bottom: 0; border-bottom: 0; padding-bottom: 0; }
        /* Give b3 a border-bottom that's the same as the descent of Ahem,
         * therefore, the bottom of b3 should be the same as the bottom of the span.
         */
        #b3 { margin-bottom: 0; border-bottom: 2px outset; padding-bottom: 0; }
      </style>
      ''', treeSanitizer: new NullTreeSanitizer());
  document.head.append(f);

  document.body.setInnerHtml('''
      <p>Tests correct button behavior with respect to collapsing and baseline: Empty
      buttons have a baseline at the bottom of the content box; buttons with text are
      aligned so that the text lines up. Also, empty buttons should collapse.</p>

      <p>To understand this test, note that with the Ahem font, the bottom of the "X"
      is 2px below the baseline (at a 10px font-size).</p>

      <div id="test">
        <p><button id="b1"></button> <button id="b2"><span id="s2">X</span></button>
        <button id="b3"></button>
        <span id="s-ref">X</span></p>
      </div>

      <p id="out"></p>
      ''', treeSanitizer: new NullTreeSanitizer());

  bottom(node) {
    // bottom of the border-box
    return node.offsetTop + node.offsetHeight;
  }

  check_equal(i1, i2, msg) {
    debug(msg);
    shouldBe(i1, i2);
  }
  var b1 = document.getElementById("b1");
  var s2 = document.getElementById("s2");
  var b3 = document.getElementById("b3");
  var sref = document.getElementById("s-ref");

  check_equal(bottom(b1), bottom(sref) - 2, "b1 bottom == span baseline");
  check_equal(bottom(s2), bottom(sref), "s2 bottom == span bottom");
  check_equal(bottom(b3), bottom(sref), "b3 bottom == span bottom");

  // Now check for collapsing
  b1 = document.getElementById("b1");
  s2 = document.getElementById("s2");
  debug("empty buttons should collapse (offsetHeight should be smaller than the text)");
  shouldBeTrue(b1.offsetHeight < s2.offsetHeight);
}
