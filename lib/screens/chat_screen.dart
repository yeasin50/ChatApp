import '../widgets/chats/messages.dart';
import '../widgets/chats/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
     super.initState();

    //FOR ISO Permission ()> mainly
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(
      onMessage: (msg) {
        print(msg);
        return;
      },
      onLaunch: (message) {
        print(message);
        return;
      },
      onResume: (message) {
        print(message);
        return;
      },
    );
    // to get deviceinOF
    // fbm.getToken();
    fbm.subscribeToTopic("chat");
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        actions: <Widget>[
          DropdownButton(
            underline: Container(),
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Logout"),
                      ],
                    ),
                  ),
                  value: 'logout',
                ),
        
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
           
              }),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}

// FIXME:done:: formula
// : core/no-app] No Firebase App '[DEFAULT]' has been created - call Firebase.initializeApp()
// Firestore.instance
//     .collection('chats/HuBfqAeaAlPLPc6qpou7/messages')
//     .snapshots()
//     .listen((data) {
//   // print(data.documents[0]['text']);
//   data.documents.forEach((element) {
//     print(element['text']);

// StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection('chats/HuBfqAeaAlPLPc6qpou7/messages')
//               .snapshots(),
//           builder: (ctx, streamSnap) {
//             if (streamSnap.connectionState == ConnectionState.waiting)
//               return Center(child: CircularProgressIndicator());

//             final documents = streamSnap.data.documents;
//             return ListView.builder(
//               // itemCount: streamSnap.data.documents.lenght,
//               itemCount: documents.length,
//               itemBuilder: (context, index) => Container(
//                 padding: EdgeInsets.all(8),
//                 child: Text(documents[index]['text']),
//               ),
//             );
//           }),
