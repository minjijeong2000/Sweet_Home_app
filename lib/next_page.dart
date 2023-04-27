import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:rxdart/rxdart.dart';

class MySecondPage extends StatefulWidget {
  const MySecondPage({Key? key}) : super(key: key);

  @override
  State<MySecondPage> createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
  int _counter = 0;

  final selected = BehaviorSubject<int>();
  String rewards = '';

  List<String> items = [    'temp 1' , 'temp 2'  ];

  StreamController<String> controller = StreamController<String>();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _openDialogBox() async {
    String? newItem = await showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: Text('Add or delete item', style: GoogleFonts.caveat()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: controller,
                decoration: InputDecoration(hintText: 'Enter item',hintStyle: GoogleFonts.caveat()),
              ),
              SizedBox(height: 16),
              if (items.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select an item to delete:',style: GoogleFonts.caveat()),
                    SizedBox(height: 8),
                    DropdownButton<int>(
                      value: null,
                      onChanged: (index) {
                        setState(() {
                          items.removeAt(index!);
                        });
                        Navigator.of(context).pop(null);
                      },
                      items: [
                        for (int i = 0; i < items.length; i++)
                          DropdownMenuItem(
                            value: i,
                            child: Text(items[i].toString()),
                          ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Add',style: GoogleFonts.caveat()),
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
            ),
            TextButton(
              child: Text('Cancel',style: GoogleFonts.caveat()),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
          ],
        );
      },
    );
    if (newItem != null && newItem.isNotEmpty) {
      setState(() {
        items.add(newItem);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children:[
          Expanded(
          flex: 10,
          child: Row(
            children: [
              Expanded(
                flex: 15,
                child: IconButton(
                  icon: Icon(Icons.menu),
                  color: Colors.deepOrangeAccent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MySecondPage()),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 70,
                child: Container(
                  margin: const EdgeInsets.only(top:20, bottom:20, left:80),
                  child: Text('Who is..?',
                    style: GoogleFonts.caveat(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Expanded(
                flex: 15,
                child: Image(
                    image: AssetImage('assets/homelogo.png')
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 90,
          child: Column(
            children: [
          Expanded(
          child: FortuneWheel(
          selected: selected.stream,
            animateFirst: false,
            items: [
              for(int i = 0; i < items.length; i++)
                FortuneItem(child: Text(items[i].toString())),
            ],
            onAnimationEnd: () {
              setState(() {
                rewards = items[selected.value];
              });
              print(rewards);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(rewards.toString() + " is doing the chore today!",
                    style: GoogleFonts.caveat(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ),
        GestureDetector(
        onTap: () {
          setState(() {
            selected.add(Fortune.randomInt(0, items.length));
          });
        },
          child: Container(
            height: 40,
            width: 120,
            margin: const EdgeInsets.only(top:20, bottom:50),
            color: Colors.redAccent,
            child: Center(
              child: Text("SPIN",
                style: GoogleFonts.caveat(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
              GestureDetector(
                onTap: () {
                  _openDialogBox();
                },
                child: Container(
                  height: 40,
                  width: 400,
                  margin: const EdgeInsets.only(top:10, bottom:30),
                  color: Colors.redAccent,
                  child: Center(
                    child: Text("Add or Delete a person",
                      style: GoogleFonts.caveat(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
          ]
        ),
    );
  }
}
