import 'dart:io';

import 'package:audioplayer/audioplayer.dart';
import 'package:chat_app_with_firebase/Auth/helper/auth_helper.dart';
import 'package:chat_app_with_firebase/Auth/helper/firestorage_helper.dart';
import 'package:chat_app_with_firebase/Auth/helper/firestore_helper.dart';
import 'package:chat_app_with_firebase/Auth/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatRoom extends StatefulWidget {
  // static final routeName = 'chatpage';
  String toId;
  ChatRoom(this.toId);
  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  String twoId;
  sendToFirestore() async {
    value.clear();
    await FirestoreHelper.firestoreHelper.addMessageChatRoom({
      'message': this.message,
      'dateTime': DateTime.now(),
      'ToId': widget.toId
    }, twoId);
  }

  ScrollController scrollController = ScrollController();

  TextEditingController value = TextEditingController();

  String message;
  @override
  void initState() {
    method();

    // TODO: implement initState
    super.initState();
  }

  method() {
    int toId = widget.toId.codeUnitAt(0);
    int fromId = AuthHelper.authHelper.getUserId().codeUnitAt(0);
    if (toId <= fromId) {
      twoId = widget.toId + AuthHelper.authHelper.getUserId();
    } else {
      twoId = AuthHelper.authHelper.getUserId() + widget.toId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
        backgroundColor: Colors.red[400],
      ),
      body: Consumer<AuthProvider>(builder: (context, provider, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirestoreHelper.firestoreHelper
                      .getFirestoreStreamChatRoom(twoId),
                  builder: (context, datasnapsht) {
                    if (!datasnapsht.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.red[400],
                        ),
                      );
                    } else {
                      Future.delayed(Duration(milliseconds: 100)).then((value) {
                        scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 100),
                            curve: Curves.easeInOut);
                      });
                      QuerySnapshot<Map<String, dynamic>> querySnapShot =
                          datasnapsht.data;
                      List<Map> messages =
                          querySnapShot.docs.map((e) => e.data()).toList();
                      messages.sort((a, b) => a['dateTime']
                          .toString()
                          .compareTo(b['dateTime'].toString()));
                      return ListView.builder(
                          shrinkWrap: true,
                          controller: scrollController,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return messages[index]['From'] ==
                                    AuthHelper.authHelper.getUserId().trim()
                                ? Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        maxHeight:
                                            MediaQuery.of(context).size.height *
                                                0.3),
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(
                                        top: 10, bottom: 10, right: 80),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.red[400]),
                                    child: messages[index]['imageUrl'] == null &&
                                            messages[index]['audioUrl'] == null
                                        ? Text(
                                            "${messages[index]['message']}",
                                            style: TextStyle(
                                                color: Colors.black38),
                                          )
                                        : messages[index]['message'] == null &&
                                                messages[index]['audioUrl'] ==
                                                    null
                                            ? Image.network(
                                                messages[index]['imageUrl'],
                                                fit: BoxFit.cover,
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        provider.play(
                                                            messages[index]
                                                                ['audioUrl']);
                                                      },
                                                      icon: Icon(Icons.stop)),
                                                ],
                                              ))
                                : Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        maxHeight:
                                            MediaQuery.of(context).size.height *
                                                0.3),
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(top: 10, bottom: 10, left: 80),
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(15), color: Colors.white38),
                                    child: messages[index]['imageUrl'] == null && messages[index]['audioUrl'] == null
                                        ? Text(
                                            "${messages[index]['message']}",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )
                                        : messages[index]['message'] == null && messages[index]['audioUrl'] == null
                                            ? Image.network(
                                                messages[index]['imageUrl'],
                                                fit: BoxFit.cover,
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        provider.play(
                                                            messages[index]
                                                                ['audioUrl']);
                                                      },
                                                      icon: Icon(Icons.stop)),
                                                ],
                                              ));
                          });
                    }
                  },
                ),
              )),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  provider.sendImageToChatRoom(
                                      this.twoId, widget.toId);
                                },
                                icon: Icon(Icons.attach_file)),
                            Expanded(
                                child: TextField(
                              controller: value,
                              onChanged: (x) {
                                this.message = x;

                                x = this.value.text;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            )),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: IconButton(
                          onPressed: () {
                            sendToFirestore();
                          },
                          icon: Icon(Icons.send)),
                    ),
                    Container(
                      child: GestureDetector(
                        onLongPress: () {
                          provider.startRecord();
                        },
                        onLongPressEnd: (details) {
                          provider.stopRecordChatRoom(
                              provider.recordPath, widget.toId, twoId);
                        },
                        child: Container(
                          child: Icon(Icons.mic),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
