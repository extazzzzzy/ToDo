import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/HomeScreen.dart';

class CreateTaskScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void createTask(BuildContext context) async {
    String title = titleController.text;
    String description = descriptionController.text;
    final prefs = await SharedPreferences.getInstance();
    if (title.isNotEmpty) { // заголовок введён
      List<String> tasks = prefs.getStringList('tasks') ?? [];
      if (description.isEmpty) { // описание отсутствует
        tasks.add('$title');
        tasks.add('Описание отсутствует');
        tasks.add('false');
        await prefs.setStringList('tasks', tasks);

        final snackBar = SnackBar(
          content: Text('Задача создана успешно!'),
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
        tasks.add('$title');
        tasks.add('$description');
        tasks.add('false');
        await prefs.setStringList('tasks', tasks);

        final snackBar = SnackBar(
          content: Text('Задача создана успешно!'),
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
                  onPressed: () => createTask(context),
                  child: Text('Создать'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
    );
  }
}