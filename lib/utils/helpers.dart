import 'package:flutter/material.dart';
import 'package:shipping_app/utils/utils.dart';

import 'package:shipping_app/widgets/widgets.dart';

class Helpers {
  static void openExpandableBottomSheet({
    required String title,
    required List<Widget> children,
    required BuildContext context,
    Widget? titleTailing,
    Color backgroundColor = Colors.transparent,
    double? textSize,
  }) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      enableDrag: false,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext buildContext) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Wrap(
            children: <Widget>[
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 770),
                child: Container(
                  decoration: const BoxDecoration(
                    color: white,
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 21, 10, 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SubText(
                              text: title,
                              foreground: kTextColor.withOpacity(0.8),
                              textSize: textSize ?? 16,
                              fontWeight: FontWeight.w600,
                            ),
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.close_rounded,
                                color: kTextColor.withOpacity(0.6),
                                size: 30,
                              ),
                            )
                          ],
                        ),
                        ListView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          children: children,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
