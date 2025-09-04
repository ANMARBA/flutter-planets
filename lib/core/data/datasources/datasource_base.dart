import 'dart:async';
import 'dart:io';

import 'package:flutter_planets/core/domain/entities/exceptions.dart';
import 'package:flutter_planets/core/shared/constants/constants.dart';

/// Class with reusable methods to use in the data source layer
class DataSourceBase<T> {
  /// Generic method that handles common exceptions when making a request
  /// even server [T] type of data to return in the request
  /// [call] the function that will perform the request
  Future<T> serverRequest({required Future<T> Function() call}) async {
    try {
      return await call();
    } on SocketException catch (e) {
      throw ServerException(message: e.message);
    } on TimeoutException catch (e) {
      throw ServerException(message: e.message ?? Constants.error);
    } catch (e) {
      rethrow;
    }
  }
}
