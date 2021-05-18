import 'package:flutter/material.dart';
import 'package:flutter_message/common_widgets/textformfield.dart';
import 'package:flutter_message/model/user.dart';

class TalkPage extends StatefulWidget {
  final Users currentUser;
  final Users talkUser;

  const TalkPage({Key key, this.currentUser, this.talkUser}) : super(key: key);

  @override
  _TalkPageState createState() => _TalkPageState();
}

class _TalkPageState extends State<TalkPage> {
  var messageController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.talkUser.userName),),
      body: talkPage(context),
    );

  }

  talkPage(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(child: ListView(
            children: [
              Text("Talks"),

            ],
          )),
          Container(
            child: Row(
              children: [
                Expanded(child: Textformfield(labelText: "Write message",obscureText: false,controller:messageController,)),
                Container(margin: EdgeInsets.symmetric(horizontal: 4),
                child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.navigate_next,
                     size: 35,
                    color: Colors.white,

                  ),
                  onPressed: (){

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
}
