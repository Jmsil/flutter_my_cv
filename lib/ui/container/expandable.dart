import 'package:flutter/material.dart';

class AppExpandable extends StatefulWidget {
  static const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 12, vertical: 8);

  final Widget child;

  AppExpandable(AppExpandableKey key, this.child) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<AppExpandable> with SingleTickerProviderStateMixin {
  bool isOffstage = true;
  bool isExpanded = false;
  double contentHeight = 0;
  final GlobalKey contentKey = GlobalKey();
  late final AnimationController controller;
  late final CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this);
    controller.addStatusListener(animationStatusListener);
    curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
      reverseCurve: Curves.decelerate.flipped
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: isOffstage,
      child: AnimatedBuilder(
        animation: curvedAnimation,
        builder: (context, child) {
          return ConstrainedBox(
            key: contentKey,
            constraints: BoxConstraints(
              maxHeight: controller.isAnimating
                ? contentHeight * curvedAnimation.value
                : double.infinity
            ),
            child: child
          );
        },
        child: Padding(
          padding: AppExpandable.padding,
          child: widget.child
        )
      )
    );
  }

  void switchExpandedState() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      isOffstage = false;
      isExpanded = !isExpanded;

      if (!controller.isAnimating) {
        contentHeight = contentKey.currentContext!.size!.height;
        controller.duration = Duration(milliseconds: 360 + (contentHeight * 0.4).toInt());
      }

      if (isExpanded)
        controller.forward();
      else
        controller.reverse();
    });
  }

  void animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.dismissed)
      setState(() => isOffstage = true);
  }
}

class AppExpandableKey extends GlobalKey {
  AppExpandableKey() : super.constructor();

  _State? get _state => (currentState as _State?);

  void switchExpandedState() => _state?.switchExpandedState();

  bool get isExpanded => _state?.isExpanded ?? false;
}