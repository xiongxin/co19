/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @description This test checks the form attribute of the form-associated
 * elements.
 * @static-warning
 */
import "dart:html";
import "../../testcommon.dart";
import "../../../Utils/async_utils.dart";

main() {
  var container = document.createElement('div');
  document.body.append(container);

  debug('- Checks the existence of the form attribute for each form-associated elements.');
  container.setInnerHtml('<form id=owner></form>' +
    '<button name=victim form=owner />' +
    '<fieldset name=victim form=owner />' +
    '<input name=victim form=owner />' +
    '<keygen name=victim form=owner />' +
    '<label name=victim form=owner />' +
    '<object name=victim form=owner></object>' +
    '<output name=victim form=owner />' +
    '<select name=victim form=owner />' +
    '<textarea name=victim form=owner />',
    treeSanitizer: new NullTreeSanitizer());

  var owner = document.getElementById('owner');
  shouldBe(document.getElementsByTagName("button")[0].form, owner);
  shouldBe(document.getElementsByTagName("fieldset")[0].form, owner);
  shouldBe(document.getElementsByTagName("input")[0].form, owner);
  shouldBe(document.getElementsByTagName("keygen")[0].form, owner);
  shouldBe(document.getElementsByTagName("label")[0].form, owner);
  shouldBe(document.getElementsByTagName("object")[0].form, owner);
  shouldBe(document.getElementsByTagName("output")[0].form, owner);
  shouldBe(document.getElementsByTagName("select")[0].form, owner);
  shouldBe(document.getElementsByTagName("textarea")[0].form, owner);

  debug('');
  debug('- Ensures that the form attribute points the form owner even if the element is within another form element.');
  container.setInnerHtml('<form id=owner></form>' +
    '<form id=shouldNotBeOwner>' +
    '    <input id=inputElement name=victim form=owner />' +
    '    <label id=labelElement name=victim form=owner />' +
    '</form>',
    treeSanitizer: new NullTreeSanitizer());
  owner = document.getElementById('owner');
  var inputElement = document.getElementById('inputElement');
  var labelElement = document.getElementById('labelElement');
  shouldBe(inputElement.form, owner);
  shouldBe(labelElement.form, owner);

  debug('');
  debug('- Ensures that the form attribute of all form-associated element with or witout form attribute points the form owner.');
  container.setInnerHtml('<form id=owner>' +
    '    <input id=inputElement1 name=victim />' +
    '    <input id=inputElement2 name=victim form=owner />' +
    '    <input id=inputElement3 name=victim />' +
    '    <label id=labelElement1 name=victim />' +
    '    <label id=labelElement2 name=victim form=owner />' +
    '    <label id=labelElement3 name=victim />' +
    '</form>',
    treeSanitizer: new NullTreeSanitizer());
  owner = document.getElementById('owner');
  var inputElement1 = document.getElementById('inputElement1');
  var inputElement2 = document.getElementById('inputElement2');
  var inputElement3 = document.getElementById('inputElement3');
  var labelElement1 = document.getElementById('labelElement1');
  var labelElement2 = document.getElementById('labelElement2');
  var labelElement3 = document.getElementById('labelElement3');
  shouldBe(inputElement1.form, owner);
  shouldBe(inputElement2.form, owner);
  shouldBe(inputElement3.form, owner);
  shouldBe(labelElement1.form, owner);
  shouldBe(labelElement2.form, owner);
  shouldBe(labelElement3.form, owner);

  debug('');
  debug('- Ensures that the form attribute points the form owner even if the form element is nested another form element.');
  debug('NOTE: It seems that nesting form elements is not allowed so we ensure each form-associated elements associate with the outmost form element.');
  container.setInnerHtml('<form id=owner>' +
    '    <form>' +
    '        <input id=inputElement1 name=victim form=owner />' +
    '        <input id=inputElement2 name=victim />' +
    '        <input id=inputElement3 name=victim form=owner />' +
    '        <label id=labelElement1 name=victim form=owner />' +
    '        <label id=labelElement2 name=victim />' +
    '        <label id=labelElement3 name=victim form=owner />' +
    '    </form>' +
    '</form>',
    treeSanitizer: new NullTreeSanitizer());
  owner = document.getElementById('owner');
  inputElement1 = document.getElementById('inputElement1');
  inputElement2 = document.getElementById('inputElement2');
  inputElement3 = document.getElementById('inputElement3');
  labelElement1 = document.getElementById('labelElement1');
  labelElement2 = document.getElementById('labelElement2');
  labelElement3 = document.getElementById('labelElement3');
  shouldBe(inputElement1.form, owner);
  shouldBe(inputElement2.form, owner);
  shouldBe(inputElement3.form, owner);
  shouldBe(labelElement1.form, owner);
  shouldBe(labelElement2.form, owner);
  shouldBe(labelElement3.form, owner);

  debug('');
  debug('- Ensures whether the form owner is set correctly when the value of form attribute of a form-associated element changed.');
  container.setInnerHtml('<form id=form1></form>' +
    '<form id=form2></form>' +
    '<input id=inputElement name=victim form=form1 />' +
    '<label id=labelElement name=victim form=form1 />' +
    '<object id=objectElement name=victim form=form1></object>',
    treeSanitizer: new NullTreeSanitizer());
  var form1 = document.getElementById('form1');
  var form2 = document.getElementById('form2');
  inputElement = document.getElementById('inputElement');
  shouldBe(inputElement.form, form1);
  inputElement.attributes['form'] = 'form2';
  shouldBe(inputElement.form, form2);

  // HTMLabelElement has its own implementation of formAttr processing and so needs its own test.
  labelElement = document.getElementById('labelElement');
  shouldBe(labelElement.form, form1);
  labelElement.attributes['form'] = 'form2';
  shouldBe(labelElement.form, form2);

  // HTMLObjectElement has its own implementation of formAttr processing and so needs its own test.
  var objectElement = document.getElementById('objectElement');
  shouldBe(objectElement.form, form1);
  objectElement.attributes['form'] = 'form2';
  shouldBe(objectElement.form, form2);

  debug('');
  debug('- Ensures whether the form owner is set correctly when the value of form attribute is added/removed.');
  container.setInnerHtml('<form id=owner name=firstOwner></form>' +
    '<input id=inputElement name=victim />' +
    '<label id=labelElement name=victim />' +
    '<object id=objectElement name=victim></object>',
    treeSanitizer: new NullTreeSanitizer());
  owner = document.getElementById('owner');
  inputElement = document.getElementById('inputElement');
  shouldBe(inputElement.form, null);
  inputElement.setAttribute('form', 'owner');
  shouldBe(inputElement.form, owner);
  inputElement.attributes.remove('form');
  shouldBe(inputElement.form, null);

  // HTMLLabelElement has its own implementation of formAttr processing and so needs its own test.
  labelElement = document.getElementById('labelElement');
  shouldBe(labelElement.form, null);
  labelElement.setAttribute('form', 'owner');
  shouldBe(labelElement.form, owner);
  labelElement.attributes.remove('form');
  shouldBe(labelElement.form, null);

  // HTMLObjectElement has its own implementation of formAttr processing and so needs its own test.
  objectElement = document.getElementById('objectElement');
  shouldBe(objectElement.form, null);
  objectElement.setAttribute('form', 'owner');
  shouldBe(objectElement.form, owner);
  objectElement.attributes.remove('form');
  shouldBe(objectElement.form, null);

  debug('');
  debug('- Ensures whether the form owner is set correctly when the form owner is added/removed.');
  container.setInnerHtml('<form id=owner name=firstOwner></form>' +
    '<form id=owner name=secondOwner></form>' +
    '<input id=inputElement name=victim form=owner />' +
    '<label id=labelElement name=victim form=owner />',
    treeSanitizer: new NullTreeSanitizer());
  owner = document.getElementById('owner');
  shouldBeEqualToString(owner.name, 'firstOwner');
  inputElement = document.getElementById('inputElement');
  labelElement = document.getElementById('labelElement');
  owner.remove();
  owner = document.getElementById('owner');
  shouldBeEqualToString(owner.name, 'secondOwner');
  shouldBe(inputElement.form, owner);
  shouldBe(labelElement.form, owner);
  owner.remove();
  shouldBe(inputElement.form, null);
  shouldBe(labelElement.form, null);
  container.append(owner);
  shouldBe(inputElement.form, owner);
  shouldBe(labelElement.form, owner);

  debug('');
  debug('- Checks if option.form is only set if it has a &lt;select&gt; parent.');
  container.setInnerHtml('<form id=firstOwner><option id=firstOption></option></form>' +
    '<form id=secondOwner><optgroup><option id=secondOption></option></optgroup></form>' +
    '<form id=thirdOwner><select><optgroup><option id=thirdOption></option></optgroup></select></form>',
    treeSanitizer: new NullTreeSanitizer());
  var option1 = document.getElementById('firstOption');
  shouldBe(option1.form, null);
  var option2 = document.getElementById('secondOption');
  shouldBe(option2.form, null);
  owner = document.getElementById('thirdOwner');
  var option3 = document.getElementById('thirdOption');
  shouldBe(option3.form, owner);
}
