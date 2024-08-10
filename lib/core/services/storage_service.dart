import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _data = 'shipping_data';

  ///Method to save shipping data
  Future<bool> saveShippingData(String shippingData) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setString(_data, shippingData);
  }

  ///Method to retrieve shipping data
  Future<String?> getShippingData() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_data);
  }
}
