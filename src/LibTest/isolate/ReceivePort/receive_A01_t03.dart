/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Sets up a callback function for receiving
 * pending or future messages on this receive port.
 * @description Checks that only last callback is called.
 * @author msyabro
 * @reviewer kaigorodov
 */

#import('dart:isolate');

void main() {
  ReceivePort rPort = new ReceivePort();
  SendPort sPort = rPort.toSendPort();
  
  rPort.receive(void func(var message, SendPort replyTo) {
    Expect.fail("wrong callback");
  });
  
  rPort.receive(void func(var message, SendPort replyTo) {
    replyTo.send(message);
  });
  
  sPort.call(111).receive(void func(var message, SendPort replyTo) {
    rPort.close();
    Expect.equals(111, message);
  });
}