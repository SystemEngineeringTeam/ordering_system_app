
import 'package:flutter/material.dart';

///ホバーとクリックをグレーにする関数
///ex. overlayColor: MaterialStateProperty.resolveWith(hoverAndTapIsGrey),
Color hoverAndTapIsGrey(Set<MaterialState> states) {
    //ホバー
    if (states.any((state) => state == MaterialState.hovered)) {
      return Colors.grey.withAlpha(10); //薄いグレー
    }
    //クリック
    if (states.any((state) => state == MaterialState.pressed)) {
      return Colors.white.withAlpha(10); //薄いグレー
    }
    return Colors.white;
}