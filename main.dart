import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



void main() {
  runApp(new MaterialApp(
    home: new homepage(),
    debugShowCheckedModeBanner: false,
  ));
}






class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {


  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  var data;
  Future fu;
  List<MYCLASS> mylist = [];
  Future<List<MYCLASS>> myapi() async{
    var url = await http.get(" YOUR API URL ",headers: requestHeaders);
    data = json.decode(url.body);
    print(data);

    for(var i in data){
      MYCLASS mydata = MYCLASS(i["Id"],i["name"],i["email"],i["group"]);
      mylist.add(mydata);
    }
    print(mylist[0].Id);
    print(mylist[0].name);
    print(mylist[0].email);
    print(mylist[0].group);

    return mylist;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fu = myapi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: FutureBuilder(
            future: fu,
            builder: (_,snap){
              if(!snap.hasData){
                return Center(child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Not Hasdata")
                  ],
                ),);
              }else if(snap.hasError){
                return Center(child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Error")
                  ],
                ),);
              }else if(snap.hasData){
                return ListView.builder(
                    itemCount: mylist.length,
                    itemBuilder: (_,i){
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              Text("${mylist[i].Id}"),
                              Text("${mylist[i].name}"),
                              Text("${mylist[i].email}"),
                              Text("${mylist[i].group}"),
                            ],
                          ),
                        ),
                      );
                    });
                //return page2(mylist[0]);
              }
            }),
      ),
    );
  }
}





class page2 extends StatefulWidget {
  var dt;
  page2(this.dt);
  @override
  _page2State createState() => _page2State(dt);
}

class _page2State extends State<page2> {
  var dt;
  _page2State(this.dt);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Center(
        child: Column(
          children: <Widget>[
            Text("${dt.Id}"),
            Text("${dt.name}"),
            Text("${dt.email}"),
            Text("${dt.group}"),
          ],
        ),
      ),
    );
  }
}







class MYCLASS{
final int Id;
final String name;
final String email;
final String group;
MYCLASS(this.Id,this.name,this.email,this.group);
}














