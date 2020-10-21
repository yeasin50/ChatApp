import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  NewMessage({Key key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _newMsg = '';
  final _controller = new TextEditingController();

  void _sendMessage() {
    FocusScope.of(context).unfocus();

    FirebaseFirestore.instance.collection('chat').add({
      'text': _newMsg,
      'timeStamp': Timestamp.now(),
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "send a message...."),
              onChanged: (value) {
                setState(() {
                  _newMsg = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _newMsg.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
