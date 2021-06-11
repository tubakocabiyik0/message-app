import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_message/common_widgets/textformfield.dart';
import 'package:flutter_message/model/message.dart';
import 'package:flutter_message/model/user.dart';
import 'package:flutter_message/viewmodel/auth_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TalkPage extends StatefulWidget {
  final Users currentUser;
  final Users talkUser;

  const TalkPage({Key key, this.currentUser, this.talkUser}) : super(key: key);

  @override
  _TalkPageState createState() => _TalkPageState();
}

class _TalkPageState extends State<TalkPage> {
  var messageController = TextEditingController();
  var _listController = new ScrollController();
  var currentUserId;
  var talkUserId;
  Message message;

  @override
  Widget build(BuildContext context) {
    currentUserId = widget.currentUser.UserId;
    talkUserId = widget.talkUser.UserId;

    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(backgroundImage: NetworkImage(widget.talkUser.profilPhoto)),
        title: Text(widget.talkUser.userName),
      ),
      body: talkPage(context),
    );
  }

  talkPage(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    return Center(
      child: Column(
        children: [
          Expanded(
              child: StreamBuilder<List<Message>>(
            stream: provider.getMessages(currentUserId, talkUserId),
            builder: (context, messages) {
              if (!messages.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (messages.hasData) {
                return ListView.builder(
                    reverse: true,
                    controller: _listController,
                    itemCount: messages.data.length,
                    itemBuilder: (context, index) {
                      return messageBoxs(
                          context, messages, messages.data[index]);
                    });
              }
            },
          )),
          Container(
            child: Row(
              children: [
                Expanded(
                    child: Textformfield(
                  labelText: "Write message",
                  obscureText: false,
                  controller: messageController,
                )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: FloatingActionButton(
                    elevation: 0,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.navigate_next,
                      size: 35,
                      color: Colors.white,
                    ),
                    onPressed: () async {

                      if (messageController.text.trim().length > 0) {
                        message = new Message(
                            sendMessage: currentUserId,
                            fromMe: true,
                            takeMessage: talkUserId,
                            message: messageController.text);
                        var result = await provider.saveMessage(message);
                        if (result == true) {
                          //mesaj gidince mesaj alanını boşalttık
                          messageController.clear();
                          _listController.animateTo(0.0,
                              duration: const Duration(milliseconds: 10),
                              curve: Curves.easeOut);

                        }
                      }
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  messageBoxs(BuildContext context, AsyncSnapshot<List<Message>> messages,
      Message message) {
    Color incomingMessage = Colors.blueAccent.shade100;
    Color sendMessage = Colors.purple.shade300;
    var time;
    try {
      time = showTime(message.date ?? Timestamp.now());
    } catch (e) {}

    var fromMe = message.fromMe;

    if (fromMe) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: sendMessage,
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(4),
                    child: Text(message.message),
                  ),
                ),
                Text(time),
              ],
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.talkUser.profilPhoto),
                ),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: incomingMessage,
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(4),
                    child: Text(message.message),
                  ),
                ),
                Text(time),
              ],
            ),
          ],
        ),
      );
    }
  }

  showTime(Timestamp date) {
    var _formatter = DateFormat.Hm();
    var _formatedDate = _formatter.format(date.toDate());
    return _formatedDate;
  }
}
