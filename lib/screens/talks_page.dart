import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_message/model/Talks.dart';
import 'package:flutter_message/model/user.dart';
import 'package:flutter_message/screens/talkPage.dart';
import 'package:flutter_message/viewmodel/auth_provider.dart';
import 'package:provider/provider.dart';

class TalksPage extends StatefulWidget {
  @override
  _TalksPageState createState() => _TalksPageState();
}

class _TalksPageState extends State<TalksPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Recent Talks"),
        backgroundColor: Colors.purple.shade300,
      ),
      body: RefreshIndicator(
        onRefresh: freshPage,
        child: FutureBuilder<List<Talks>>(
          future: provider.getAllTalks(provider.users.UserId),
          builder: (context, result) {
            if (!result.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              print(result.data.length);

              return ListView.builder(
                  itemCount: (result.data.length),
                  itemBuilder: (context, index) {
                    var lastMessage = result.data[index].lastMessage;
                    print(result.data[index].lastMessage);
                    return GestureDetector(

                      onTap: () {
                        var id=result.data[index].receiver ;
                        var photo=result.data[index].profilePhoto;
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) => TalkPage(
                                    currentUser: provider.users,
                                    talkUser: Users.idAndPhoto(
                                        UserId: id,
                                        profilPhoto:
                                            photo,
                                    userName:result.data[index].userName ))));
                      },
                      child: ListTile(
                        title: Text(result.data[index].userName),
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(result.data[index].profilePhoto),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(lastMessage.toString()),
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }

  Future<Null> freshPage() async {
    setState(() {});
    Future.delayed(Duration(seconds: 1));
    return null;
  }
}
