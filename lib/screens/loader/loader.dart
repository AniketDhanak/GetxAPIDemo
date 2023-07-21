import 'package:flutter/material.dart';
import 'package:getx_api_demo_mvc/constants/app_colors.dart';

class Loader extends StatelessWidget {
  final Widget child;
  final bool isCallInProgress;
  final double opacity;
  final Color color;
  final Animation<Color>? valueColor;

  const Loader({
    Key? key,
    required this.child,
    required this.isCallInProgress,
    this.color = AppColors.white,
    this.opacity = 0.3,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];
    widgetList.add(child);
    if (isCallInProgress) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(
              dismissible: false,
              color: color,
            ),
          ),
           const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          )
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
