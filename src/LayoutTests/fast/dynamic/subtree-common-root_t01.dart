/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @description 
 */
import "dart:html";
import "../../../Utils/expect.dart";
import "../../testcommon.dart";

main() {
  document.body.setInnerHtml('''
      <p>
          Test for <i><a href="rdar://problem/5619240">rdar://problem/5619240</a> REGRESSION (Leopard-r28069): Reproducible crash with a Mootools-based calendar picker (jump to null in FrameView::layout)</i>.
      </p>
      <div id="target">
          <div style="overflow: hidden; width: 400px; height: 400px; position: relative;">
              <div></div>
              <div style="position: absolute; overflow: hidden; top: 0; width: 50px; height: 50px;"><div></div></div>
          </div>
      </div>
      ''', treeSanitizer: new NullTreeSanitizer());

  document.body.offsetTop;
  document.getElementById("target").style.display = "none";
}
