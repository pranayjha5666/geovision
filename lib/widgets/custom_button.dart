import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geovision/core/theme/theme_bloc.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? fontSize;
  final Color? textColor;
  final BorderRadiusGeometry? borderRadius;

  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.width,
    this.padding,
    this.margin,
    this.fontSize,
    this.textColor,
    this.borderRadius ,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeBloc>().state == ThemeMode.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin?? const EdgeInsets.all(0),
        width: width ?? double.infinity,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
            color: Color(0xFF21c063),
            borderRadius: borderRadius ??  BorderRadius.all(Radius.circular(25)),
            // border: Border.all(color: Colors.black)
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize ??16,
            fontFamily: 'Outfit',
            color: isDarkMode?Colors.black:Colors.white
          ),
        ),
      ),
    );


    // return ElevatedButton(
    //   onPressed: onTap,
    //   style: ElevatedButton.styleFrom(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(25),
    //     ),
    //     backgroundColor:const Color(0xFF21c063),
    //     minimumSize: const Size(double.infinity, 50),
    //   ),
    //   child: Row(
    //     mainAxisSize: MainAxisSize.min,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       if (icon != null) ...[
    //         Icon(icon, size: 24, color: isDarkMode ? Colors.black : Colors.white),
    //         const SizedBox(width: 8),
    //       ],
    //       Text(
    //         text,
    //         style: TextStyle(
    //           fontFamily: 'Montserrat',
    //           fontSize: 16,
    //           fontWeight: FontWeight.bold,
    //           color: isDarkMode ? Colors.black : Colors.white,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
