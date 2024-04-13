import 'package:flutter/material.dart';

class SnappingScrollPysics extends ScrollPhysics {
  final double itemExtent;

  const SnappingScrollPysics({required this.itemExtent, super.parent});
}
