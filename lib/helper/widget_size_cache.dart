import 'package:flutter/material.dart';

class WidgetSizeCache {
  final Map<String, Size> _cache = {};

  Size? get(String key) => _cache[key];
  void put(String key, Size size) => _cache[key] = size;
  void remove(String key) => _cache.remove(key);
  int getSize() => _cache.length;

  void clear() => _cache.clear();
  @override
  String toString() => _cache.toString();
}
