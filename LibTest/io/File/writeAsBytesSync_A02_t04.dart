/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion void writeAsBytesSync(
 * List<int> bytes, {
 * FileMode mode: FileMode.WRITE,
 * bool flush: false
 * })
 * Synchronously write a list of bytes to a file.
 *
 * Opens the file, writes the list of bytes to it and closes the file.
 *
 * By default writeAsBytesSync creates the file for writing and truncates the
 * file if it already exists. In order to append the bytes to an existing file,
 * pass FileMode.APPEND as the optional mode parameter.
 *
 * If the flush argument is set to true data written will be flushed to the file
 * system before returning.
 *
 * Throws a FileSystemException if the operation fails.
 * @description Checks that in a FileMode.READ a FileSystemException is thrown.
 * Test not existing file
 * @author sgrekhov@unipro.ru
 */
import "dart:io";
import "../../../Utils/expect.dart";
import "../file_utils.dart";

main() {
  File file = new File(getTempFilePath());

    Expect.throws(() {file.writeAsBytesSync([3, 1, 4], mode: FileMode.READ);},
        (e) => e is FileSystemException);
  Expect.isFalse(file.existsSync());
}