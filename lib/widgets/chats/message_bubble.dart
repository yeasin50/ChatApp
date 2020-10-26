import 'package:flutter/material.dart';

class MessagaeBubble extends StatelessWidget {
  MessagaeBubble(
      this.message, this.username, this.imageUrl, this.isMe, this.key);

  final bool isMe;
  final String message;
  final Key key;
  final String username;
  final String imageUrl;

  Widget build(BuildContext context) {
    print(isMe);

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Stack(children: [
          Container(
            decoration: BoxDecoration(
              color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12,
            ),
            margin: EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: isMe ? 10 : 34,
              right: isMe ? 34 : 10,
            ),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  message,
                  style: TextStyle(
                    color: isMe
                        ? Colors.black
                        : Theme.of(context).accentTextTheme.headline6.color,
                  ),
                  textAlign: isMe ? TextAlign.end : TextAlign.start,
                ),
              ],
            ),
          ),
          Positioned(
            child: CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(imageUrl),
            ),
            bottom: 0,
            left: isMe ? null : 2,
            right: isMe ? 4 : null,
          ),
        ]),
      ],
    );
  }
}
