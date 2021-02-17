import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedo_final/model/models.dart';
import 'package:schedo_final/view/components/category_button.dart';
import 'package:schedo_final/view/components/components.dart';
import 'package:schedo_final/view/screens/screens.dart';

//Signed in user
User signedInUser = FirebaseAuth.instance.currentUser;


//Provides and sets the index for the IndexedStacked widget
class HomeIndexedStackIndex extends ChangeNotifier {
  int index;

  HomeIndexedStackIndex({this.index = 0});

  // Set new index for the index variable for the IndexedStack widget to consume
  void setIndex(int number) {
    index = number;
    notifyListeners();
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 40),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hello,',
                        style: TextStyle(
                            fontSize: 30,
                            color: Theme.of(context).dividerColor,
                            fontWeight: FontWeight.w100),
                      ),
                      Text(
                        signedInUser.displayName,
                        style: TextStyle(
                          fontSize: 30,
                          // color: text,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                  // Profile Picture
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        // color: darkGray,
                        borderRadius: BorderRadius.circular(100)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                        child: Image.network(signedInUser.photoURL),
                    ),
                  )
                ],
              ),
              VerticalSpacing(20),
              // Category Selection Buttons
              Container(
                  height: 65,
                  child: Consumer<Categories>(
                    builder: (context, cat, child) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cat.categoryCount,
                        itemBuilder: (context, index) {
                          var categoryItem = cat.categories[index];
                          return CategoryButton(
                            title: categoryItem.title,
                            isSelected: categoryItem.isSelected,
                            onTap: () {
                              cat.deselectAllCategories();
                              cat.setSelectStatus(categoryItem, true);
                              Provider.of<HomeIndexedStackIndex>(context,
                                      listen: false)
                                  .setIndex(index);
                            },
                          );
                        },
                      );
                    },
                  )),
              VerticalSpacing(30),
              // Main View
              Expanded(
                child: Container(
                  child: Consumer<HomeIndexedStackIndex>(
                    builder: (context, indexedStackIndex, child) {
                      return IndexedStack(
                        index: indexedStackIndex.index,
                        children: [
                          MyDayScreen(),
                          ImportantScreen(),
                          PlannedScreen(),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
