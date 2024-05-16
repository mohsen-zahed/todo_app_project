import 'package:flutter/material.dart';
import 'package:to_do_list_project/config/my_colors.dart';
import 'package:to_do_list_project/utils/media_queries.dart';
import 'package:to_do_list_project/utils/theme_checker.dart';

class DaysWithDeleteButtonWidget extends StatelessWidget {
  final String text;
  final GestureTapCallback onDeletePressed;
  const DaysWithDeleteButtonWidget({
    super.key,
    required this.onDeletePressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mediaQueries.getWidthMediaQuery(context),
      padding: EdgeInsets.symmetric(
        horizontal: mediaQueries.getWidthMediaQuery(context, 0.05),
        vertical: mediaQueries.getHeightMediaQuery(context, 0.015),
      ),
      decoration: BoxDecoration(color: themeChecker.isThemeLight(context) ? colors.whiteColor : colors.darkPrimaryColor, boxShadow: [
        BoxShadow(
          blurRadius: 10,
          offset: const Offset(0, 5),
          color: themeChecker.isThemeLight(context) ? colors.blackColor.withOpacity(0.06) : colors.greyColorShade100.withOpacity(0.1),
        ),
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: mediaQueries.getWidthMediaQuery(context, 0.13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(text, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 2),
                Container(
                  width: double.infinity,
                  height: 3,
                  decoration: BoxDecoration(
                    color: colors.lightPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onDeletePressed,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.redAccentColor100.withOpacity(0.3)),
              child: Row(
                children: [
                  Text(
                    'Delete All',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: colors.redAccentColor,
                        ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.delete_sweep_rounded,
                    color: colors.redAccentColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
