/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/** 
 * @description Tests that getComputedStyle returns length properties with a unit.
 */
import "dart:html";
import "../../../testcommon.dart";
import "../../../../Utils/async_utils.dart";
import "pwd.dart";

main() {
  var style = new Element.html('''
      <style>
          .visible { position: absolute; }
          .hidden { position: relative; display: none; }
      </style>
      ''', treeSanitizer: new NullTreeSanitizer());
  document.head.append(style);

  document.body.setInnerHtml('''
      <div id="test">Tests that getComputedStyle returns length properties with a unit.</div>
      <div id="console"></div>
      ''', treeSanitizer: new NullTreeSanitizer());

  var propertiesToCheck = {
    "background-position": "10px 10px",
    "background-size": "400px 300px",
    "-webkit-border-horizontal-spacing": "10px",
    "-webkit-border-vertical-spacing": "10px",

    "border-top-width": "2px",
    "border-right-width": "2px",
    "border-bottom-width": "2px",
    "border-left-width": "2px",
    "border-top-left-radius": "5px",
    "border-top-right-radius": "5px",
    "border-bottom-left-radius": "5px",
    "border-bottom-right-radius": "5px",

    "outline-width": "2px",

    "-webkit-column-rule-width": "10px",
    "-webkit-column-width": "80px",
    "-webkit-column-gap": "20px",

    "-webkit-mask-position": "10px 10px",
    "-webkit-mask-size": "10px 10px",
    "-webkit-perspective": "400px",
    "-webkit-perspective-origin": "20px 20px",
    "-webkit-text-stroke-width": "2px",
    "-webkit-transform-origin": "10px 10px",

    "left": "20px",
    "top": "20px",
    "right": "50px",
    "bottom": "50px",

    "font-size": "20px",
    "width": "400px",
    "max-width": "900px",
    "min-width": "200px",
    "height": "250px",
    "max-height": "600px",
    "min-height": "200px",
    "letter-spacing": "2px",
    "word-spacing": "10px",

    "margin-top": "10px",
    "margin-right": "10px",
    "margin-bottom": "10px",
    "margin-left": "10px",

    "padding-top": "10px",
    "padding-right": "10px",
    "padding-bottom": "10px",
    "padding-left": "10px",

    "text-indent": "10px"
  };

  var testElement = document.getElementById('test');
  for (var propertyName in propertiesToCheck.keys)
    testElement.style.setProperty(propertyName, propertiesToCheck[propertyName]);

  testPropertyUnit(className, propertyName) {
    if (testElement.className != className)
      testElement.className = className;
    var computedStyled = getComputedStyle(testElement);
    var results = new RegExp(r'\d+([a-z%]+)')
      .firstMatch(computedStyled.getPropertyValue(propertyName));
    return results != null ? results.group(1) : '';
  }

  for (var propertyName in propertiesToCheck.keys)
    shouldBe(testPropertyUnit('visible', propertyName), 'px');
  for (var propertyName in propertiesToCheck.keys)
    shouldBe(testPropertyUnit('hidden', propertyName), 'px');
}
