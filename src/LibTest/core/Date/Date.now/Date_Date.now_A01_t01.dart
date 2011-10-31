/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Constructs a new [Date] instance with current date time value.
 * @description Checks that the Date instance is created.
 * @author hlodvig
 * @reviewer msyabro
 */

main(){
  Expect.isTrue(new Date.now() is Date);
}
