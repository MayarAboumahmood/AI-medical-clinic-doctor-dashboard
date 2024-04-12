import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheService {
  late final CacheManager _cacheManager;

  CacheService(String cacheKey) {
    _cacheManager = CacheManager(
      Config(
        cacheKey, // Cache key
        stalePeriod: const Duration(days: 7), // Adjust as needed
        maxNrOfCacheObjects: 100,
        repo: JsonCacheInfoRepository(databaseName: cacheKey),
        fileService: HttpFileService(),
      ),
    );
  }

  Future<void> cacheObject<T>({
    required T object,
    required String cacheKey,
    required Function(T) serializeFunction,
  }) async {
    String jsonString = jsonEncode(serializeFunction(object));
    await _cacheManager.putFile(
      cacheKey,
      Uint8List.fromList(utf8.encode(jsonString)),
      eTag: object
          .toString(), // You might want to use a more unique identifier here
    );
  }

  Future<T?> getObject<T>({
    required String cacheKey,
    required Function(Map<String, dynamic>) deserializeFunction,
  }) async {
    FileInfo? fileInfo = await _cacheManager.getFileFromCache(cacheKey);
    if (fileInfo != null) {
      String jsonString = utf8.decode(await fileInfo.file.readAsBytes());
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return deserializeFunction(jsonMap);
    }
    return null;
  }
}
