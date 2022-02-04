import 'package:flutter/material.dart';

import 'container/container.dart';
import 'theme.dart';

class AppButton extends StatelessWidget {
  static const double _containerSize = 36;

  final bool isSelected;
  final Widget child;
  final Function() onPressed;

  AppButton.label(this.isSelected, String label, this.onPressed)
    :
    child = Text(
      label,
      style: isSelected ? AppTheme.normalLightBlueStyle : AppTheme.normalLightStyle
    );

  AppButton.icon(IconData icon, this.onPressed)
    :
    isSelected = false,
    child = Icon(icon, size: 24, color: AppTheme.highLightColor);

  @override
  Widget build(BuildContext context) {
    final effectsColor = AppTheme.lowLightColor.withOpacity(0.32);
    return IconButton(
      iconSize: _containerSize,
      splashColor: effectsColor,
      hoverColor: effectsColor,
      highlightColor: effectsColor,
      icon: AppContainer(
        borderSize: 2,
        borderColor: isSelected ? AppTheme.lightBlue : AppTheme.highLightColor,
        borderRadius: BorderRadius.circular(_containerSize),
        child: Center(
          child: child
        )
      ),
      mouseCursor: SystemMouseCursors.basic,
      onPressed: onPressed
    );
  }
}