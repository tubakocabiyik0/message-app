import 'package:flutter/material.dart';
import 'package:flutter_message/model/user.dart';
import 'package:flutter_message/screens/talkPage.dart';
import 'package:flutter_message/viewmodel/auth_provider.dart';
import 'package:provider/provider.dart';

class AllUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _provider=Provider.of<AuthProvider>(context);

    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.purple.shade300,
      title: Text("All Users"),
    ),
      body: FutureBuilder<List<Users>>(
        future:_provider.getAllUsers() ,
        builder:(context,sonuc) {
          if(sonuc.hasData){
            var users=sonuc.data;
            return listWidget(users,context,_provider);
          }else{
            return Center(child: CircularProgressIndicator());
          }
        }
      )
    );
  }

  Widget listWidget(List<Users> users, BuildContext context, AuthProvider provider) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context,index){
          if(users[index].UserId !=provider.users.UserId ){
            return ListTile(
              leading: Image.network(users[index].profilPhoto),
              title: Text(users[index].userName),
              subtitle: Text(users[index].email),
              onTap:(){
               Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(builder: (context)=>TalkPage(currentUser:provider.users,talkUser: users[index],)),


               );
              }
            );
          }else {
            return Container();
          }
    });

  }

}
