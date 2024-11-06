import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/CreateTaskScreen.dart';
import 'package:todo/EditTaskScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> tasks = [];
  String currentFilter = 'Все';

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
  }

  void saveTasks(tasks) async { // сохранение нового массива заданий
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasks', tasks);
  }

  void changeFilter() {
    setState(() {
      if (currentFilter == 'Все') {
        currentFilter = 'Невыполненные';
      }
      else if (currentFilter == 'Невыполненные') {
        currentFilter = 'Выполненные';
      }
      else {
        currentFilter = 'Все';
      }
    });
  }

  Widget buildTaskRow(int index, bool currentCheckboxIndex) {
    return Row(
      children: [
        Checkbox(
          value: currentCheckboxIndex,
          onChanged: (bool? newValue) {
            setState(() {
              if (currentCheckboxIndex == false) {
                currentCheckboxIndex = true;
                tasks[index + 2] = 'true';
                saveTasks(tasks);
              }
              else {
                currentCheckboxIndex = false;
                tasks[index + 2] = 'false';
                saveTasks(tasks);
              }
            });
          },
          activeColor: Colors.amber,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditTaskScreen(
                  titleIndex: index,
                  descriptionIndex: index + 1,
                ),
              ),
            );
          },
          child:
          Text(
            tasks[index],
            style: TextStyle(
              fontFamily: 'DushaRegular',
              fontSize: 20,
              decoration: currentCheckboxIndex ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ToDo',
              style: TextStyle(
                fontFamily: 'DushaRegular',
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            GestureDetector(
              onTap: () {
                changeFilter();
              },
              child:
              Text(
                currentFilter,
                style: TextStyle(
                  fontFamily: 'DushaRegular',
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Color.fromRGBO(255, 228, 181, 1),
      ),

      backgroundColor: Color.fromRGBO(255, 228, 181, 1),
      body: ListView.builder(
        itemCount: tasks.length + 1,
        itemBuilder: (context, index) {
          // условия отображения задач
          if (tasks.length == 0) {
            return ListTile(
              title:
                Text(
                  'Список дел/задач пуст',
                  style: TextStyle(
                    fontFamily: 'DushaRegular',
                    fontSize: 20,
                  ),
                ),
            );
          }
          else if ((index == 0 || index % 3 == 0) && index != tasks.length) {
            var currentCheckboxIndex = false;
            if (tasks[index + 2] == 'false') {currentCheckboxIndex = false;}
            else {currentCheckboxIndex = true;}
            if (currentFilter == 'Все'){
              return buildTaskRow(index, currentCheckboxIndex);
            }
            else if (currentFilter == 'Невыполненные' && tasks[index + 2] == 'false') {
              return buildTaskRow(index, currentCheckboxIndex);
            }
            else if (currentFilter == 'Выполненные' && tasks[index + 2] == 'true') {
              return buildTaskRow(index, currentCheckboxIndex);
            }
            else {
              return Container();
            }
          }
          else {
            return Container();
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTaskScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}