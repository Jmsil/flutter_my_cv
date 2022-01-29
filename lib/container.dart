import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  static const BorderRadius defaultRadius = BorderRadius.all(Radius.circular(8));

  final double? width;
  final double? height;
  final Color? color;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double borderSize;
  final Color? borderColor;
  final BorderRadius borderRadius;
  final bool hasShadow;
  final bool isClipped;
  final Widget child;

  AppContainer({
    this.width,
    this.height,
    this.color,
    this.margin,
    this.padding,
    this.borderSize = 1,
    this.borderColor,
    this.borderRadius = BorderRadius.zero,
    this.hasShadow = false,
    this.isClipped = false,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    Widget rWidget = child;
    final double newBorderSize = borderSize / 2;
    final bool hasBorder = borderColor != null && newBorderSize > 0;

    if (padding != null || hasBorder) {
      rWidget = Padding(
        padding:
          (padding == null ? EdgeInsets.zero : padding!) +
          (hasBorder ? EdgeInsets.all(newBorderSize) : EdgeInsets.zero),
        child: rWidget
      );
    }

    rWidget = Material(
      color: color,
      type: color == null ? MaterialType.transparency : MaterialType.canvas,
      shape: BeveledRectangleBorder(
        borderRadius: borderRadius,
        side: hasBorder
          ? BorderSide(
              width: newBorderSize,
              color: borderColor!
            )
          : BorderSide.none
      ),
      shadowColor: Colors.black54,
      elevation: hasShadow ? 6 : 0,
      clipBehavior: isClipped ? Clip.hardEdge : Clip.none,
      child: rWidget
    );

    if (width != null || height != null) {
      rWidget = ConstrainedBox(
        constraints: BoxConstraints.expand(width: width, height: height),
        child: rWidget
      );
    }

    if (margin != null) {
      rWidget = Padding(
        padding: margin!,
        child: rWidget
      );
    }

    return rWidget;
  }
}