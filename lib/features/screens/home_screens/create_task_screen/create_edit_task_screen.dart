import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list_project/config/my_colors.dart';
import 'package:to_do_list_project/features/data/models/task_model.dart';
import 'package:to_do_list_project/features/screens/home_screens/create_task_screen/widgets/priority_widget.dart';
import 'package:to_do_list_project/utils/media_queries.dart';
import 'package:to_do_list_project/main.dart';
import 'package:to_do_list_project/helper_functions/helper_functions.dart';

class CreateEditTaskScreen extends StatefulWidget {
  const CreateEditTaskScreen({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  State<CreateEditTaskScreen> createState() => _CreateEditTaskScreenState();
}

class _CreateEditTaskScreenState extends State<CreateEditTaskScreen> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.taskModel.taskName);
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          widget.taskModel.taskName = _controller.text.trim();
          widget.taskModel.priority = widget.taskModel.priority;
          if (widget.taskModel.isInBox) {
            widget.taskModel.save();
            Navigator.pop(context);
          } else {
            if (widget.taskModel.taskName.isNotEmpty) {
              final box = Hive.box<TaskModel>(hiveBoxName);
              box.add(widget.taskModel);
              Navigator.pop(context);
            } else {
              helperFunctions.showSnackBar(context, 'Task can not be empty!');
              focusNode.requestFocus();
            }
          }
        },
        label: Row(
          children: [
            const Text('Save task'),
            const SizedBox(width: 5),
            Icon(
              Icons.check,
              size: mediaQueries.getHeightMediaQuery(context, 0.02),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: mediaQueries.getWidthMediaQuery(context, 0.03),
              vertical: mediaQueries.getWidthMediaQuery(context, 0.02),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PriorityWidget(
                  onPriorityTap: () {
                    setState(() {
                      widget.taskModel.priority = Priority.high;
                    });
                  },
                  label: 'High',
                  color: colors.lightPrimaryColor,
                  isSelected: widget.taskModel.priority == Priority.high,
                ),
                const SizedBox(width: 5),
                PriorityWidget(
                  onPriorityTap: () {
                    setState(() {
                      widget.taskModel.priority = Priority.normal;
                    });
                  },
                  label: 'Normal',
                  color: colors.orangeColor,
                  isSelected: widget.taskModel.priority == Priority.normal,
                ),
                const SizedBox(width: 5),
                PriorityWidget(
                  onPriorityTap: () {
                    setState(() {
                      widget.taskModel.priority = Priority.low;
                    });
                  },
                  label: 'Low',
                  color: colors.blueAccentColor,
                  isSelected: widget.taskModel.priority == Priority.low,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mediaQueries.getWidthMediaQuery(context, 0.05),
              ),
              child: TextField(
                focusNode: focusNode,
                controller: _controller,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Enter your task...',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
