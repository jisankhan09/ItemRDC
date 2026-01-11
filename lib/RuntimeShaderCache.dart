import 'dart:ui';

abstract class RuntimeShaderCache {
  Future<FragmentProgram> obtainRuntimeShader(String key);
}

class RuntimeShaderCacheImpl implements RuntimeShaderCache {
  final Map<String, FragmentProgram> _runtimeShaders = {};

  @override
  Future<FragmentProgram> obtainRuntimeShader(String key) async {
    if (_runtimeShaders.containsKey(key)) {
      return _runtimeShaders[key]!;
    }
    try {
      final program = await FragmentProgram.fromAsset(key);
      _runtimeShaders[key] = program;
      return program;
    } catch (e) {
      throw Exception('Failed to load shader: $key. Error: $e');
    }
  }

  void clear() {
    _runtimeShaders.clear();
  }
}
