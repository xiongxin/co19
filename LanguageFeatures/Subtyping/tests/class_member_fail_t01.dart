/*
 * Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion A type T0 is not a subtype of a type T1
 * @description Check that if type T0 not a subtype of a type T1, then it cannot
 * be used as a class member of type T1
 * @author sgrekhov@unipro.ru
 */
part of co19_subtype_tests;

class ClassMemberTestStatic {
  static T1 s;

  ClassMemberTestStatic(dynamic val) {
    s = val;
  }

  static staticTest() {
    s = forgetType(t0Instance);
  }

  static set staticSetter(dynamic val) {
    s = val;
  }

  static T1 get staticGetter => forgetType(t0Instance);
}

class ClassMemberTestPublic {
  T1 m;

  ClassMemberTestPublic(dynamic val) {
    m = val;
  }

  ClassMemberTestPublic.short(this.m);

  ClassMemberTestPublic.validConstructor() {}

  test(dynamic val) {
    m = val;
  }

  set setter(dynamic val) {
    m = val;
  }

  T1 get getter => forgetType(t0Instance);
}

class ClassMemberTestPrivate {
  T1 _m;

  ClassMemberTestPrivate(dynamic val) {
    _m = val;
  }

  ClassMemberTestPrivate.short(this._m);

  ClassMemberTestPrivate.validConstructor() {}

  test(dynamic val) {
    _m = val;
  }

  set setter(dynamic val) {
    _m = val;
  }
}

class ClassMemberTestInitFail {
  static T1 s = forgetType(t0Instance);
  T1 m = forgetType(t0Instance);
}

class ClassMemberTestGenericPublic<X> {
  X m;

  ClassMemberTestGenericPublic(dynamic val) {
    m = val;
  }

  ClassMemberTestGenericPublic.short(this.m);

  ClassMemberTestGenericPublic.validConstructor() {}

  test(dynamic val) {
    m = val;
  }

  set setter(dynamic val) {
    m = val;
  }

  X get getter => forgetType(t0Instance);
}

class ClassMemberTestGenericPrivate<X> {
  X _m;

  ClassMemberTestGenericPrivate(dynamic val) {
    _m = val;
  }

  ClassMemberTestGenericPrivate.short(this._m);

  ClassMemberTestGenericPrivate.validConstructor() {}

  test(dynamic val) {
    _m = val;
  }

  set setter(dynamic val) {
    _m = val;
  }
}


testClassMemberFail() {

  // Test initialization
  Expect.throws(() {ClassMemberTestInitFail.s;}, (e) => e is TypeError);
  Expect.throws(() {new ClassMemberTestInitFail();}, (e) => e is TypeError);

  // Test constructors
  Expect.throws(() {
    new ClassMemberTestPublic(t0Instance);
  }, (e) => e is TypeError);

  Expect.throws(() {
    new ClassMemberTestPublic.short(forgetType(t0Instance));
  }, (e) => e is TypeError);

  Expect.throws(() {
    new ClassMemberTestPrivate(t0Instance);
  }, (e) => e is TypeError);

  Expect.throws(() {
    new ClassMemberTestPrivate.short(forgetType(t0Instance));
  }, (e) => e is TypeError);

  Expect.throws(() {
    new ClassMemberTestGenericPublic<T1>(t0Instance);
  }, (e) => e is TypeError);

  Expect.throws(() {
    new ClassMemberTestGenericPublic<T1>.short(forgetType(t0Instance));
  }, (e) => e is TypeError);

  Expect.throws(() {
    new ClassMemberTestGenericPrivate<T1>(t0Instance);
  }, (e) => e is TypeError);

  Expect.throws(() {
    new ClassMemberTestGenericPrivate<T1>.short(forgetType(t0Instance));
  }, (e) => e is TypeError);

  // Test class variables
  Expect.throws(() {
    new ClassMemberTestPublic.validConstructor().m = forgetType(t0Instance);
  }, (e) => e is TypeError);

  Expect.throws(() {
    new ClassMemberTestGenericPublic<T1>.validConstructor().m = forgetType(t0Instance);
  }, (e) => e is TypeError);

  // Test setters
  Expect.throws(() {
    new ClassMemberTestPublic.validConstructor().setter = t0Instance;
  }, (e) => e is TypeError);

  Expect.throws(() {
    new ClassMemberTestPrivate.validConstructor().setter = t0Instance;
  }, (e) => e is TypeError);

  Expect.throws(() {
    new ClassMemberTestGenericPublic<T1>.validConstructor().setter = t0Instance;
  }, (e) => e is TypeError);

  Expect.throws(() {
    new ClassMemberTestGenericPrivate<T1>.validConstructor().setter = t0Instance;
  }, (e) => e is TypeError);

  // Test methods
  Expect.throws(() {
    new ClassMemberTestPublic.validConstructor().test(t0Instance);
  }, (e) => e is TypeError);

  Expect.throws(() {
    new ClassMemberTestPrivate.validConstructor().test(t0Instance);
  }, (e) => e is TypeError);

  Expect.throws(() {
    new ClassMemberTestGenericPublic<T1>.validConstructor().test(t0Instance);
  }, (e) => e is TypeError);

  Expect.throws(() {
    new ClassMemberTestGenericPrivate<T1>.validConstructor().test(t0Instance);
  }, (e) => e is TypeError);

  // Test getters
  Expect.throws(() {
    new ClassMemberTestPublic.validConstructor().getter;
  }, (e) => e is TypeError);

  Expect.throws(() {
    new ClassMemberTestGenericPublic<T1>.validConstructor().getter;
  }, (e) => e is TypeError);

  // Test static stuff
  Expect.throws(() {
    new ClassMemberTestStatic(t0Instance);
  }, (e) => e is TypeError);

  Expect.throws(() {
    ClassMemberTestStatic.staticSetter = t0Instance;
  }, (e) => e is TypeError);

  Expect.throws(() {
    ClassMemberTestStatic.staticGetter;
  }, (e) => e is TypeError);

  Expect.throws(() {
    ClassMemberTestStatic.staticTest();
  }, (e) => e is TypeError);
}
