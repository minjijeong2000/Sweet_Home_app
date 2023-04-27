import 'package:flutter/material.dart';

import 'friend_data.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();

  static builder({required int itemCount, required Container Function(BuildContext context, int index) itemBuilder}) {}
}

class _ListViewPageState extends State<ListViewPage> {

  final List<String> entries = <String>['Alice', 'John', 'Sam', 'Zach'];
  final List<String> phones = <String>['909-999-0000', '909-999-0001', '909-999-0002', '909-999-0003'];

  late List<Friend> friends;

  _ListViewPageState() {
    Friend f1 = Friend("Alice", "909-999-0000", "https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png", "MOBILE");
    Friend f2 = Friend("John", "909-999-0001", "https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png", "HOME");
    Friend f3 = Friend("Helen", "909-999-0002", "https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png", "MOBILE");
    Friend f4 = Friend("Eunice", "909-999-0003", "https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png", "MOBILE");

    friends = [f1, f2, f3, f4];

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              print("The item is clicked");
            },
            title: Container(
              height: 50,
              margin: const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('${friends[index].imageurl}'),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          '${friends[index].name}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                      ),
                      Text('${friends[index].phone}'),
                      Text('${friends[index].type}'),
                    ],
                  ),
                  const Spacer(),
                  const Text('MOBILE')
                ],
              )
            ),
          );
        }
      )
      );
  }
}
