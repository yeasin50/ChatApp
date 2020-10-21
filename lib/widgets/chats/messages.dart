import 'package:chatApp/widgets/chats/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chat")
            .orderBy("timeStamp", descending: true)
            .snapshots(),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          var docs = snapShot.data.documents;
          final uId = FirebaseAuth.instance.currentUser;

          return
              //  FutureBuilder(
              //FIXME ::: currentUser  not return future
              // future: FirebaseAuth.instance.currentUser,
              // builder: (ctx, snapShot) =>

              ListView.builder(
            reverse: true,
            itemCount: docs.length,
            itemBuilder: (ctx, i) => MessagaeBubble(
              docs[i]['text'],
              docs[i]['userId'] == uId ? true : false,
              // this help to separate every msg and improve overllap msg 
              key: ValueKey(docs[i].documentID),
            ),
          );
        });
  }
}
