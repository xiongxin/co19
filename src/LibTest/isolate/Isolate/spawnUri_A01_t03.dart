/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Future<Isolate> spawnUri(Uri uri, List<String> args, message)
 * Creates and spawns an isolate that runs the code from the library with the specified URI.
 * The isolate starts executing the top-level main function of the library with the given URI.
 * The target main may have one of the four following signatures:
 * main()
 * main(args)
 * main(args, message)
 * When present, the argument message is set to the initial message.
 * When present, the argument args is set to the provided args list.
 * Returns a future that will complete with an Isolate instance.
 * The isolate instance can be used to control the spawned isolate.
 * @description Checks that an isolate can be spawned from a newly spawned isolate.
 * @author kaigorodov
 */
import "dart:isolate";
import "../../../Utils/expect.dart";
import "../../../Utils/async_utils.dart";

var expectedMessage="spawnUri_A01_t03";

var receivePort = new ReceivePort();

void receiveHandler(var message) {
  Expect.equals(expectedMessage, message);
  receivePort.close();
  asyncEnd();
}

void main() {
  asyncStart();
  Isolate.spawnUri(new Uri.file("spawnUri_A01_t01.dart"), [expectedMessage], receivePort.sendPort);
  receivePort.listen(receiveHandler);
}
