import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_message/model/user.dart';
import 'package:flutter_message/screens/talkPage.dart';
import 'package:flutter_message/viewmodel/allUsers_provider.dart';
import 'package:flutter_message/viewmodel/auth_provider.dart';
import 'package:provider/provider.dart';

class AllUsers extends StatefulWidget {
  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  bool _isLoading = false;
  bool _hasMore = true;
  int _userCount = 10;
  Users _lastUser;
  final _scrollController = ScrollController();
  var _provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async{
      if (_hasMore) {
        getAllUser();
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    final _usersProvider=Provider.of<AllUsersProvider>(context);
    // getAllUser();
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.purple.shade300,
      title: Text("All Users"),
         actions: [FlatButton(onPressed: () {
            getAllUser();
          }, child: Text("More user"))
          ],
    ),
      body: Consumer<AllUsersProvider>(builder: (context,model,child){
        if(model.state==AllUsersViewState.Busy){
           return Center(child: CircularProgressIndicator(),);

        }
        else if(model.state==AllUsersViewState.Loaded){
          return Container();
        }else{
          return ListView.builder (
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              controller: _scrollController,
              itemCount: model.userList.length+1,
              itemBuilder: (context, index) {
                print("lenght"+model.userList.length.toString());
                if(index==model.userList.length) {
                  return  newUsersAdding();
                }
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ListTile(
                    onTap: (){
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (context) => TalkPage(
                                  currentUser:_provider.users,
                                  talkUser: model.userList[index])));
                    },
                    title: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Text(
                        model.userList[index].userName, style: TextStyle(fontSize: 20),),
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(model.userList[index].profilPhoto),),
                    ),
                  ),
                );
              });
        }
      },)

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

  getAllUser() async {
    final _provider = Provider.of<AuthProvider>(context,listen: false);
    final _providerUser = Provider.of<AllUsersProvider>(context,listen: false);
    await _provider.getAllUsers();
    await _providerUser.getNewUsers();


    /*setState(() {
      _isLoading = true;
    });
    List<Users> usersList = await _provider.getAllUsersWithPagination(_lastUser,_userCount);
    if(_allUsers==null){
      _allUsers=[];
      _allUsers.addAll(usersList);
    }else{
      _allUsers.addAll(usersList);
    }

    if (usersList.length < _userCount) {
      _hasMore = false;
    }
    _lastUser = usersList.last;
    //  await Future.delayed(Duration(seconds: 2));
    if (this.mounted) { // check whether the state object is in tree
      setState(() {
        _isLoading = false;
      });
    }
    return usersList;*/
  }
  _usersList() {
    final _provider = Provider.of<AuthProvider>(context,listen: false);
 /*   return ListView.builder (
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        itemCount: _allUsers.length+1,
        itemBuilder: (context, index) {
          print("lenght"+_allUsers.length.toString());
          if(index==_allUsers.length) {
            return  newUsersAdding();
          }
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ListTile(
              onTap: (){
                Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                        builder: (context) => TalkPage(
                            currentUser:_provider.users,
                            talkUser: _allUsers[index])));
              },
              title: Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  _allUsers[index].userName, style: TextStyle(fontSize: 20),),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_allUsers[index].profilPhoto),),
              ),
            ),
          );
        });*/
  }


  newUsersAdding()  {

    return Padding(padding: EdgeInsets.all(8),child: Center(child: Opacity(opacity: _isLoading ? 1 : 0 , child:  _isLoading ?  CircularProgressIndicator() : Container(),),),);
  }


}
