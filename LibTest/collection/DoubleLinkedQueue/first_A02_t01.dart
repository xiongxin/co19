/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion final E first
 * If this is empty throws a StateError.
 * @description Checks that a StateError is thrown.
 * @author kaigorodov
 */
import "../../../Utils/expect.dart";
import "dart:collection";

main() {
  DoubleLinkedQueue queue = new DoubleLinkedQueue();
  
  Expect.throws(() {
      queue.first;
    },
    (e)=> e is StateError
  );
  
  queue.addFirst(1);
  queue.addFirst(2);
  queue.clear();
  
  Expect.throws(() {
      queue.first;
    },
    (e)=> e is StateError
  );
}
