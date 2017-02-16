/*
 * Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion ChunkedConversionSink<Object> startChunkedConversion(
 *  Sink<String> sink
 *  )
 * Starts a chunked conversion.
 * ...
 * It is an error to invoke add more than once on the returned sink.
 * @description Checks that this method transforms stream's events
 * @author sgrekhov@unipro.ru
 */
import "dart:convert";
import "../../../Utils/expect.dart";

check(data) {
  JsonEncoder encoder = new JsonEncoder();
  var outSink = new ChunkedConversionSink.withCallback((chunks) {
    Expect.equals(encoder.convert(data), chunks2string(chunks));
  });
  var inSink = encoder.startChunkedConversion(outSink);
  inSink.add(data);
  Expect.throws(() {inSink.add(data);});
  Expect.throws(() {inSink.add(null);});
  inSink.close();
}

String chunks2string(Iterable<String> data) {
  StringBuffer sb = new StringBuffer();
  Iterator it = data.iterator;
  while (it.moveNext()) {
    sb.write(it.current);
  }
  return sb.toString();
}


main() {
  check(1);
  check(3.14);
  check(null);
  check(true);
  check(false);
  check('"str"');
  check(["1", "2", "3.14"]);
  check([[1, 2, 3], {"a": "3"}]);
  check({"a": "b"});
  check({"й": " ф "});
}