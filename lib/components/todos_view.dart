import 'package:flutter/material.dart';

class TodosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Material(
            elevation: 5,
            color: Theme.of(context).primaryColor,
            child: TabBar(
              tabs: [
                Tab(
                  text: 'PENDING',
                ),
                Tab(
                  text: 'DONE',
                ),
              ],
            )),
        Container()
      ]),
    );
  }
}
