import 'package:chat_app_with_firebase/Auth/providers/auth_provider.dart';
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
        title: Text('ProfilePage'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
          IconButton(onPressed: () {}, icon: Icon(Icons.logout))
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return provider.user == null
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(provider.user.imageUrl),
                    ),
                    ItemWidget("First Name", provider.user.fName),
                    ItemWidget("Last Name", provider.user.lName),
                    ItemWidget("Country", provider.user.country),
                    ItemWidget("City", provider.user.city),
                    ItemWidget("Email", provider.user.email),
                  ],
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text(value)],
      ),
    );
  }
}
