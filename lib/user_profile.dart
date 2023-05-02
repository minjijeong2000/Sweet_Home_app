import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/NextPage.dart';
import 'package:flutter_app_demo/next_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:day_picker/day_picker.dart';



class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  var nameController = TextEditingController();
  var dayController = TextEditingController();
  var timeController = TextEditingController();

  TimeOfDay _time = TimeOfDay.now();

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  final List<DayInWeek> _days = [
    DayInWeek(
      "Sun",
    ),
    DayInWeek(
      "Mon",
    ),
    DayInWeek(
        "Tue",
        isSelected: true
    ),
    DayInWeek(
      "Wed",
    ),
    DayInWeek(
      "Thu",
    ),
    DayInWeek(
      "Fri",
    ),
    DayInWeek(
      "Sat",
    ),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            'Create a new chore',
            style: GoogleFonts.caveat(fontSize: 30, fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          Image(
              image: AssetImage('assets/homelogo.png')
          ),
        ],
        backgroundColor: const Color(0xFFFF5722),
      ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepOrange
                ),
              child: Text('Menu')
              ),
              ListTile(
                title: Text('Schedule', style: GoogleFonts.caveat(),),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NextPage()),
                  );
                },
              ),
              ListTile(
                title: Text('Who is..?', style: GoogleFonts.caveat(),),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MySecondPage()),
                  );
                },
              ),
            ],
          ),
        ),
      body:Column(
        children:[
        Expanded(
        flex: 10,
        child: Row(
          children: [

          ],
        ),
      ),
              Expanded(
                flex: 100,
                child: Column(
                  children: [
                    Expanded(
                        flex: 8,
                        child: Container(
                          margin: const EdgeInsets.only(top: 0, bottom: 0),
                          child:
                          Text(
                              "Enter the name of chore:",
                              style: GoogleFonts.caveat(fontSize: 15, color: Colors.black)
                          ),
                        )
                    ),
                    Expanded(
                        flex: 23,
                        child: Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 0),
                          width: 400,
                          child: TextField(
                            controller: nameController,
                            obscureText: false,
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)
                              ),
                              border: OutlineInputBorder(),
                              hintText: 'Enter the name of chore',
                              labelText: 'Name',
                            ),
                            style: GoogleFonts.caveat(),
                          ),
                        )
                ),
                    Expanded(
                        flex: 8,
                        child: Container(
                          margin: const EdgeInsets.only(top: 7, bottom: 0),
                          child:
                          Text(
                              "Choose the day(s):",
                              style: GoogleFonts.caveat(fontSize: 15, color: Colors.black)
                          ),
                        )
                    ),
                    Expanded(
                      flex: 15,
                      child: Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 30),
                        width: 400,
                        child: SelectWeekDays(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          daysBorderColor: Colors.black,
                          days: _days,
                          backgroundColor: Colors.white,
                          daysFillColor: Colors.black,
                          selectedDayTextColor: Colors.white,
                          unSelectedDayTextColor: Colors.black,
                          boxDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          onSelect: (values) {
                            print(values);
                            final selectedDays = values.join(", ");
                            dayController.text = selectedDays;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                        flex:33,
                        child: Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 40),
                            width: 400,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.black)
                                      )
                                  ),
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.white)
                              ),
                              child: Text(
                                  "Choose the time",
                                  style: GoogleFonts.caveat(fontSize: 15, color: Colors.black)
                              ),
                              onPressed: () async {
                                TimeOfDay? selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                                );
                                if (selectedTime != null) {
                                  setState(() {
                                    timeController.text = selectedTime.format(context);
                                  });
                                }
                              },
                            )
                        )
                    ),
                    Expanded(
                      flex: 20,
                      child: Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 30),
                        width: 200,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.black)
                                  )
                              ),
                              backgroundColor: MaterialStatePropertyAll<Color>(Colors.deepOrangeAccent)
                          ),
                          onPressed: () {
                            print(nameController.text);
                            print(dayController.text);
                            print(timeController.text);

                            var timestamp = new DateTime.now().millisecondsSinceEpoch;

                            FirebaseDatabase.instance.reference().child("chores/cho" + timestamp.toString()).set(
                              {
                                "name" : nameController.text,
                                "day" : dayController.text,
                                "time" : timeController.text
                              }
                            ).then((value) {
                              print("Sucessfully created the chore");
                            }).catchError((error) {
                              print("Failed to create" + error.toString());
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NextPage()),
                            );
                          },
                          child: Text('Create',
                            style: GoogleFonts.caveat(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ]
      )
    );
  }
}