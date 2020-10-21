import 'package:flutter/material.dart';

class MessagaeBubble extends StatelessWidget {
  MessagaeBubble(this.message, this.isMe, {this.key});

  final bool isMe;
  final String message;
  final Key key;

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0),
              bottomRight: isMe ? Radius.circular(12) : Radius.circular(0),
            ),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 4,
          ),
          child: Text(
            message,
            style: TextStyle(
              color: Theme.of(context).accentTextTheme.headline6.color,
            ),
          ),
        ),
      ],
    );
  }
}
