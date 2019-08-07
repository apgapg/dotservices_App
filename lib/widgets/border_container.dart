import 'package:flutter/material.dart';

class BorderContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final bool showShadow;
  final Color borderColor;

  BorderContainer({
    @required this.child,
    this.margin,
    this.padding,
    this.showShadow = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(6.0),
        ),
        border: Border.all(
          color: borderColor ?? Theme.of(context).dividerColor,
        ),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0.2,
                  blurRadius: 3,
                  offset: Offset(1.5, 1.5),
                ),
              ]
            : null,
        color: Theme.of(context).cardColor,
      ),
    );
  }
}
