/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion bool identicalSync(
 *  String path1,
 *  String path2
 *  )
 * Synchronously checks whether two paths refer to the same object in the file
 * system.
 *
 * Comparing a link to its target returns false, as does comparing two links
 * that point to the same target. To check the target of a link, use Link.target
 * explicitly to fetch it. Directory links appearing inside a path are followed,
 * though, to find the file system object.
 *
 * Throws an error if one of the paths points to an object that does not exist.
 * @description Checks that this method completes with true if two paths refer
 * to the same object in the file system. Test absolute paths for file
 * @author sgrekhov@unipro.ru
 */
import "dart:io";
import "../../../Utils/expect.dart";
import "../../../Utils/file_utils.dart";

main() {
  File file = getTempFileSync();
  try {
    Expect.isTrue(FileSystemEntity.identicalSync(file.path, file.path));
  } finally {
    file.delete();
  }
}
