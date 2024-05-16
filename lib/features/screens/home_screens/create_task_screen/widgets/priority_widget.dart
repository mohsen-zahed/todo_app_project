import 'package:flutter/material.dart';
import 'package:to_do_list_project/config/my_colors.dart';
import 'package:to_do_list_project/functions/media_queries.dart';

class PriorityWidget extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSelected;
  final GestureTapCallback onPriorityTap;
  const PriorityWidget({
    super.key,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onPriorityTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPriorityTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: mediaQueries.getWidthMediaQuery(context, 0.03),
            vertical: mediaQueries.getHeightMediaQuery(context, 0.015),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: colors.greyColorShade300,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              Expanded(
                child: Icon(
                  isSelected ? Icons.check_circle : Icons.circle,
                  color: color,
                  size: mediaQueries.getHeightMediaQuery(context, 0.02),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
