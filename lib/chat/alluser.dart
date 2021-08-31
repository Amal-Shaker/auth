import 'package:chat_app_with_firebase/Auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllUser extends StatelessWidget {
  static final routeName = 'allUser';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Users'),
      ),
      body: Consumer<AuthProvider>(builder: (context, provider, x) {
        if (provider.users == null) {
          return Center(
            child: CircularProgressIndicator(),
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
                      radius: 40,
                      backgroundImage:
                          NetworkImage(provider.users[index].imageUrl),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
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
