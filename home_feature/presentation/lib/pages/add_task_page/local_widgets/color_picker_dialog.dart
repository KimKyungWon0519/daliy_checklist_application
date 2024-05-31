import 'package:flutter/material.dart';
import 'package:presentation/pages/add_task_page/decorations/slider_track_shapes.dart';

class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({super.key});

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  double _hue = 0;
  double _lightness = 0.5;

  @override
  Widget build(BuildContext context) {
    Color hueColor = HSLColor.fromAHSL(1, _hue, 1, 0.5).toColor();
    Color mainColor = HSLColor.fromAHSL(1, _hue, 1, _lightness).toColor();

    return Dialog(
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: mainColor,
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                _HueSlider(
                  value: _hue,
                  hueColor: hueColor,
                  onChanged: (value) {
                    setState(() {
                      _hue = value;
                    });
                  },
                ),
                _LightnessSlider(
                  lightness: _lightness,
                  hueColor: hueColor,
                  mainColor: mainColor,
                  onChanged: (value) {
                    setState(() {
                      _lightness = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HueSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final Color hueColor;

  const _HueSlider({
    super.key,
    required this.value,
    required this.hueColor,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('H'),
        Expanded(
          child: _ColorSlider(
            colors: const [
              Colors.red,
              Colors.orange,
              Colors.yellow,
              Colors.green,
              Colors.blue,
              Colors.indigo,
              Colors.purple,
              Colors.red,
            ],
            value: value,
            thumbColor: hueColor,
            max: 360,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class _LightnessSlider extends StatelessWidget {
  final double lightness;
  final Color hueColor;
  final Color mainColor;
  final ValueChanged<double>? onChanged;

  const _LightnessSlider({
    super.key,
    required this.lightness,
    required this.hueColor,
    required this.mainColor,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('L'),
        Expanded(
          child: _ColorSlider(
            colors: [
              Colors.black,
              hueColor,
              Colors.white,
            ],
            value: lightness,
            thumbColor: mainColor,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class _ColorSlider extends StatelessWidget {
  final List<Color> colors;
  final Color thumbColor;
  final double value;
  final double min, max;
  final ValueChanged<double>? onChanged;

  const _ColorSlider({
    super.key,
    required this.colors,
    required this.thumbColor,
    required this.value,
    this.onChanged,
    this.min = 0.0,
    this.max = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackShape: GradientRectSliderTrackShape(colors),
        thumbColor: thumbColor,
      ),
      child: Slider(
        value: value,
        onChanged: onChanged,
        max: max,
        min: min,
      ),
    );
  }
}
