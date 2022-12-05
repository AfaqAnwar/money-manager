import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager/utils/colors.dart';
import 'package:xen_popup_card/xen_card.dart';

// XenCard Builder Helpers
XenCardGutter getGutter(String text) {
  XenCardGutter gutter = XenCardGutter(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomButton(text: text),
    ),
  );

  return gutter;
}

XenCardAppBar getAppBar(String text) {
  XenCardAppBar appBar = XenCardAppBar(
    shadow: const BoxShadow(color: Colors.transparent),
    child: Text(
      text,
      style: GoogleFonts.bebasNeue(fontWeight: FontWeight.normal, fontSize: 32),
      textAlign: TextAlign.center,
    ), // To remove shadow from appbar
  );

  return appBar;
}

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.text, this.color})
      : super(key: key);

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.customDarkGreen,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Center(
              child: Text(text,
                  style: GoogleFonts.roboto(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
            ),
          ),
        ),
      ),
    );
  }
}
