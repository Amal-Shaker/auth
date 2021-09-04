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

class ChatPage extends StatefulWidget {
  static final routeName = 'chatpage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  sendToFirestore() async {
    value.clear();
    await FirestoreHelper.firestoreHelper.addMessageToFirestore(
        {'message': this.message, 'dateTime': DateTime.now()});
  }

  bool isPlaying = false;
  ScrollController scrollController = ScrollController();

  TextEditingController value = TextEditingController();
  String recordFilePath;

  String message;
  bool isPlayingMsg = false, isRecording = false, isSending = false;
  int i = 0;
  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
  }

  // String stval;
  // uploadAudio() async {
  //   stval = await FirestorgeHelper.firestorgeHelper
  //       .uploadAudio(File(recordFilePath));
  //   await sendAudioMsg(stval);
  // }

  Future<void> play(String path) async {
    print('before if');

    // && File(path).existsSync()
    if (path != null) {
      AudioPlayer audioPlayer = AudioPlayer();
      // setState(() {
      //   this.isPlaying = true;
      // });
      print('before play');
      await audioPlayer.play(
        path,
        isLocal: true,
      );
      // setState(() {
      // //  this.isPlaying = false;
      // });
      // audioPlayer.
      print('after play');
    }
  }
  // Future _loadFile(String url) async {
  //   final bytes = await readBytes(url);
  //   final dir = await getApplicationDocumentsDirectory();
  //   final file = File('${dir.path}/audio.mp3');

  //   await file.writeAsBytes(bytes);
  //   if (await file.exists()) {
  //     setState(() {
  //       recordFilePath = file.path;
  //       isPlayingMsg = true;
  //       print(isPlayingMsg);
  //     });
  //     await play();
  //     setState(() {
  //       isPlayingMsg = false;
  //       print(isPlayingMsg);
  //     });
  //   }
  // }

  // sendAudioMsg(String audioMsg) async {
  //   print('audiooooooooooooooooo $audioMsg');
  //   if (audioMsg.isNotEmpty) {
  //     var ref = FirebaseFirestore.instance.collection('Chats').doc();
  //     await FirebaseFirestore.instance.runTransaction((transaction) async {
  //       await transaction.set(ref, {
  //         "userId": AuthHelper.authHelper.getUserId(),
  //         "timestamp": DateTime.now(),
  //         "audio": audioMsg,
  //         "type": 'audio'
  //       });
  //     }).then((value) {
  //       setState(() {
  //         isSending = false;
  //       });
  //     });
  //     scrollController.animateTo(0.0,
  //         duration: Duration(milliseconds: 100), curve: Curves.bounceInOut);
  //   } else {
  //     print("Hello");
  //   }
  // }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      recordFilePath = await getFilePath();

      RecordMp3.instance.start(recordFilePath, (type) {
        setState(() {});
      });
    } else {}
    setState(() {});
  }

  void stopRecord() async {
    bool s = RecordMp3.instance.stop();
    if (s) {
      setState(() {
        isSending = true;
      });
      // await FirestorgeHelper.firestorgeHelper.uploadAudio(recordFilePath);
      await Provider.of<AuthProvider>(context, listen: false)
          .sendAudioToChats(File(recordFilePath));
    } else {
      print('NO thing done');
    }

    setState(() {
      isPlayingMsg = false;
    });
  }

  String currentRecord;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Page'),
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
                  stream: FirestoreHelper.firestoreHelper.getFirestoreStream(),
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
//this.currentRecord = messages[index]['userId'];
                            return messages[index]['userId'] ==
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
                                    // height: 40,
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
                                                        // setState(() {
                                                        //   this.currentRecord =
                                                        //       messages[index]
                                                        //           ['userId'];
                                                        // });

                                                        // print(messages[index]
                                                        //     ['userId']);
                                                        play(messages[index]
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
                                    // height: 40,
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
                                                        // setState(() {
                                                        //   this.currentRecord =
                                                        //       messages[index]
                                                        //           ['userId'];
                                                        // });

                                                        // print(messages[index]
                                                        //     ['userId']);
                                                        play(messages[index]
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
                                  provider.sendImageToChats();
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
                          startRecord();
                          setState(() {
                            isRecording = true;
                          });
                        },
                        onLongPressEnd: (details) {
                          stopRecord();
                          setState(() {
                            isRecording = false;
                          });
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
