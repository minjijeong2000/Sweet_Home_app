import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/next_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app_demo/user_profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';




class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {

  var choreList = [];

  void _deleteChore(String key) {
    FirebaseDatabase.instance.reference().child('chores/$key').remove();
    setState(() {
      choreList.removeWhere((chore) => chore['key'] == key);
    });
  }

  _NextPageState() {

    FirebaseDatabase.instance.reference().child("chores").once()
        .then((databaseEvent) {
      print("Successfully loaded the data");
      DataSnapshot dataSnapshot = databaseEvent.snapshot;
      print(dataSnapshot);
      print("Key:");
      print(dataSnapshot.key);
      print("Value:");
      print(dataSnapshot.value);
      var choreTempList = [];
      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic> values = dataSnapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          print(key);
          print(value);
          value['key'] = key;
          choreTempList.add(value);
        });
        print("Final Chore List:");
        print(choreTempList);
        choreList = choreTempList;
        setState(() {

        });
      }
    }).catchError((error) {
      print("Failed to load the data");
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Schedule',
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
              title: Text('Create a new chore', style: GoogleFonts.caveat(),),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfilePage()),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
              ],
            ),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: ListView.builder(
                itemCount: choreList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Container(
                      height: 50,
                      margin: EdgeInsets.only(
                          top: 5, bottom: 5, left: 20, right: 20),
                      child: Row(
                        children: [
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text('${choreList[index]['name']}',
                                      style: GoogleFonts.caveat(fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)
                                  ),
                                  margin: EdgeInsets.only(right: 20),
                                ),

                                Container(
                                  child: Text('${choreList[index]['day']}',
                                      style: GoogleFonts.caveat(
                                          fontSize: 12, color: Colors.black)
                                  ),
                                  margin: EdgeInsets.only(right: 20),
                                ),
                                Text('${choreList[index]['time']}',
                                    style: GoogleFonts.caveat(
                                        fontSize: 12, color: Colors.black)
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteChore(choreList[index]['key']),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  }