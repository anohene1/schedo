import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedo_final/view/components/components.dart';
import 'screens.dart';

class NavigationIndexedStackIndex extends ChangeNotifier {
  int index;

  NavigationIndexedStackIndex({this.index = 0});

  // Set new index for the index variable for the IndexedStack widget to consume
  void setIndex(int number) {
    index = number;
    notifyListeners();
  }
}

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    int _currentIndex = Provider.of<NavigationIndexedStackIndex>(context).index;

    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.only( left: 70, right: 70),
          margin: EdgeInsets.only(bottom: 10),
          // height: 50,
          child: Material(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Consumer<NavigationIndexedStackIndex>(
                    builder: (context, index, child) {
                      return IconButton(
                        icon: Icon(CupertinoIcons.home, color: _currentIndex == 0 ? Theme.of(context).primaryColor : Theme.of(context).dividerColor, size: 30,),
                        onPressed: (){
                          index.setIndex(0);
                        },
                      );
                    },
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    child: Icon(Icons.add, color: Colors.white, size: 25,),
                    decoration: BoxDecoration(
                        color: pink,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                              color: pink,
                              blurRadius: 5,
                              spreadRadius: 0.1
                          )
                        ]
                    ),
                  ),
                  Consumer<NavigationIndexedStackIndex>(
                    builder: (context, index, child){
                      return IconButton(
                        icon: Icon(CupertinoIcons.settings, color: _currentIndex == 1 ? Theme.of(context).primaryColor : Theme.of(context).dividerColor, size: 30,),
                        onPressed: (){
                          index.setIndex(1);
                        },
                      );
                    },
                  )
                ],
              )
          ),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(),
          SettingsScreen()
        ],
      ),
    );
  }
}
