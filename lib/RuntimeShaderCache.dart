import 'dart:ui';

abstract class RuntimeShaderCache {
  FragmentProgram? getCachedShader(String key);
  void requestShader(String key, void Function() onLoaded);
}

class RuntimeShaderCacheImpl implements RuntimeShaderCache {
  final Map<String, FragmentProgram> _runtimeShaders = {};
  final Set<String> _loadingShaders = {};

  @override
  FragmentProgram? getCachedShader(String key) {
    return _runtimeShaders[key];
  }

  @override
  void requestShader(String key, void Function() onLoaded) {
    if (_runtimeShaders.containsKey(key)) {
      onLoaded();
      return;
    }
    if (_loadingShaders.contains(key)) return;

    _loadingShaders.add(key);
    FragmentProgram.fromAsset(key).then((program) {
      _runtimeShaders[key] = program;
      _loadingShaders.remove(key);
      onLoaded();
    }).catchError((e) {
      _loadingShaders.remove(key);
      print('Failed to load shader: $key. Error: $e');
    });
  }

  void clear() {
    _runtimeShaders.clear();
    _loadingShaders.clear();
  }
}