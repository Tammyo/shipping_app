import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shipping_app/core/providers/shipping_provider.dart';
import 'package:shipping_app/utils/utils.dart';
import 'package:shipping_app/widgets/widgets.dart';

class ShippingPage extends HookConsumerWidget {
  const ShippingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationController = ref.watch(originalLocationProvider);
    final destinationController = ref.watch(destinationLocationProvider);
    final packageWeightController = useTextEditingController();
    final state = ref.watch(shippingControllerProvider);

    return GestureDetector(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF95DFFF).withOpacity(0.25),
                  blurRadius: 10,
                  offset: const Offset(3, 2),
                )
              ],
            ),
            child: AppBar(
              titleSpacing: 7,
              title: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SubText(
                        text: 'Your Location:',
                      ),
                      HeaderText(
                        text: 'Lagos, Nigeria',
                        textSize: 20,
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                Container(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.only(right: 17, top: 10),
                  decoration: const BoxDecoration(
                    color: Color(
                      0xff242424,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderText(
                      text: 'Shipping Details',
                      foreground: Color(0xff080539),
                    ),
                    const SubText(
                      text:
                          'Please enter correct shipping details. Click location icon to select location.',
                      foreground: Color(
                        0xff242424,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const HeaderText(
                      text: 'Location',
                      foreground: Color(0xff272553),
                      textSize: 20,
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () => showOriginalMapSelector(context, ref),
                      child: InputField(
                        image: ImageAssets.locationIcon,
                        hint: 'Original Location',
                        isReadOnly: true,
                        controller: locationController,
                      ),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () => showDestinationMapSelector(context, ref),
                      child: InputField(
                        image: ImageAssets.locationIcon,
                        hint: 'Destination Location',
                        isReadOnly: true,
                        controller: destinationController,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: kPrimaryBlack,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.infoIcon,
                            width: 27,
                            height: 27,
                          ),
                          const SizedBox(width: 7),
                          const SubText(
                            text: r'Cost per package is $1.00 per kilometer',
                            foreground: white,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    const HeaderText(
                      text: 'Package Details',
                      foreground: Color(0xff272553),
                      textSize: 20,
                    ),
                    const SizedBox(height: 15),
                    InputField(
                      image: ImageAssets.bagIcon,
                      hint: 'Package Weight (kg)',
                      controller: packageWeightController,
                      type: TextInputType.number,
                    ),
                    const SizedBox(height: 27),
                    DefaultButton(
                      title: 'Calculate Cost',
                      busy: state.isLoading,
                      onPressed: () {
                        final origin = ref.read(originalLocationLATLNGProvider);
                        final destination =
                            ref.read(destinationLocationLATLNGProvider);

                        final weight =
                            double.tryParse(packageWeightController.text);
                        if (origin != null &&
                            destination != null &&
                            weight != null) {
                          ref
                              .read(shippingControllerProvider.notifier)
                              .calculate(
                                origin,
                                destination,
                                weight,
                              );
                        }
                      },
                    ),
                  ],
                ),
              ),
              state.when(
                data: (data) {
                  if (data == null) return const SizedBox();

                  final deliveryTime =
                      data.rows![0].elements![0].duration!.text!;

                  final meters = data.rows![0].elements![0].distance!.value!;

                  final shippingCost = getShippingCost(meters);

                  final packageWeight = data.weight;

                  return Column(
                    children: [
                      const SizedBox(height: 27),
                      Divider(
                        color: black.withOpacity(0.1),
                        thickness: 0.8,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 85,
                              decoration: BoxDecoration(
                                color: const Color(0xffFCEED3),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.all(17),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SubText(
                                        text: 'Delivery Time:',
                                        foreground: Color(0xff7B7A79),
                                      ),
                                      SubText(
                                        text: deliveryTime,
                                        foreground: const Color(0xff101A12),
                                        fontWeight: FontWeight.w600,
                                        textSize: 17,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 1.2,
                                    height: 50,
                                    color: black.withOpacity(0.08),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const SubText(
                                        text: 'Package weight:',
                                        foreground: Color(0xff7B7A79),
                                      ),
                                      SubText(
                                        text: '${packageWeight}kg',
                                        foreground: const Color(0xff101A12),
                                        fontWeight: FontWeight.w600,
                                        textSize: 17,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SubText(
                                    text: 'Total shipping cost',
                                    textSize: 16,
                                    foreground: kPrimaryBlack.withOpacity(0.6),
                                  ),
                                  HeaderText(
                                    text: '\$$shippingCost',
                                    textSize: 19,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            DefaultButton(
                              title: 'Proceed with shipping',
                              onPressed: () {},
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                error: (error, stackTrace) => const SizedBox(),
                loading: () => const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const LatLng _kMapCenter =
      LatLng(6.452259891075759, 3.3938309177756314);
  static const CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 14);

  void showOriginalMapSelector(
    BuildContext context,
    WidgetRef ref,
  ) {
    CameraPosition? cameraPosition;
    Helpers.openExpandableBottomSheet(
      title: 'Select original location',
      children: [
        const SizedBox(height: 20),
        SizedBox(
          height: 300,
          child: Stack(
            children: [
              GoogleMap(
                myLocationEnabled: true,
                initialCameraPosition: _kInitialPosition,
                onCameraMove: (position) {
                  cameraPosition = position;
                },
                onCameraIdle: () async {},
              ),
              const Center(
                //picker image on google map
                child: Icon(
                  Icons.location_pin,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        DefaultButton(
          title: 'Done',
          onPressed: () async {
            if (cameraPosition != null) {
              final placemarks = await placemarkFromCoordinates(
                cameraPosition!.target.latitude,
                cameraPosition!.target.longitude,
              );

              ref.read(originalLocationLATLNGProvider.notifier).state = LatLng(
                cameraPosition!.target.latitude,
                cameraPosition!.target.longitude,
              );

              ref.read(originalLocationProvider.notifier).state.text =
                  '${placemarks.first.administrativeArea}, ${placemarks.first.street}';
              Navigator.pop(context);
            }
          },
        ),
      ],
      context: context,
    );
  }

  void showDestinationMapSelector(
    BuildContext context,
    WidgetRef ref,
  ) {
    CameraPosition? cameraPosition;
    Helpers.openExpandableBottomSheet(
      title: 'Select original location',
      children: [
        const SizedBox(height: 20),
        SizedBox(
          height: 300,
          child: Stack(
            children: [
              GoogleMap(
                myLocationEnabled: true,
                initialCameraPosition: _kInitialPosition,
                onCameraMove: (position) {
                  cameraPosition = position;
                },
                onCameraIdle: () async {},
              ),
              const Center(
                //picker image on google map
                child: Icon(
                  Icons.location_pin,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        DefaultButton(
          title: 'Done',
          onPressed: () async {
            if (cameraPosition != null) {
              final placemarks = await placemarkFromCoordinates(
                cameraPosition!.target.latitude,
                cameraPosition!.target.longitude,
              );
              ref.read(destinationLocationLATLNGProvider.notifier).state =
                  LatLng(
                cameraPosition!.target.latitude,
                cameraPosition!.target.longitude,
              );

              ref.read(destinationLocationProvider.notifier).state.text =
                  '${placemarks.first.administrativeArea}, ${placemarks.first.street}';
              Navigator.pop(context);
            }
          },
        ),
      ],
      context: context,
    );
  }

  String getShippingCost(int meters) {
    final kilometers = meters / 1000;
    return (kilometers * 1).toStringAsFixed(2);
  }
}
