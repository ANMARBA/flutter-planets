import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_planets/core/domain/repositories/network_repository.dart';
import 'package:flutter_planets/core/shared/constants/http_status_codes.dart';

class NetworkInfoRepositoryImpl extends NetworkInfoRepository {
  @override
  Future<bool> get hasConnection async {
    final connectivityResults = await Connectivity().checkConnectivity();

    if (connectivityResults.isNotEmpty &&
        connectivityResults.any((result) =>
            result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi ||
            result == ConnectivityResult.ethernet ||
            result == ConnectivityResult.bluetooth ||
            result == ConnectivityResult.vpn ||
            result == ConnectivityResult.other)) {
      try {
        final response =
            await http.get(Uri.parse('https://www.google.com')).timeout(
                  const Duration(seconds: 5),
                );
        if (response.statusCode == HttpStatusCodes.ok) {
          return true;
        } else {
          return false;
        }
      } catch (_) {
        return false;
      }
    }

    return false;
  }
}
