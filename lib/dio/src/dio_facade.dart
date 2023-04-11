import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:wordle/core/core.dart';

import 'dio_response/dio_response.dart';
import 'errors/no_internet_dio_error.dart';

export 'package:dio/dio.dart';

/// Class-wrapper for configured [Dio] instance.
///
/// If you need to get access to REST API with URL and contentType set in
/// [ConfigConstants] class, use this facade to perform GET and POST requests.
///
/// [get] and [post] methods results wrapped in [Result] class for convenience
/// so you don't have to check every time if response data is a [Map] or not and
/// also don't have to use try..catch clauses
///
class DioFacade {
  DioFacade({
    String? method,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    String baseUrl = '',
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? extra,
    Map<String, dynamic>? headers,
    ResponseType? responseType = ResponseType.json,
    String? contentType,
    bool Function(int?)? validateStatus,
    bool? receiveDataWhenStatusError,
    bool? followRedirects,
    int? maxRedirects,
    bool? persistentConnection,
    List<Interceptor> interceptors = const [],
  }) : _dio = Dio(
          BaseOptions(
            method: method,
            connectTimeout: connectTimeout,
            receiveTimeout: receiveTimeout,
            sendTimeout: sendTimeout,
            baseUrl: baseUrl,
            queryParameters: queryParameters,
            extra: extra,
            headers: headers,
            responseType: responseType,
            contentType: contentType,
            validateStatus: validateStatus,
            receiveDataWhenStatusError: receiveDataWhenStatusError,
            followRedirects: followRedirects,
            maxRedirects: maxRedirects,
            persistentConnection: persistentConnection,
          ),
        )..interceptors.addAll(interceptors);

  final Dio _dio;

  bool _isInitialized = false;

  Future<void> initialize() {
    return Future.sync(
      () async {
        if (!_isInitialized) {
          _configureDio();

          _isInitialized = true;
        }
      },
    );
  }

  Future<DioResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int count, int total)? onReceiveProgress,
  }) async {
    return _requestWrapper(
      () => _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  Future<DioResponse> post(
    String path, {
    Options? options,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    void Function(int count, int total)? onSendProgress,
    void Function(int count, int total)? onReceiveProgress,
  }) async {
    return _requestWrapper(
      () => _dio.post(
        path,
        options: options,
        data: body,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  void removeInterceptorOfType(Type interceptorType) {
    _dio.interceptors.removeWhere(
      (element) => element.runtimeType == interceptorType,
    );
  }

  void _configureDio() {
    _removeBadCertificateException();
  }

  /// Needed to avoid [CERTIFICATE_VERIFY_FAILED] for test server if test
  /// server has no certificate
  ///
  void _removeBadCertificateException() {
    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) =>
          true;

      return client;
    };
  }

  Future<DioResponse> _requestWrapper(
    Future<Response> Function() request,
  ) async {
    try {
      final Response response = await request();

      final formattedResponse = Response<dynamic>(
        requestOptions: response.requestOptions,
        extra: response.extra,
        redirects: response.redirects,
        headers: response.headers,
        isRedirect: response.isRedirect,
        data: response.data,
        statusMessage: response.statusMessage,
        statusCode: response.statusCode,
      );

      return DioResponse.successful(formattedResponse);
    } on TimeoutException {
      return DioResponse.failed(const DioFailure.timeout());
    } on DioError catch (e, st) {
      return DioResponse.failed(_getDioFailure(e, st));
    } on Exception catch (e, st) {
      return DioResponse.failed(
        DioFailure.unknown(FailureInformation(error: e, trace: st)),
      );
    }
  }

  DioFailure _getDioFailure(DioError e, StackTrace trace) {
    if (e is NoInternetDioError) {
      return const DioFailure.noInternet();
    }

    switch (e.type) {
      case DioErrorType.receiveTimeout:
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
        return const DioFailure.timeout();

      case DioErrorType.cancel:
      case DioErrorType.unknown:
      case DioErrorType.badCertificate:
      case DioErrorType.connectionError:
        return DioFailure.unknown(FailureInformation(error: e, trace: trace));

      case DioErrorType.badResponse:
        return DioFailure.badResponse(e.response!);
    }
  }
}
