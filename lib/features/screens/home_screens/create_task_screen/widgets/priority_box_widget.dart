import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_project/config/my_colors.dart';
import 'package:to_do_list_project/functions/media_queries.dart';
import 'package:to_do_list_project/utils/theme_checker.dart';

class PriorityBoxWidget extends StatelessWidget {
  final String text;
  final Color color;
  final bool isSelected;
  final GestureCancelCallback onPriorityTap;
  const PriorityBoxWidget({
    super.key,
    required this.text,
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
            vertical: mediaQueries.getHeightMediaQuery(context, 0.01),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: colors.greyColorShade200),
            color: colors.transparentColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: mediaQueries.getWidthMediaQuery(context, 0.18),
                ),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                padding: isSelected
                    ? const EdgeInsets.all(1)
                    : const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: color,
                ),
                child: Center(
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          color: themeChecker.isThemeLight(context)
                              ? colors.whiteColor
                              : colors.whiteColor,
                          size: 10,
                        )
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
