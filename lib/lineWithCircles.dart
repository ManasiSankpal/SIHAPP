import 'package:flutter/material.dart';

class SliderIconSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbColor: Colors.white,
        activeTrackColor: Colors.pink,
        inactiveTrackColor: Colors.pink.withOpacity(0.5),
        overlayColor: Colors.pink.withAlpha(100),
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
      ),
      child: RangeSlider(
        values: RangeValues(25.0, 75.0),
        min: 0,
        max: 100,
        divisions: 100,
        onChanged: (values) {
          
        },
      ),
    );
  }
}


