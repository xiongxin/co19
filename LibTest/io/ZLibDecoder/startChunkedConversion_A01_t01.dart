/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion ByteConversionSink startChunkedConversion(Sink<List<int>> sink)
 * Start a chunked conversion. While it accepts any Sink taking List<int>'s,
 * the optimal sink to be passed as sink is a ByteConversionSink.
 * @description Checks that the the [startChunkedConversion] method starts a
 * chunked conversion.
 * @author ngl@unipro.ru
 */
import "dart:convert";
import "dart:io";
import "../../../Utils/expect.dart";

check(List l) {
  ZLibEncoder encoder = new ZLibEncoder();
  var list = encoder.convert(l);
  ZLibDecoder decoder = new ZLibDecoder();
  bool called = false;

  Sink<List<int>> outSink = new ChunkedConversionSink.withCallback((chunks) {
    int first = 0;
    for (int i = 0; i < chunks.length; i++) {
      var el = [decoder.convert(list)];
      var cl = chunks[i].length;
      Expect.listEquals((el[0]).sublist(first, first + cl), chunks[i]);
      first += cl;
    }
    called = true;
  });

  ByteConversionSink inSink = decoder.startChunkedConversion(outSink);
  inSink.add(list);
  inSink.close();
  Expect.isTrue(called, "called false");
}

main() {
  for (int i = 0; i < 128; i++) {
    check([i]);
  }
  check([]);
}