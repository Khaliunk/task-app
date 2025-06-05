import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';

dateFormat(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

Future<bool> checkInternetConnection() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  
  return connectivityResult.contains(ConnectivityResult.mobile) ||
         connectivityResult.contains(ConnectivityResult.wifi);
}
  
