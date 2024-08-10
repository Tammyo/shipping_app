import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shipping_app/utils/utils.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.image,
    super.key,
    this.controller,
    this.hint,
    this.autofocus = false,
    this.isReadOnly = false,
    this.type = TextInputType.text,
    this.inputFormatters,
  });

  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? hint;
  final String image;
  final bool autofocus;
  final bool isReadOnly;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1.2,
          color: const Color(
            0xffE6E8ED,
          ),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            image,
            width: 25,
            height: 25,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 1),
              child: TextField(
                controller: controller,
                autofocus: autofocus,
                keyboardType: type,
                readOnly: isReadOnly,
                inputFormatters: inputFormatters,
                style: const TextStyle(
                  color: Color(0xff272553),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
                decoration: InputDecoration(
                  labelText: hint,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  labelStyle: TextStyle(
                    color: const Color(0xff272553).withOpacity(0.9),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
