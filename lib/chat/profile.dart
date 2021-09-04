import 'package:chat_app_with_firebase/Auth/helper/auth_helper.dart';
import 'package:chat_app_with_firebase/Auth/providers/auth_provider.dart';
import 'package:chat_app_with_firebase/chat/update_profile.dart';
import 'package:chat_app_with_firebase/out_services/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static final routeName = 'profile';
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AuthProvider>(context, listen: false).getUserFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text('ProfilePage'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .fillControllers();
                RouteHelper.routeHelper.goToPage(UpdateProfile.routeName);
              },
              icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return provider.user == null
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red[400],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.red[400],
                        backgroundImage: NetworkImage(provider.user.imageUrl),
                      ),
                      ItemWidget("First Name", provider.user.fName),
                      ItemWidget("Last Name", provider.user.lName),
                      ItemWidget("Country", provider.user.country),
                      ItemWidget("City", provider.user.city),
                      ItemWidget("Email", provider.user.email),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  String label;
  String value;
  ItemWidget(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          Text(value, style: TextStyle(fontSize: 22))
        ],
      ),
    );
  }
}
