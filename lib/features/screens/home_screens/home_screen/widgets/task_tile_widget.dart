import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_project/config/my_colors.dart';
import 'package:to_do_list_project/features/data/models/task_model.dart';
import 'package:to_do_list_project/features/screens/home_screens/create_task_screen/create_edit_task_screen.dart';
import 'package:to_do_list_project/functions/media_queries.dart';
import 'package:to_do_list_project/utils/helper_functions.dart';
import 'package:to_do_list_project/utils/theme_checker.dart';

class TaskTileWidget extends StatelessWidget {
  final GestureTapCallback onTileIconTap;
  final Function(DismissDirection) onDissmisbleDrag;
  final TaskModel taskModel;
  final String task;
  final Color priorityColor;
  final bool isCompleted;
  const TaskTileWidget({
    super.key,
    required this.task,
    required this.priorityColor,
    required this.isCompleted,
    required this.onTileIconTap,
    required this.taskModel,
    required this.onDissmisbleDrag,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mediaQueries.getWidthMediaQuery(context, 0.05),
        vertical: mediaQueries.getWidthMediaQuery(context, 0.01),
      ),
      child: Dismissible(
        background: Container(
          width: mediaQueries.getWidthMediaQuery(context),
          padding: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: colors.redColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete,
              color: colors.redColor,
            ),
          ),
        ),
        onDismissed: onDissmisbleDrag,
        key: Key(UniqueKey().toString()),
        child: ListTile(
          splashColor: colors.transparentColor,
          leading: GestureDetector(
            onTap: onTileIconTap,
            child: Icon(
              isCompleted
                  ? CupertinoIcons.check_mark_circled
                  : CupertinoIcons.circle,
              color: isCompleted
                  ? priorityColor
                  : themeChecker.isThemeLight(context)
                      ? colors.blackColor
                      : colors.whiteColor,
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
          tileColor: colors.whiteColor,
          onTap: () {
            isCompleted
                ? helperFuncions.showSnackBar(
                    context, 'Completed tasks can not be modified!')
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateEditTaskScreen(
                        taskModel: taskModel,
                      ),
                    ),
                  );
          },
          contentPadding: EdgeInsets.only(
            left: mediaQueries.getWidthMediaQuery(context, 0.03),
          ),
          title: Text(
            task,
            style: TextStyle(
              decoration: isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Container(
            width: 5,
            height: mediaQueries.getHeightMediaQuery(context),
            decoration: BoxDecoration(
              color: priorityColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
