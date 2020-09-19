import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';

import '../user.dart';
import '../view_model.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<User> userList = [];
  List<String> strList = [];
  List<Widget> normalList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    userList
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    filterList(userList);
    searchController.addListener(() {
      filterList(userList);
    });
    super.initState();
  }

  filterList(List<User> userlist) {
    List<User> users = [];
    users.addAll(userList);
    normalList = [];
    strList = [];
    if (searchController.text.isNotEmpty) {
      users.retainWhere((user) => user.name
          .toLowerCase()
          .contains(searchController.text.toLowerCase()));
    }
    users.forEach((user) {
      normalList.add(Container(
        width: MediaQuery.of(context).size.width,
        // height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.img),
                ),
                title: Container(
                  padding: EdgeInsets.only(right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(user.name),
                      ),
                      Expanded(
                        //flex: 1,
                        child: Container(
                          // color: Colors.amberAccent,
                          width: 40,
                          height: 25,
                          // margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: Color(0xFFFBF6E8),
                              border: Border.all(
                                  color: Colors.amberAccent, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          child: Center(
                            child: Text(user.count.toString()),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Text(user.date),
                trailing: Container(
                  padding: EdgeInsets.only(right: 40),
                  child: Icon(Icons.message),
                ),
              ),
            ))
          ],
        ),
      ));
      strList.add(user.name);
    });

    setState(() {
      strList;
      normalList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CustomerViewModel>.withConsumer(
        viewModelBuilder: () => CustomerViewModel(),
        onModelReady: (model) => model.initialise(),
        createNewModelOnInsert: true,
        builder: (context, model, _) => DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Dashboard'),
                  bottom: TabBar(tabs: [
                    Tab(text: "Danh sách"),
                    Tab(text: "Nhóm"),
                  ]),
                ),
                body: TabBarView(
                  children: [
                    Center(
                      child: Text('text'),
                    ),
                    Center(
                      child: Text('text'),
                    )
                  ],
                ),
              ),
            ));
  }

  Widget _listContact() {
    return Container(
      child: AlphabetListScrollView(
        strList: strList,
        highlightTextStyle: TextStyle(
          color: Colors.yellow,
        ),
        showPreview: true,
        itemBuilder: (context, index) {
          return normalList[index];
        },
        indexedHeight: (i) {
          return 80;
        },
        keyboardUsage: true,
        headerWidgetList: <AlphabetScrollListHeader>[
          AlphabetScrollListHeader(widgetList: [
            Container(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(decoration: InputDecoration()),
                    ),
                  ),
                  Expanded(child: Icon(Icons.filter)),
                ],
              ),
            ),
          ], icon: Icon(Icons.search), indexedHeaderHeight: (index) => 80),
        ],
      ),
    );
  }
}
