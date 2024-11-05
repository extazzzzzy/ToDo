import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/CreateTaskScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isChecked = false;
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

      body: ListView.builder(
        itemCount: tasks.length + 1,
        itemBuilder: (context, index) {
          if (tasks.length == 0) {
            return ListTile(
                title:
                Text(
                  'Список дел/задач пуст',
                  style: TextStyle(
                    fontFamily: 'DushaRegular',
                    fontSize: 20,
                  ),
                )
            );
          }
          else if ((index == 0 || index % 3 == 0) && index != tasks.length) {
            return ListTile(
              title:
              Text(
                tasks[index],
                style: TextStyle(
                  fontFamily: 'DushaRegular',
                  fontSize: 20,
                ),
              )
            );
          }
          else {
            return Container();
          }
        },
      ),

      // body: Padding(
      //   padding: EdgeInsets.only(left: 20.0),
      //   child: Row(
      //     children: [
      //       Checkbox(
      //         value: isChecked,
      //         onChanged: (bool? newValue) {
      //           setState(() {
      //             if (isChecked == false) {isChecked = true;}
      //             else {isChecked = false;}
      //           });
      //         },
      //         activeColor: Colors.amber,
      //       ),
      //       Text(
      //         'Здесь будут задачи',
      //         style: TextStyle(
      //           fontFamily: 'DushaRegular',
      //           fontSize: 24,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
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