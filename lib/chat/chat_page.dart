import 'package:chat_app_with_firebase/Auth/helper/auth_helper.dart';
import 'package:chat_app_with_firebase/Auth/helper/firestorage_helper.dart';
import 'package:chat_app_with_firebase/Auth/helper/firestore_helper.dart';
import 'package:chat_app_with_firebase/Auth/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatelessWidget {
  static final routeName = 'chatpage';
  sendToFirestore() async {
    await FirestoreHelper.firestoreHelper.addMessageToFirestore(
        {'message': this.message, 'dateTime': DateTime.now()});
  }

  TextEditingController value = TextEditingController();
  String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Page'),
      ),
      body: Consumer<AuthProvider>(builder: (context, provider, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirestoreHelper.firestoreHelper.getFirestoreStream(),
                  builder: (context, datasnapsht) {
                    QuerySnapshot<Map<String, dynamic>> querySnapShot =
                        datasnapsht.data;
                    List<Map> messages =
                        querySnapShot.docs.map((e) => e.data()).toList();
                    messages.sort((a, b) => a['dateTime']
                        .toString()
                        .compareTo(b['dateTime'].toString()));
                    return ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return messages[index]['userId'] ==
                                  AuthHelper.authHelper.getUserId()
                              ? Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(
                                      top: 10, bottom: 10, right: 80),
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.blueAccent),
                                  child: Text(
                                    messages[index]['message'],
                                    style: TextStyle(color: Colors.black38),
                                  ))
                              : Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 80),
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white38),
                                  child: Text(
                                    "${messages[index]['message']}",
                                    style: TextStyle(color: Colors.black),
                                  ));
                        });
                  },
                ),
              )),
              Container(
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: value,
                      onChanged: (x) {
                        this.message = x;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    )),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: IconButton(
                          onPressed: () {
                            sendToFirestore();
                          },
                          icon: Icon(Icons.send)),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
