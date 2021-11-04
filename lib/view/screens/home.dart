import 'package:awesome_notifications/awesome_notifications.dart';
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


class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then(
          (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              content: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(30)
                ),
                padding: EdgeInsets.only(top: 30),
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Notification Permission',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Gilroy',
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Text('Schedo would like to send you notifications to remind you of your tasks.', textAlign: TextAlign.center,),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: pink,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30))
                              ),
                              child: Center(
                                child: Text(
                                  "Don't send",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        HorizontalSpacing(2),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              AwesomeNotifications()
                                  .requestPermissionToSendNotifications()
                                  .then((_) => Navigator.pop(context));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: pink,
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(30))
                              ),
                              child: Center(
                                child: Text(
                                  'Send',
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AwesomeNotifications().actionStream.listen((receivedNotification) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });

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
                  // Container(
                  //   height: 45,
                  //   width: 45,
                  //   decoration: BoxDecoration(
                  //       // color: darkGray,
                  //       borderRadius: BorderRadius.circular(100)),
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(100),
                  //       child: Image.network(signedInUser.photoURL),
                  //   ),
                  // )
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
