import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list_project/config/my_colors.dart';
import 'package:to_do_list_project/features/data/models/task_model.dart';
import 'package:to_do_list_project/features/screens/home_screens/create_task_screen/create_task_screen.dart';
import 'package:to_do_list_project/functions/media_queries.dart';
import 'package:to_do_list_project/main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hive = Hive.box<TaskModel>(hiveBoxName);
    return Scaffold(
      backgroundColor: colors.lightScaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => const CreateTaskScreen()),
            ),
          );
        },
        label: const Text('Add new task'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: mediaQueries.getHeightMediaQuery(context),
            child: Column(
              children: [
                const TopTextWithSearchBarWidget(),
                DaysWithDeleteButtonWidget(
                  onDeletePressed: () {
                    hive.clear();
                  },
                ),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: hive.listenable(),
                    builder: (context, value, child) => ListView.builder(
                      itemCount: hive.values.length,
                      itemBuilder: (context, index) {
                        return TaskTileWidget(
                          task: hive.values.toList()[index].taskName,
                          isSelected: hive.values.toList()[index].isCompleted,
                          onTileTap: () {},
                          priorityColor: checkPriority(
                              hive.values.toList()[index].priority),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Color checkPriority(Priority priority) {
  if (priority == Priority.low) {
    return colors.lightPrimaryColor;
  } else if (priority == Priority.normal) {
    return colors.redColor;
  } else {
    return colors.greenColor;
  }
}

class TaskTileWidget extends StatelessWidget {
  final GestureTapCallback onTileTap;
  final String task;
  final Color priorityColor;
  final bool isSelected;
  const TaskTileWidget({
    super.key,
    required this.onTileTap,
    required this.task,
    required this.priorityColor,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mediaQueries.getWidthMediaQuery(context, 0.05),
        vertical: mediaQueries.getWidthMediaQuery(context, 0.01),
      ),
      child: ListTile(
        leading: Icon(
          isSelected ? CupertinoIcons.circle_fill : CupertinoIcons.circle,
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
        onTap: onTileTap,
        contentPadding: EdgeInsets.only(
          left: mediaQueries.getWidthMediaQuery(context, 0.03),
        ),
        title: Text(task),
        trailing: Container(
          width: 5,
          decoration: BoxDecoration(
            color: priorityColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

class DaysWithDeleteButtonWidget extends StatelessWidget {
  final GestureTapCallback onDeletePressed;
  const DaysWithDeleteButtonWidget({
    super.key,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mediaQueries.getWidthMediaQuery(context),
      padding: EdgeInsets.symmetric(
        horizontal: mediaQueries.getWidthMediaQuery(context, 0.05),
        vertical: mediaQueries.getHeightMediaQuery(context, 0.02),
      ),
      color: colors.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: mediaQueries.getWidthMediaQuery(context, 0.13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Today', style: Theme.of(context).textTheme.titleLarge),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: colors.greyColorShade100,
              ),
              child: Row(
                children: [
                  Text(
                    'Delete All',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: colors.greyColorShade300,
                        ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.delete_sweep_rounded,
                    color: colors.greyColorShade300,
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

class TopTextWithSearchBarWidget extends StatelessWidget {
  const TopTextWithSearchBarWidget({
    super.key,
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
                'To Do List',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.whiteColor,
                    ),
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
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: colors.greyColorShade400),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
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
