import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('chats/HuBfqAeaAlPLPc6qpou7/messages')
              .snapshots(),
          builder: (ctx, streamSnap) {
            if (streamSnap.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());

            final documents = streamSnap.data.documents;
            return ListView.builder(
              // itemCount: streamSnap.data.documents.lenght,
              itemCount: documents.length,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(8),
                child: Text(documents[index]['text']),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            // FIXME: done: core/no-app] No Firebase App '[DEFAULT]' has been created - call Firebase.initializeApp()
            // Firestore.instance
            //     .collection('chats/HuBfqAeaAlPLPc6qpou7/messages')
            //     .snapshots()
            //     .listen((data) {
            //   // print(data.documents[0]['text']);
            //   data.documents.forEach((element) {
            //     print(element['text']);
          }),
    );
  }
}
