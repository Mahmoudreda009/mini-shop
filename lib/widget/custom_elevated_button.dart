import 'package:flutter/material.dart';
import 'package:mini_shop/ui/utils/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool outlined;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                outlined ? Colors.transparent : AppColors.blue,
              ),
              foregroundColor: MaterialStateProperty.all(
                outlined ? AppColors.blue : Colors.white,
              ),
              overlayColor:
              MaterialStateProperty.all(Colors.transparent),
              padding:
              MaterialStateProperty.all(const EdgeInsets.all(14)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: outlined
                      ? const BorderSide(color: AppColors.blue, width: 1.5)
                      : BorderSide.none,
                ),
              ),
              elevation: MaterialStateProperty.all(0),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
