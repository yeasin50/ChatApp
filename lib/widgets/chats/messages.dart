import 'dart:developer';

import '../chats/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy(
              'timeStamp',
              descending: true,
            )
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = chatSnapshot.data.documents;
          return ListView.builder(
            reverse: true,
            itemCount: docs.length,
            itemBuilder: (ctx, index) => MessagaeBubble(
              docs[index]['text'],
              docs[index]['username'],
              docs[index]['userImage'],
              docs[index]['userId'] == FirebaseAuth.instance.currentUser.uid,
              ValueKey(docs[index].documentID),
            ),
          );
        });
  }
}
