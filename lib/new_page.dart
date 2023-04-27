import 'package:flutter/material.dart';
import 'package:flutter_app_demo/next_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app_demo/user_profile.dart';


class newPage extends StatefulWidget {
  final String choreName;
  final List<String> selectedDays;
  final TimeOfDay selectedTime;

  const newPage({Key? key,
    required this.choreName,
    required this.selectedDays,
    required this.selectedTime,}) : super(key: key);

  @override
  State<newPage> createState() => _newPageState();
}

class _newPageState extends State<newPage> {
  String? _updatedChoreName;
  List<String>? _updatedSelectedDays;
  TimeOfDay? _updatedSelectedTime;

  @override
  void initState() {
    _updatedChoreName = widget.choreName;
    _updatedSelectedDays = List<String>.from(widget.selectedDays);
    _updatedSelectedTime = widget.selectedTime;
    super.initState();
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
                      child: Text('Schedule',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Chore Name: $_updatedChoreName',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Selected Days: ${_updatedSelectedDays?.join(", ")}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Selected Time: ${_updatedSelectedTime?.format(context)}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _updatedChoreName = 'Updated Chore Name';
                        _updatedSelectedDays = ['Monday', 'Wednesday', 'Friday'];
                        _updatedSelectedTime = TimeOfDay(hour: 10, minute: 30);
                      });
                    },
                    child: Text('Update Data'),
                  ),
                ],
              ),
            )
      ],
    )
    );
  }
}
