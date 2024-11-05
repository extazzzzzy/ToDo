import 'package:flutter/material.dart';

class CreateTaskScreen extends StatelessWidget {
  void createTask() {

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
                  onPressed: createTask,
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