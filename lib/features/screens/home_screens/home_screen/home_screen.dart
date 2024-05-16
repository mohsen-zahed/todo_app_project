import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list_project/config/images_paths.dart';
import 'package:to_do_list_project/config/my_colors.dart';
import 'package:to_do_list_project/features/data/models/task_model.dart';
import 'package:to_do_list_project/features/screens/home_screens/create_task_screen/create_edit_task_screen.dart';
import 'package:to_do_list_project/features/screens/home_screens/home_screen/widgets/days_with_delete_button_widget.dart';
import 'package:to_do_list_project/features/screens/home_screens/home_screen/widgets/task_tile_widget.dart';
import 'package:to_do_list_project/features/screens/home_screens/home_screen/widgets/top_text_with_search_bar_widget.dart';
import 'package:to_do_list_project/functions/media_queries.dart';
import 'package:to_do_list_project/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchBarController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final hive = Hive.box<TaskModel>(hiveBoxName);
    return Scaffold(
      //* Button to createTaskScreen...
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => CreateEditTaskScreen(
                    taskModel: TaskModel(),
                  )),
            ),
          );
        },
        label: Row(
          children: [
            const Text('Add new task'),
            const SizedBox(width: 5),
            Icon(
              Icons.add,
              size: mediaQueries.getHeightMediaQuery(context, 0.02),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: mediaQueries.getHeightMediaQuery(context),
            child: Column(
              children: [
                //* Title with search bar...
                TopTextWithSearchBarWidget(
                  title: 'Todo List',
                  searchBarController: searchBarController,
                  icon: Icons.search,
                ),
                //* Today text with deleteAll button...
                DaysWithDeleteButtonWidget(
                  text: 'Today',
                  onDeletePressed: () {
                    hive.clear();
                  },
                ),
                //* List of tasks or Lottie animation if there are no tasks...
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: hive.listenable(),
                    builder: (context, value, child) => hive.values.isEmpty
                        ? Image.asset(
                            imagesPaths.emptyListPng,
                            fit: BoxFit.contain,
                          )
                        : ListView.builder(
                            itemCount: hive.values.length,
                            itemBuilder: (context, index) {
                              final List<TaskModel> tasksList = hive.values.toList().reversed.toList();
                              return TaskTileWidget(
                                task: tasksList[index].taskName,
                                isCompleted: tasksList[index].isCompleted,
                                priorityColor: checkPriority(tasksList[index].priority),
                                onDissmisbleDrag: (direction) {
                                  DismissDirection.startToEnd;
                                  tasksList[index].delete();
                                },
                                onTileIconTap: () {
                                  setState(() {
                                    tasksList[index].isCompleted = !tasksList[index].isCompleted;
                                  });
                                },
                                taskModel: tasksList[index],
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

  Color checkPriority(Priority priority) {
    if (priority == Priority.high) {
      return colors.lightPrimaryColor;
    } else if (priority == Priority.normal) {
      return colors.orangeColor;
    } else {
      return colors.blueAccentColor;
    }
  }
}
