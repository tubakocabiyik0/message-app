import 'package:flutter/material.dart';
import 'package:flutter_message/common_widgets/textformfield.dart';
import 'package:flutter_message/model/message.dart';
import 'package:flutter_message/model/user.dart';
import 'package:flutter_message/viewmodel/auth_provider.dart';
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
  var provider;
  var currentUserId;
  var talkUserId;

  @override
  Widget build(BuildContext context) {
    currentUserId = widget.currentUser.UserId;
    talkUserId = widget.talkUser.UserId;

    provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.talkUser.userName),
      ),
      body: talkPage(context),
    );
  }

  talkPage(BuildContext context) {
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
              } else {
                return listView(
                    messages.data, context, currentUserId, talkUserId);
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
                    onPressed: () {
                      if (messageController.text.trim().length > 0) {
                        Message saveMessage = new Message(
                            sendMessage: currentUserId.text,
                            fromMe: true,
                            takeMessage: talkUserId,
                            message: messageController.text);
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

  listView(List<Message> data, BuildContext context, currentUser, talkUser) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Text("a");
        });
  }
}
