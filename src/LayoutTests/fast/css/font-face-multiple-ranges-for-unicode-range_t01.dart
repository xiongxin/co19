/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/** 
 * @description Test for Bug 41509 - Ranges for @font-face unicode-range must
 * be separated by commas
 * unicode-range can have comma-separated multiple ranges. For each of the
 * following pairs, the upper and the lower lines should have the same length
 * on screen.
 */
import "dart:html";
import "../../testcommon.dart";
import "../../../Utils/async_utils.dart";
import "pwd.dart";

main() {
  var style = new Element.html('''
      <style>
      .test {
          border: solid 1px;
      }

      /* Test 0: Comma-separated list, which is valid. */
      @font-face {
          font-family:myfont_0;
          src: local('Times');
      }
      @font-face {
          font-family:myfont_0;
          src: local('Courier');
          unicode-range: u+69, u+6a; /* 'i' and 'j' */
      }

      /* Test 1: Comma-separated list with three elements, which is valid. */
      @font-face {
          font-family:myfont_1;
          src: local('Times');
      }
      @font-face {
          font-family:myfont_1;
          src: local('Courier');
          unicode-range: u+69 , u+6a ,u+6c; /* 'i', 'j', and 'l' */
      }

      /* Test 2: Comma-separated list with two consecutive commas, which is invalid. */
      @font-face {
          font-family:myfont_2;
          src: local('Times');
      }
      @font-face {
          font-family:myfont_2;
          src: local('Courier');
          unicode-range: u+69, , u+6a; /* 'i' and 'j' */
      }

      /* Test 3: Comma-separated list with a trailing comma, which is invalid. */
      @font-face {
          font-family:myfont_3;
          src: local('Times');
      }
      @font-face {
          font-family:myfont_3;
          src: local('Courier');
          unicode-range: u+69, u+6a,; /* 'i' and 'j' */
      }

      /* Test 4: Comma-separated list with a leading comma, which is invalid. */
      @font-face {
          font-family:myfont_4;
          src: local('Times');
      }
      @font-face {
          font-family:myfont_4;
          src: local('Courier');
          unicode-range: , u+69, u+6a; /* 'i' and 'j' */
      }

      /* Test 5: Space-separated list, which is invalid. */
      @font-face {
          font-family:myfont_5;
          src: local('Times');
      }
      @font-face {
          font-family:myfont_5;
          src: local('Courier');
          unicode-range: u+69 u+6a ; /* 'i' and 'j' */
      }

      /* Test 6: Slash-separated list, which is invalid. */
      @font-face {
          font-family:myfont_6;
          src: local('Times');
      }
      @font-face {
          font-family:myfont_6;
          src: local('Courier');
          unicode-range: u+69/u+6a; /* 'i' and 'j' */
      }

      </style>
      ''', treeSanitizer: new NullTreeSanitizer());
  document.head.append(style);
  
  document.body.setInnerHtml('''
      <div id="description"></div>
      <div id="tests"></div>

      <div id="console"></div>
      ''', treeSanitizer: new NullTreeSanitizer());

  var testsElement = document.getElementById("tests");
  var testStrings = [
    "iiiiiiiiii",
    "jjjjjjjjjj",
    "kkkkkkkkkk",
    "llllllllll"
  ];
  var expectedResults = [
    // Effective font family for "i", "j", "k", and "l"
    ["Courier", "Courier", "Times", "Times"],
    ["Courier", "Courier", "Times", "Courier"],
    ["Courier", "Courier", "Courier", "Courier"],
    ["Courier", "Courier", "Courier", "Courier"],
    ["Courier", "Courier", "Courier", "Courier"],
    ["Courier", "Courier", "Courier", "Courier"],
    ["Courier", "Courier", "Courier", "Courier"]
  ];

  createAndAppendSpan(id, subId, fontFamily)
  {
    var span = document.createElement("span");
    span.id = id;
    span.className = "test";
    span.style.fontFamily = fontFamily;
    span.innerHtml = testStrings[subId];
    testsElement.append(span);
    testsElement.append(new Text(" " + id));
    testsElement.append(document.createElement("br"));
  }

  for (var mainTestId = 0; mainTestId < expectedResults.length; mainTestId++) {
    for (var subTestId = 0; subTestId < testStrings.length; subTestId++) {
      var testId = "test_${mainTestId}_${subTestId}";
      var testFontFamily = "myfont_$mainTestId";
      createAndAppendSpan(testId, subTestId, testFontFamily);

      var refId = "ref_${mainTestId}_${subTestId}";
      var refFontFamily = expectedResults[mainTestId][subTestId];
      createAndAppendSpan(refId, subTestId, refFontFamily);

      shouldBe(document.getElementById(testId).offsetWidth,
          document.getElementById(refId).offsetWidth);
    }
    testsElement.append(document.createElement("br"));
  }
}
