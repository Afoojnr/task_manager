import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final bool hasIcon;
  final String label;
  final VoidCallback onPressed;
  const CustomBtn(
      {super.key,
      required this.label,
      this.hasIcon = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: themeColor.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            fixedSize: const Size.fromHeight(55)),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hasIcon
                ? Icon(
                    Icons.add,
                    color: themeColor.onPrimary,
                  )
                : const SizedBox.shrink(),
            hasIcon ? const SizedBox(width: 8) : const SizedBox.shrink(),
            Text(
              label,
              style: TextStyle(color: themeColor.onPrimary),
            )
          ],
        ));
  }
}
