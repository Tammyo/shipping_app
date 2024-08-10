import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shipping_app/core/models/distancematrix_model.dart';
import 'package:shipping_app/core/services/storage_service.dart';

class MapService {
  ///Calculates distance using Google distance matrix API and adds weight value to response
  Future<DistanceMatrixModel> calculateDistance(
    LatLng origin,
    LatLng destination,
    double weight,
  ) async {
    final apiKey = dotenv.env['API_KEY']!;
    final apiUrl =
        'https://maps.googleapis.com/maps/api/distancematrix/json?origins=${origin.latitude},${origin.longitude}&destinations=${destination.latitude},${destination.longitude}&key=$apiKey';

    final response = await Dio().get(apiUrl);

    // Don't wait
    unawaited(StorageService().saveShippingData(json.encode(response.data)));

    return DistanceMatrixModel.fromJson(response.data)..weight = weight;
  }
}
