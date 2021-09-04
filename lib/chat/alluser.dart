import 'package:chat_app_with_firebase/Auth/providers/auth_provider.dart';
import 'package:chat_app_with_firebase/chat/chat_page.dart';
import 'package:chat_app_with_firebase/chat/profile.dart';
import 'package:chat_app_with_firebase/out_services/route_helper.dart';
import 'package:chat_app_with_firebase/ui/page/chatRoom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllUser extends StatefulWidget {
  static final routeName = 'allUser';

  @override
  State<AllUser> createState() => _AllUserState();
}

class _AllUserState extends State<AllUser> {
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).getUserFromFirestore();
    // TODO: implement initState
    super.initState();
  }

  String ToId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Consumer<AuthProvider>(builder: (context, provider, x) {
        return InkWell(
          onTap: () {
            RouteHelper.routeHelper.goToPage(ProfilePage.routeName);
          },
          child: Drawer(
              child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              CircleAvatar(
                backgroundColor: Colors.red[400],
                radius: 60,
                backgroundImage: NetworkImage(provider.user.imageUrl),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(provider.user.fName + ' ' + provider.user.lName,
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(provider.user.email,
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
              )
            ],
          )),
        );
      }),
      appBar: AppBar(
        title: Text('All Users'),
        backgroundColor: Colors.red[400],
        actions: [
          IconButton(
              onPressed: () {
                RouteHelper.routeHelper.goToPage(ChatPage.routeName);
              },
              icon: Icon(Icons.group))
        ],
      ),
      body: Consumer<AuthProvider>(builder: (context, provider, x) {
        if (provider.users == null) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.red[400],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: provider.users.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red[400],
                      radius: 40,
                      backgroundImage:
                          NetworkImage(provider.users[index].imageUrl),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        this.ToId = provider.users[index].id;

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatRoom(this.ToId)));
                        print(provider.users[index].id);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(provider.users[index].fName +
                              ' ' +
                              provider.users[index].lName),
                          Text(provider.users[index].email),
                          Text(provider.users[index].country +
                              ' ' +
                              provider.users[index].city),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
