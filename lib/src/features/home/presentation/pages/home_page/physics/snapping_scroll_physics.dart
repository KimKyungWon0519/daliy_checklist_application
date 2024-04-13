import 'package:flutter/material.dart';

class SnappingScrollPhysics extends ScrollPhysics {
  final double itemExtent;

  const SnappingScrollPhysics({required this.itemExtent, super.parent});
}
