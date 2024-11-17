import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

HiveCacheStore? cacheStore;
CacheOptions? cacheOptions;

class DioHelper {
  static final _singleton = DioHelper._();

  factory DioHelper() => _singleton;

  DioHelper._();

  final Dio _dio = Dio();
  Future<void> init() async {
    _dio.options.baseUrl = 'https://pokeapi.co/api/v2/';
    _dio.options.headers = {
      Headers.acceptHeader: Headers.jsonContentType,
      HttpHeaders.acceptEncodingHeader: 'gzip',
    };
    _addCacheInterceptor();
    _addLogInterceptor();
    _addRetryInterceptor();
  }

  Future<Response> get(String path, {bool forceRefresh = false}) async {
    final resp = await _dio.get(
      path,
      options: forceRefresh
          ? cacheOptions
              ?.copyWith(policy: CachePolicy.refreshForceCache)
              .toOptions()
          : cacheOptions?.toOptions(),
    );
    return resp;
  }

  Future<Response> post(String path, dynamic data) async {
    return await _dio.post(path, data: data);
  }

  Future<Response> put(String path, dynamic data) async {
    return await _dio.put(path, data: data);
  }

  Future<Response> delete(String path) async {
    return await _dio.delete(path);
  }

  Future<void> _addLogInterceptor() async {
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<void> _addCacheInterceptor() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    cacheStore = HiveCacheStore(tempPath);
    cacheOptions = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.forceCache,
      hitCacheOnErrorExcept: [],
      maxStale: const Duration(days: 7),
      priority: CachePriority.high,
      cipher: null,
      keyBuilder: (request) {
        final uri = request.uri;
        return uri.toString();
      },
    );
    if (cacheOptions != null) {
      _dio.interceptors.add(DioCacheInterceptor(options: cacheOptions!));
    }
  }

  Future<void> _addRetryInterceptor() async {
    final retryInterceptor = RetryInterceptor(
      dio: _dio,
      options: RetryOptions(
        retries: 3,
        retryInterval: const Duration(seconds: 1),
        retryEvaluator: (error) =>
            error.type == DioExceptionType.connectionError ||
            error.type == DioExceptionType.connectionTimeout,
      ),
    );

    _dio.interceptors.add(retryInterceptor);
  }
}

class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required this.dio,
    required this.options,
  });

  final Dio dio;
  final RetryOptions options;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final extra = err.requestOptions.extra;
    final retries = extra['retries'] ?? 0;

    if (retries < options.retries && options.retryEvaluator(err)) {
      final newRetries = retries + 1;
      err.requestOptions.extra['retries'] = newRetries;
      await Future.delayed(options.retryInterval);
      try {
        final response = await dio.request(
          err.requestOptions.path,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
            extra: err.requestOptions.extra,
          ),
        );
        handler.resolve(response);
      } catch (e) {
        handler.next(e as DioException);
      }
    } else {
      handler.next(err);
    }
  }
}

class RetryOptions {
  RetryOptions({
    required this.retries,
    required this.retryInterval,
    required this.retryEvaluator,
  });

  final int retries;
  final Duration retryInterval;
  final bool Function(DioException error) retryEvaluator;
}
