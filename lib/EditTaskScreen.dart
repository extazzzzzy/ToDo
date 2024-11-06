import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/HomeScreen.dart';

class EditTaskScreen extends StatefulWidget {
  final int titleIndex;
  final int descriptionIndex;

  EditTaskScreen(
      {
        required this.titleIndex,
        required this.descriptionIndex,
      });

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  List<String> tasks = [];

  @override
  void initState() {
    super.initState();

    loadTasks();
  }

  void loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      tasks = prefs.getStringList('tasks') ?? [];
    });

    activateControllers(tasks);
  }

  void activateControllers(tasks) {
    titleController = TextEditingController(text: tasks[widget.titleIndex]);
    descriptionController = TextEditingController(text: tasks[widget.descriptionIndex]);
  }

  void saveTasks(tasks) async { // сохранение нового массива заданий
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasks', tasks);
  }

  void saveTask(BuildContext context) async {
    String title = titleController.text;
    String description = descriptionController.text;

    if (title.isNotEmpty) { // заголовок введён
      if (description.isEmpty) { // описание отсутствует
        tasks[widget.titleIndex] = title;
        tasks[widget.descriptionIndex] = 'Описание отсутствует';

        saveTasks(tasks);

        final snackBar = SnackBar(
          content: Text('Задача успешно изменена!'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false,
        );
      }
      else { // описание введено
        tasks[widget.titleIndex] = title;
        tasks[widget.descriptionIndex] = description;

        saveTasks(tasks);

        final snackBar = SnackBar(
          content: Text('Задача успешно изменена!'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false,
        );
      }
    }
    else { // заголовок отсутствует
      final snackBar = SnackBar(
        content: Text('Введите название задачи!'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
  }

  void deleteTask(BuildContext context) async {
    if (tasks.length <= 3) {
      tasks = [];
      saveTasks(tasks);
    }
    else {
      tasks.removeAt(widget.descriptionIndex + 1);
      tasks.removeAt(widget.descriptionIndex);
      tasks.removeAt(widget.titleIndex);
      saveTasks(tasks);
    }

    final snackBar = SnackBar(
      content: Text('Задача успешно удалена!'),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
      Text(
        'ToDo',
        style: TextStyle(
          fontFamily: 'DushaRegular',
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
        backgroundColor: Color.fromRGBO(255, 228, 181, 1),
      ),
      backgroundColor: Color.fromRGBO(255, 228, 181, 1),

      body:
      Padding(
        padding: EdgeInsets.only(top: 20.0, left: 6.0, right: 6.0),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: '*Название задачи',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.amber, width: 4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.amber, width: 4),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white38, width: 4),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'DushaRegular',
                  fontSize: 24,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: TextField(
                  controller: descriptionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: '*Описание задачи',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.amber, width: 4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.amber, width: 4),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white38, width: 4),
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'DushaRegular',
                    fontSize: 24,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => saveTask(context),
                child: Text('Сохранить изменения'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.amber),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () => deleteTask(context),
                child: Text('Удалить задачу'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}