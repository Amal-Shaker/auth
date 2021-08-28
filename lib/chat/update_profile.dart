import 'package:chat_app_with_firebase/Auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatelessWidget {
  static final routeName = 'updateProfile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Update profile'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .updateProfile();
              },
              icon: Icon(Icons.done))
        ],
      ),
      body: Consumer<AuthProvider>(builder: (context, provider, x) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  provider.captureUpdateProfileImage();
                },
                child: provider.updatedFile == null
                    ? CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(provider.user.imageUrl))
                    : CircleAvatar(
                        radius: 80,
                        backgroundImage: FileImage(provider.updatedFile),
                      ),
              ),
              ItemWidget("First Name", provider.fNmaeController),
              ItemWidget("Last Name", provider.lNameController),
              ItemWidget("Country", provider.countryController),
              ItemWidget("City", provider.cityController),
            ],
          ),
        );
      }),
    );
  }
}

class ItemWidget extends StatelessWidget {
  String label;
  TextEditingController valuecontrollor;
  ItemWidget(this.label, this.valuecontrollor);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: TextField(
            controller: valuecontrollor,
            style: TextStyle(fontSize: 22),
          ))
        ],
      ),
    );
  }
}
