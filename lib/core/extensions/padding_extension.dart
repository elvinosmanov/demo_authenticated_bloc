import 'package:flutter/material.dart';

extension WidgetPadding  on Widget{
  Widget padding() =>Padding(padding: const EdgeInsets.all(16), child: this,);
}