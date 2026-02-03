import 'package:flutter/material.dart';

extension SpaceSizedBox on num {

  Widget get h => SizedBox(height: this.toDouble());

  Widget get w => SizedBox(width: this.toDouble());
}
