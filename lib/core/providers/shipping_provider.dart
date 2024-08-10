import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shipping_app/core/models/distancematrix_model.dart';
import 'package:shipping_app/core/services/map_service.dart';

//Original location providers
final originalLocationProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

final originalLocationLATLNGProvider = StateProvider<LatLng?>((ref) {
  return null;
});

//Destination location providers
final destinationLocationProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

final destinationLocationLATLNGProvider = StateProvider<LatLng?>((ref) {
  return null;
});

// Controller for shipping
final shippingControllerProvider =
    AsyncNotifierProvider<ShippingController, DistanceMatrixModel?>(() {
  return ShippingController();
});

class ShippingController extends AsyncNotifier<DistanceMatrixModel?> {
  @override
  FutureOr<DistanceMatrixModel?> build() {
    return null;
  }

  // Calculate shipping cost
  Future<void> calculate(
    LatLng origin,
    LatLng destination,
    double weight,
  ) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () async {
        return MapService().calculateDistance(origin, destination, weight);
      },
    );
  }
}
