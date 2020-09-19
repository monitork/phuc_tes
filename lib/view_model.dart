import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:huynh_tes/user.dart';

class CustomerViewModel extends ChangeNotifier {
  List<User> contactslist = [];
  List<String> strList = [];
  List<Widget> normalList = [];
  TextEditingController searchController = TextEditingController();

  void initialise() {
    for (int i = 0; i < 100; i++) {
      var name = faker.person.name();
      contactslist.add(User(
          img: "http://placeimg.com/200/200/people",
          name: name,
          geneder: "nam",
          phoneNumber: "039532100",
          date: "2020-08-11",
          address: "bình đào",
          email: "phuchuynh@gmail.com",
          namecompany: "phuchuynh",
          count: 24));
    }
    this.filterList();
    notifyListeners();
  }

  void filterList() {
    List<User> users = [];
    users.addAll(contactslist);
    if (searchController.text.isNotEmpty) {
      users.retainWhere((user) => user.name
          .toLowerCase()
          .contains(searchController.text.toLowerCase()));
    }
    users.forEach((user) {
      normalList.add(
        Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: <Widget>[
            IconSlideAction(
              iconWidget: Icon(Icons.star),
              onTap: () {},
            ),
            IconSlideAction(
              iconWidget: Icon(Icons.more_horiz),
              onTap: () {},
            ),
          ],
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage("http://placeimg.com/200/200/people"),
            ),
            title: Text(user.name),
            subtitle: Text(user.namecompany),
          ),
        ),
      );
      strList.add(user.name);
    });
    notifyListeners();
  }
}
