import 'package:flutter/material.dart';

import 'package:shipping_app/utils/utils.dart';
import 'package:shipping_app/views/shipping_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shipping App',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const ShippingPage(),
    );
  }
}
