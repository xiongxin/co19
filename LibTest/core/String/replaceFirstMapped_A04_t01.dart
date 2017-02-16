/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion String replaceFirstMapped(Pattern from,
 * String replace(Match match), [int startIndex = 0])
 * ...
 * Returns a new string, which is this string except that the first match of
 * pattern, starting from startIndex, is replaced by the result of calling
 * replace with the match object.
 * @description Checks that the replace function is called with the Match
 * generated by the pattern, and its result is used as replacement
 * @author sgrekhov@unipro.ru
 */
import "../../../Utils/expect.dart";

main() {
  check("123", "1", [0, 1]);
  check("1231", "1", [0, 1]);
  check("1231", "12", [0, 2]);
  check("1231", "23", [1, 3]);
  check("aa 1231\\n", new RegExp("\\s"), [2, 3]);
}

check(String str, Pattern from, List expected) {
  str.replaceFirstMapped(from, (m) {
    Expect.equals(str, m.input);
    Expect.equals(from, m.pattern);
    Expect.equals(expected[0], m.start);
    Expect.equals(expected[1], m.end);
    return 0;
  });
}