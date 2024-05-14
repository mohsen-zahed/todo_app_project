import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list_project/features/data/models/task_model.dart';
import 'package:to_do_list_project/main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hive = Hive.box<TaskModel>(hiveBoxName);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List Screen'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => const CreateTaskScreen()),
              ));
        },
        label: const Text('Add new task'),
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: ValueListenableBuilder<Box<TaskModel>>(
          valueListenable: hive.listenable(),
          builder: (context, value, child) => ListView.builder(
            itemCount: hive.values.length,
            itemBuilder: (context, index) {
              return Text(hive.values.toList()[index].taskName);
            },
          ),
        ),
      ),
    );
  }
}

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _controller =
      TextEditingController(text: 'task1');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task Screen'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final task = TaskModel();
          task.taskName = _controller.text;
          task.isCompleted = false;
          task.priority = Priority.low;
          if (task.isInBox) {
            task.save();
          } else {
            final box = Hive.box<TaskModel>(hiveBoxName);
            box.add(task);
          }
          Navigator.pop(context);
        },
        label: const Text('Save task'),
      ),
      body: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'Enter your task',
        ),
      ),
    );
  }
}
