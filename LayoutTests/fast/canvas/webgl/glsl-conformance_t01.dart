/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/** 
 * @description This test ensures WebGL implementations allow proper GLES2
 * shaders compile and improper ones fail.
 */
import "dart:html";
import "dart:web_gl" as wgl;
import 'dart:typed_data';
import "../../../testcommon.dart";
import "resources/webgl-test.dart";
import "resources/webgl-test-utils.dart" as wtu;
import "../../../../Utils/async_utils.dart";
import "pwd.dart";

main() {
  document.body.setInnerHtml('''
      <div id="console"></div>
      <script id="vshader" type="text/something-not-javascript">
      attribute vec4 vPosition;
      void main()
      {
          gl_Position = vPosition;
      }
      </script>
      <script id="fshader" type="text/something-not-javascript">
      precision mediump float;
      void main()
      {
          gl_FragColor = vec4(1.0,0.0,0.0,1.0);
      }
      </script>
      <script id="fshaderWithPrecision" type="text/something-not-javascript">
      void main()
      {
          mediump vec4 color = vec4(1.0,0.0,0.0,1.0);
          gl_FragColor = color;
      }
      </script>
      <script id="vshaderWithDefaultPrecision" type="text/something-not-javascript">
      precision mediump float;
      attribute vec4 vPosition;
      void main()
      {
          gl_Position = vPosition;
      }
      </script>
      <script id="fshaderWithDefaultPrecision" type="text/something-not-javascript">
      precision mediump float;
      void main()
      {
          gl_FragColor = vec4(1.0,0.0,0.0,1.0);
      }
      </script>
      <script id="fshaderWithOutPrecision" type="text/something-not-javascript">
      uniform vec4 color;
      void main()
      {
          gl_FragColor = color;
      }
      </script>
      <script id="fshaderWithInvalidIdentifier" type="text/something-not-javascript">
      precision mediump float;
      uniform float gl_foo;
      void main()
      {
          gl_FragColor = vec4(gl_foo,0.0,0.0,1.0);
      }
      </script>
      <script id="fshaderWithGL_ESeq1" type="text/something-not-javascript">
#if GL_ES == 1
        precision mediump float;
        void main()
        {
            gl_FragColor = vec4(0.0,0.0,0.0,1.0);
        }
#else
        foo
#endif
      </script>
      <script id="fshaderWithGLSLPreprocessorSymbol" type="text/something-not-javascript">
#if defined(GL_ES)
        precision mediump float;
        void main()
        {
            gl_FragColor = vec4(0.0,0.0,0.0,1.0);
        }
#else
        foo
#endif
      </script>
      <script id="fshaderWithVERSION100PreprocessorSymbol" type="text/something-not-javascript">
#if __VERSION__ == 100
        precision mediump float;
        void main()
        {
            gl_FragColor = vec4(0.0,0.0,0.0,1.0);
        }
#else
        foo
#endif
      </script>
      <script id="fshaderWithFragDepth" type="text/something-not-javascript">
      precision mediump float;
      void main()
      {
          gl_FragColor = vec4(0.0,0.0,0.0,1.0);
          gl_FragDepth = 1.0;
      }
      </script>
      <script id="vshaderWithClipVertex" type="text/something-not-javascript">
      attribute vec4 vPosition;
      void main()
      {
          gl_Position = vPosition;
          gl_ClipVertex = vPosition;
      }
      </script>
      <script id="fshaderWith__Define" type="text/something-not-javascript">
#define __foo 1
      precision mediump float;
      void main()
      {
          gl_FragColor = vec4(0.0,0.0,0.0,1.0);
      }
      </script>
      <script id="fshaderWithGL_Define" type="text/something-not-javascript">
#define GL_FOO 1
      precision mediump float;
      void main()
      {
          gl_FragColor = vec4(0.0,0.0,0.0,1.0);
      }
      </script>
      <script id="fshaderWithDefineLineContinuation" type="text/something-not-javascript">
#define foo this \
        is a test
      precision mediump float;
      void main()
      {
          gl_FragColor = vec4(0.0,0.0,0.0,1.0);
      }
      </script>
      <script id="vshaderWithgl_Color" type="text/something-not-javascript">
      attribute vec4 vPosition;
      void main()
      {
          gl_Position = gl_Color;
      }
      </script>
      <script id="vshaderWithgl_ProjectionMatrix" type="text/something-not-javascript">
      attribute vec4 vPosition;
      void main()
      {
          gl_Position = vPosition * gl_ProjectionMatrix;
      }
      </script>
      <script id="vshaderWithAttributeArray" type="text/something-not-javascript">
      attribute vec4 vPosition[2];
      void main()
      {
          gl_Position = vPosition[0] + vPosition[1];
      }
      </script>
      <script id="vshaderWithwebgl_" type="text/something-not-javascript">
      attribute vec4 webgl_vPosition;
      void main()
      {
          gl_Position = webgl_vPosition;
      }
      </script>
      <script id="vshaderWith_webgl_" type="text/something-not-javascript">
      attribute vec4 _webgl_vPosition;
      void main()
      {
          gl_Position = _webgl_vPosition;
      }
      </script>
      <script id="vshaderWithImplicitVec3Cast" type="text/something-not-javascript">
      attribute vec4 vPosition;
      void main()
      {
          highp vec3 k = vec3(1, 2, 3);
          gl_Position = k;
      }
      </script>
      <script id="vshaderWithExplicitIntCast" type="text/something-not-javascript">
      attribute vec4 vPosition;
      void main()
      {
          int k = 123;
          gl_Position = vec4(vPosition.x, vPosition.y, vPosition.z, float(k));
      }
      </script>
      <script id="vshaderWithVersion130" type="text/something-not-javascript">
#version 130
      attribute vec4 vPosition;
      void main()
      {
          gl_Position = vPosition;
      }
      </script>
      <script id="vshaderWithVersion120" type="text/something-not-javascript">
#version 120
      attribute vec4 vPosition;
      void main()
      {
          gl_Position = vPosition;
      }
      </script>
      <script id="vshaderWithVersion100" type="text/something-not-javascript">
#version 100
      attribute vec4 vPosition;
      void main()
      {
          gl_Position = vPosition;
      }
      </script>
      <script id="vshaderWith__FILE__" type="text/something-not-javascript">
      __FILE__
      </script>
      <canvas id="canvas" width="2" height="2"> </canvas>
      <div>PASS</div>
      ''', treeSanitizer: new NullTreeSanitizer());


  debug("Canvas.getContext");

  wtu.loggingOff();
  var gl = wtu.create3DContext(document.getElementById("canvas"));
  if (gl == null) {
    testFailed("context does not exist");
  } else {
    testPassed("context exists");

    debug("");
    debug("Checking various GLSL programs.");

    log(msg) {
      //window.console.log(msg);
    }

    var shaderInfo = [
      { 'vShaderId': 'vshader',
        'vShaderSuccess': true,
        'fShaderId': 'fshaderWithPrecision',
        'fShaderSuccess': true,
        'linkSuccess': true,
        'passMsg': 'frament shader with precision compiled and linked'
      },
      { 'vShaderId': 'vshader',
        'vShaderSuccess': true,
        'fShaderId': 'fshaderWithDefaultPrecision',
        'fShaderSuccess': true,
        'linkSuccess': true,
        'passMsg': 'fragment shader with default precision compiled and linked'
      },
      { 'vShaderId': 'vshaderWithDefaultPrecision',
        'vShaderSuccess': true,
        'fShaderId': 'fshader',
        'fShaderSuccess': true,
        'linkSuccess': true,
        'passMsg': 'vertex shader with default precision compiled and linked'
      },
      { 'vShaderId': 'vshader',
        'vShaderSuccess': true,
        'fShaderId': 'fshaderWithOutPrecision',
        'fShaderSuccess': false,
        'linkSuccess': false,
        'passMsg': 'fragment shader without precision should fail',
      },
      { 'vShaderId': 'vshader',
        'vShaderSuccess': true,
        'fShaderId': 'fshaderWithInvalidIdentifier',
        'fShaderSuccess': false,
        'linkSuccess': false,
        'passMsg': 'fragment shader with gl_ identifier should fail',
      },
      { 'vShaderId': 'vshader',
        'vShaderSuccess': true,
        'fShaderId': 'fshaderWithGL_ESeq1',
        'fShaderSuccess': true,
        'linkSuccess': true,
        'passMsg': 'fragment shader that expects GL_ES == 1 should succeed',
      },
      { 'vShaderId': 'vshader',
        'vShaderSuccess': true,
        'fShaderId': 'fshaderWithGLSLPreprocessorSymbol',
        'fShaderSuccess': true,
        'linkSuccess': true,
        'passMsg': 'fragment shader that uses GL_ES preprocessor symbol should succeed',
      },
      { 'vShaderId': 'vshader',
        'vShaderSuccess': true,
        'fShaderId': 'fshaderWithVERSION100PreprocessorSymbol',
        'fShaderSuccess': true,
        'linkSuccess': true,
        'passMsg': 'fragment shader that uses __VERSION__==100 should succeed',
      },
      { 'vShaderId': 'vshader',
        'vShaderSuccess': true,
        'fShaderId': 'fshaderWithFragDepth',
        'fShaderSuccess': false,
        'linkSuccess': false,
        'passMsg': 'fragment shader that uses gl_FragDepth should fail',
      },
      { 'vShaderId': 'vshaderWithClipVertex',
        'vShaderSuccess': false,
        'fShaderId': 'fshader',
        'fShaderSuccess': true,
        'linkSuccess': false,
        'passMsg': 'vertex shader that uses gl_ClipVertex should fail',
      },
      //{ 'vShaderId': 'vshader',
      //  'vShaderSuccess': true,
      //  'fShaderId': 'fshaderWith__Define',
      //  'fShaderSuccess': false,
      //  'linkSuccess': false,
      //  'passMsg': 'fragment shader that uses __ define should fail',
      //},
      //{ 'vShaderId': 'vshader',
      //  'vShaderSuccess': true,
      //  'fShaderId': 'fshaderWithGL_Define',
      //  'fShaderSuccess': false,
      //  'linkSuccess': false,
      //  'passMsg': 'fragment shader that uses GL_ define should fail',
      //},
      { 'vShaderId': 'vshader',
        'vShaderSuccess': true,
        'fShaderId': 'fshaderWithDefineLineContinuation',
        'fShaderSuccess': false,
        'linkSuccess': false,
        'passMsg': 'fragment shader that uses has line continuation macro should fail',
      },
      { 'vShaderId': 'vshaderWithgl_Color',
        'vShaderSuccess': false,
        'fShaderId': 'fshader',
        'fShaderSuccess': true,
        'linkSuccess': false,
        'passMsg': 'vertex shader that uses gl_Color should fail',
      },
      { 'vShaderId': 'vshaderWithgl_ProjectionMatrix',
        'vShaderSuccess': false,
        'fShaderId': 'fshader',
        'fShaderSuccess': true,
        'linkSuccess': false,
        'passMsg': 'vertex shader that uses gl_ProjectionMatrix should fail',
      },
      { 'vShaderId': 'vshaderWithAttributeArray',
        'vShaderSuccess': false,
        'fShaderId': 'fshader',
        'fShaderSuccess': true,
        'linkSuccess': false,
        'passMsg': 'vertex shader that uses attribute array should fail as per GLSL page 110, appendix A, section 5',
      },
      { 'vShaderId': 'vshaderWithwebgl_',
        'vShaderSuccess': false,
        'fShaderId': 'fshader',
        'fShaderSuccess': true,
        'linkSuccess': false,
        'passMsg': 'vertex shader that uses _webgl identifier should fail',
      },
      { 'vShaderId': 'vshaderWith_webgl_',
        'vShaderSuccess': false,
        'fShaderId': 'fshader',
        'fShaderSuccess': true,
        'linkSuccess': false,
        'passMsg': 'vertex shader that uses _webgl_ identifier should fail',
      },
      { 'vShaderId': 'vshaderWithExplicitIntCast',
        'vShaderSuccess': true,
        'fShaderId': 'fshader',
        'fShaderSuccess': true,
        'linkSuccess': true,
        'passMsg': 'vertex shader that explicit int to float cast should succeed',
      },
      { 'vShaderId': 'vshaderWithImplicitVec3Cast',
        'vShaderSuccess': false,
        'fShaderId': 'fshader',
        'fShaderSuccess': true,
        'linkSuccess': false,
        'passMsg': 'vertex shader that implicit vec3 to vec4 cast should fail',
      },
      { 'vShaderId': 'vshaderWithVersion130',
        'vShaderSuccess': false,
        'fShaderId': 'fshader',
        'fShaderSuccess': true,
        'linkSuccess': false,
        'passMsg': 'vertex shader uses the #version not 100 directive should fail',
      },
      { 'vShaderId': 'vshaderWithVersion120',
        'vShaderSuccess': false,
        'fShaderId': 'fshader',
        'fShaderSuccess': true,
        'linkSuccess': false,
        'passMsg': 'vertex shader uses the #version not 100 directive should fail',
      },
      { 'vShaderId': 'vshaderWithVersion100',
        'vShaderSuccess': true,
        'fShaderId': 'fshader',
        'fShaderSuccess': true,
        'linkSuccess': true,
        'passMsg': 'vertex shader uses the #version 100 directive should succeed',
      },
    ];

    // Read in all the shader source.
    for (var ii = 0; ii < shaderInfo.length; ++ii) {
      var si = shaderInfo[ii];
      si['vShaderSource'] = document.getElementById(si['vShaderId']).text;
      si['fShaderSource'] = document.getElementById(si['fShaderId']).text;
    }

    // Add more tests from external file
    var simpleVertShader = document.getElementById('vshader').text;
    var simpleFragShader = document.getElementById('fshader').text;

    addExternalShaders(filename, [passMsg='']) {
      var files = wtu.readFileList(filename);
      for (var ii = 0; ii < files.length; ++ii) {
        var file = files[ii];
        var shaderSource = wtu.readFile(file);
        var firstLine = shaderSource.split(new RegExp(r"\n"))[0];
        var success;
        if (wtu.endsWith(firstLine, " fail") ||
            wtu.endsWith(firstLine, " fail.")) {
          success = false;
        } else if (wtu.endsWith(firstLine, " succeed") ||
                   wtu.endsWith(firstLine, " succeed.")) {
          success = true;
        }
        if (success == null) {
          testFailed("bad first line in " + file);
          continue;
        }
        if (!wtu.startsWith(firstLine, "// ")) {
          testFailed("bad first line in " + file);
          continue;
        }
        var passMsg = firstLine.substring(3);
        if (wtu.endsWith(file, ".vert")) {
          shaderInfo.add({
              'vShaderId': file,
              'vShaderSource': shaderSource,
              'vShaderSuccess': success,
              'fShaderId': 'fshader',
              'fShaderSource': simpleFragShader,
              'fShaderSuccess': true,
              'linkSuccess': success,
              'passMsg': passMsg,
            });
        } else if (wtu.endsWith(file, ".frag")) {
          shaderInfo.add({
              'vShaderId': 'vshader',
              'vShaderSource': simpleVertShader,
              'vShaderSuccess': true,
              'fShaderId': file,
              'fShaderSource': shaderSource,
              'fShaderSuccess': success,
              'linkSuccess': success,
              'passMsg': passMsg,
            });
        }
      }
    }

    addExternalShaders('$root/shaders/00_shaders.txt');

    for (var ii = 0; ii < shaderInfo.length; ++ii) {
      var info = shaderInfo[ii];
      var vShaderId = info['vShaderId'];
      var fShaderId = info['fShaderId'];
      var passMsg = info['passMsg'];
      var vShaderSource = info['vShaderSource'];
      var vShaderTest = info['vShaderTest'];
      var vShaderSuccess = info['vShaderSuccess'];
      var fShaderSource = info['fShaderSource'];
      var fShaderSuccess = info['fShaderSuccess'];
      var linkSuccess = info['linkSuccess'];

      passMsg = '[' + vShaderId + '/' + fShaderId + ']: ' + passMsg;
      log(passMsg);
      //debug(fShaderId);
      var vShader = wtu.loadShader(gl, vShaderSource, wgl.VERTEX_SHADER);
      if (vShaderTest != null) {
        if (!vShaderTest(vShader)) {
          testFailed(passMsg);
          continue;
        }
      }
      if ((vShader != null) != vShaderSuccess) {
        testFailed(passMsg);
        continue;
      }
      var fShader = wtu.loadShader(gl, fShaderSource, wgl.FRAGMENT_SHADER);
      //debug(fShader == null ? "fail" : "succeed");
      if ((fShader != null) != fShaderSuccess) {
        testFailed(passMsg);
        continue;
      }

      if (vShader != null && fShader != null) {
        var program = gl.createProgram();
        gl.attachShader(program, vShader);
        gl.attachShader(program, fShader);
        gl.linkProgram(program);
        var linked = gl.getProgramParameter(program, wgl.LINK_STATUS);
        if (!linked) {
          var error = gl.getProgramInfoLog(program);
          log("*** Error linking program: $error");
        }
        if (linked != linkSuccess) {
          testFailed(passMsg);
          continue;
        }
      } else {
        if (linkSuccess) {
          testFailed(passMsg);
          continue;
        }
      }
      testPassed(passMsg);
    }
  }
}
