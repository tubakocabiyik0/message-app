import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_message/model/Talks.dart';
import 'package:flutter_message/viewmodel/auth_provider.dart';
import 'package:provider/provider.dart';

class TalksPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Recent Talks"),backgroundColor: Colors.purple.shade300,),
      body: FutureBuilder<List<Talks>>(future:provider.getAllTalks(provider.users.UserId) ,builder: (context,result){
        if(!result.hasData){
          return Center(child:CircularProgressIndicator());
        }else{
          print(result.data.length);

          return ListView.builder(

              itemCount: (result.data.length),

              itemBuilder: (context,index){
                var lastMessage= result.data[index].lastMessage;
                print(result.data[index].lastMessage);
             return ListTile(
               title:Text(result.data[index].receiver),
               subtitle: Text(lastMessage.toString()),

             );
          }) ;
        }

      },),

    );
  }

}