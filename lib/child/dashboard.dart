import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

import '../user.dart';
import '../view_model.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using the withConsumer constructor gives you the traditional viewmodel
    // binding which will rebuild when notifyListeners is called. This is used
    // when the model does not have to be consumed by multiple different UI's.
    return ViewModelProvider<CustomerViewModel>.withConsumer(
      viewModelBuilder: () => CustomerViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => DefaultTabController(
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
              _listContact(model, context),
              Center(
                child: Text('text'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _listContact(CustomerViewModel model, BuildContext context) {
    return Container(
      child: AlphabetListScrollView(
        strList: model.strList,
        highlightTextStyle: TextStyle(
          color: Colors.yellow,
        ),
        showPreview: true,
        itemBuilder: (context, index) {
          return model.normalList[index];
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
