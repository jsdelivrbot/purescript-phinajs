//-----------------------------------------------------------------------------
// Phina.Display.DisplayScene

/* global phina */

var exit = function(params) {
  return function(scene) {
    return function() {
      scene.exit(params);
      return scene;
    };
  };
};

exports.exit = exit;

exports._popup = function(s, params, scene) {
  var klass;

  if ((klass = getClass(s.baseClass)) == null) {
    if ((klass = phina.display[s.baseClass]) == null) {
      if ((klass = phina.game[s.baseClass]) == null) {
        throw Error('Scene ' + s.baseClass + ' is not found.');
      }
    }
  }

  return function(callback) {
    return function() {
      var func = function() {
        scene.one('resume', function(r) {
          callback(r.prevScene.nextArguments)();
        });

        var sceneParams = {};

        if (scene['scene params'] != null) {
          copyProps(scene['scene params'], sceneParams);
        }
        copyProps(params, sceneParams);

        var newScene = klass(sceneParams);
        newScene['scene params'] = sceneParams;

        scene.app.pushScene(s.setup(params)(exit)(newScene)());

        return;
      };

      scene.app != null ? func() : scene.on('enter', func);

      return {};
    };
  };
};

exports._onKeyDown = function(func, scene) {
  return scene.on('keydown', function(key) {
    return func(key.keyCode)(this)();
  });
};

exports._onKeyUp = function(func, scene) {
  return scene.on('keyup', function(key) {
    return func(key.keyCode)(this)();
  });
};

exports._onKeyPress = function(func, scene) {
  return scene.on('keypress', function(key) {
    return func(key.keyCode)(this)();
  });
};

var getClass = function(path) {
  return path.split(/[,./ ]|::/).reduce(
    function(c, a) {
      return c != null ? c[a] : null;
    },
    phina.global
  );
};

var copyProps = function(src, dest) {
  var own = Object.prototype.hasOwnProperty;

  for (var key in src) {
    if (own.call(src, key)) {
      dest[key] = src[key];
    }
  }

  return dest;
};
