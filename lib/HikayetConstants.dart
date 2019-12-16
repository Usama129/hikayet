
import 'package:flutter/cupertino.dart';

class HikayetConstants extends InheritedWidget {

  static HikayetConstants of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(HikayetConstants);

  const HikayetConstants({Widget child, Key key}): super(key: key, child: child);

  // Colors
  final int backgroundColorHex = 0x00111111;
  final int buttonsColorHex = 0xffadd8e6 ;
  final int inputColorHex = 0xff4190A7;
  final int textColorHex = 0xffC3AAA8;
  final int titleColorHex = 0xffffffff;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }


}