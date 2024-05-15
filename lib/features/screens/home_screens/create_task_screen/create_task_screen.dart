import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list_project/config/my_colors.dart';
import 'package:to_do_list_project/features/data/models/task_model.dart';
import 'package:to_do_list_project/functions/media_queries.dart';
import 'package:to_do_list_project/main.dart';
import 'package:to_do_list_project/utils/helper_functions.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
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
          widget.taskModel.isCompleted = widget.taskModel.isCompleted;
          widget.taskModel.priority = widget.taskModel.priority;
          if (widget.taskModel.isInBox) {
            widget.taskModel.save();
          } else {
            if (widget.taskModel.taskName.isNotEmpty) {
              final box = Hive.box<TaskModel>(hiveBoxName);
              box.add(widget.taskModel);
              Navigator.pop(context);
            } else {
              helperFuncions.showSnackBar(context, 'Task can not be empty!');
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
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
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
