import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list_project/config/images_paths.dart';
import 'package:to_do_list_project/config/my_colors.dart';
import 'package:to_do_list_project/features/data/models/task_model.dart';
import 'package:to_do_list_project/features/screens/home_screens/create_task_screen/create_edit_task_screen.dart';
import 'package:to_do_list_project/features/screens/home_screens/home_screen/widgets/days_with_delete_button_widget.dart';
import 'package:to_do_list_project/features/screens/home_screens/home_screen/widgets/task_tile_widget.dart';
import 'package:to_do_list_project/features/screens/home_screens/home_screen/widgets/top_text_with_search_bar_widget.dart';
import 'package:to_do_list_project/utils/media_queries.dart';
import 'package:to_do_list_project/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchBarController = TextEditingController();
  final ValueNotifier<String> searchTermChangeNotifier = ValueNotifier('');
  final FocusNode searchBarFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    searchBarController.dispose();
    searchTermChangeNotifier.dispose();
    searchBarFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hive = Hive.box<TaskModel>(hiveBoxName);
    return Scaffold(
      //* Button to createTaskScreen...
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          searchBarFocusNode.unfocus();
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
                  focusNode: searchBarFocusNode,
                  onChanged: (string) {
                    searchTermChangeNotifier.value = searchBarController.text;
                  },
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
                    valueListenable: searchTermChangeNotifier,
                    builder: (context, value, child) => ValueListenableBuilder(
                      valueListenable: hive.listenable(),
                      builder: (context, value, child) {
                        final List<TaskModel> items;
                        if (searchBarController.text.isEmpty) {
                          items = hive.values.toList().reversed.toList();
                        } else {
                          items = hive.values
                              .where((task) => (task.taskName == searchBarController.text || task.taskName.contains(searchBarController.text)))
                              .toList()
                              .reversed
                              .toList();
                        }
                        if (hive.values.isEmpty) {
                          return Image.asset(
                            imagesPaths.emptyListPng,
                            fit: BoxFit.contain,
                          );
                        } else {
                          return ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return TaskTileWidget(
                                index: index,
                                task: items[index].taskName,
                                isCompleted: items[index].isCompleted,
                                priorityColor: checkPriority(items[index].priority),
                                onDissmisbleDrag: (direction) {
                                  DismissDirection.startToEnd;
                                  items[index].delete();
                                },
                                onTileIconTap: () {
                                  setState(() {
                                    items[index].isCompleted = !items[index].isCompleted;
                                  });
                                },
                                taskModel: items[index],
                              );
                            },
                          );
                        }
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
