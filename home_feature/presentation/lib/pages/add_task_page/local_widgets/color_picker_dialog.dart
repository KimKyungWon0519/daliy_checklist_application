import 'package:flutter/material.dart';
import 'package:presentation/pages/add_task_page/decorations/slider_track_shapes.dart';

class _HSLColorProvider extends InheritedWidget {
  final double hue;
  final double saturation;
  final double lightness;
  final void Function({double? hue, double? saturation, double? lightness})
      updateHSL;

  const _HSLColorProvider({
    required super.child,
    required this.hue,
    required this.saturation,
    required this.lightness,
    required this.updateHSL,
  });

  static _HSLColorProvider? maybeOf(final BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_HSLColorProvider>();
  }

  static _HSLColorProvider of(final BuildContext context) {
    final _HSLColorProvider? result = maybeOf(context);

    assert(result != null, 'No CalendarProvider found in context');

    return result!;
  }

  @override
  bool updateShouldNotify(covariant _HSLColorProvider oldWidget) {
    return true;
  }

  Color get hslColor =>
      HSLColor.fromAHSL(1, hue, saturation, lightness).toColor();
}

class ColorPickerDialog extends StatefulWidget {
  final Color color;

  const ColorPickerDialog({
    super.key,
    required this.color,
  });

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  double _hue = 0;
  double _lightness = 0.5;
  double _saturation = 1;

  @override
  void initState() {
    super.initState();

    HSLColor hslColor = HSLColor.fromColor(widget.color);
    _hue = hslColor.hue;
    _lightness = hslColor.lightness;
    _saturation = hslColor.saturation;
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor =
        HSLColor.fromAHSL(1, _hue, _saturation, _lightness).toColor();

    return _HSLColorProvider(
      hue: _hue,
      saturation: _saturation,
      lightness: _lightness,
      updateHSL: ({hue, lightness, saturation}) {
        setState(() {
          _hue = hue ?? _hue;
          _saturation = saturation ?? _saturation;
          _lightness = lightness ?? _lightness;
        });
      },
      child: Dialog(
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: mainColor,
              height: 100,
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: _SliderPanel(),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: _SaveButton(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final _HSLColorProvider provider = _HSLColorProvider.of(context);

        Navigator.pop(context, provider.hslColor);
      },
      child: const Text('저장'),
    );
  }
}

class _SliderPanel extends StatelessWidget {
  const _SliderPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _HueSlider(),
        _SaturationSlider(),
        _LightnessSlider(),
      ],
    );
  }
}

class _HueSlider extends StatelessWidget {
  const _HueSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _HSLColorProvider provider = _HSLColorProvider.of(context);
    final double hue = provider.hue;

    return _ColorSlider(
      name: 'H',
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
      value: hue,
      thumbColor: HSLColor.fromAHSL(1, hue, 1, 0.5).toColor(),
      max: 360,
      onChanged: (value) {
        provider.updateHSL(hue: value);
      },
    );
  }
}

class _LightnessSlider extends StatelessWidget {
  const _LightnessSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _HSLColorProvider provider = _HSLColorProvider.of(context);
    final double hue = provider.hue;
    final double saturation = provider.saturation;

    return _ColorSlider(
      name: 'L',
      colors: [
        Colors.black,
        HSLColor.fromAHSL(1, hue, saturation, 0.5).toColor(),
        Colors.white,
      ],
      value: provider.lightness,
      thumbColor: provider.hslColor,
      onChanged: (value) {
        provider.updateHSL(lightness: value);
      },
    );
  }
}

class _SaturationSlider extends StatelessWidget {
  const _SaturationSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _HSLColorProvider provider = _HSLColorProvider.of(context);
    final double hue = provider.hue;
    final double saturation = provider.saturation;

    return _ColorSlider(
      name: 'S',
      colors: [
        HSLColor.fromAHSL(1, hue, 0, 0.5).toColor(),
        HSLColor.fromAHSL(1, hue, 1, 0.5).toColor()
      ],
      value: saturation,
      thumbColor: HSLColor.fromAHSL(1, hue, saturation, 0.5).toColor(),
      onChanged: (value) {
        provider.updateHSL(saturation: value);
      },
    );
  }
}

class _ColorSlider extends StatelessWidget {
  final String name;
  final List<Color> colors;
  final Color thumbColor;
  final double value;
  final double min, max;
  final ValueChanged<double>? onChanged;

  const _ColorSlider({
    super.key,
    required this.name,
    required this.colors,
    required this.thumbColor,
    required this.value,
    this.onChanged,
    this.min = 0.0,
    this.max = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(name),
        ),
        Flexible(
          child: SliderTheme(
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
          ),
        ),
      ],
    );
  }
}
