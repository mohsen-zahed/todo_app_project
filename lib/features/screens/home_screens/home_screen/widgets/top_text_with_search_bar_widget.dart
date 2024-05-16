import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_project/config/my_colors.dart';
import 'package:to_do_list_project/utils/media_queries.dart';

class TopTextWithSearchBarWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final TextEditingController searchBarController;
  const TopTextWithSearchBarWidget({
    super.key,
    required this.icon,
    required this.searchBarController,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: mediaQueries.getWidthMediaQuery(context, 0.03),
        vertical: mediaQueries.getHeightMediaQuery(context, 0.02),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: colors.whiteColor),
              ),
              Icon(
                CupertinoIcons.qrcode_viewfinder,
                color: colors.whiteColor,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: mediaQueries.getWidthMediaQuery(context),
            decoration: BoxDecoration(
              color: colors.whiteColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: TextField(
              controller: searchBarController,
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: colors.greyColorShade400),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                prefixIcon: Icon(
                  icon,
                  color: colors.greyColorShade400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
