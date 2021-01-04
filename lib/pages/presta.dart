import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:apilist/themes/color.dart';
import 'package:http/http.dart' as http;

class pprestashop extends StatefulWidget {
  @override
  _pprestashopState createState() => _pprestashopState();
}

class _pprestashopState extends State<pprestashop> {
  List users = [];
  bool isLoading = false;
  var data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
  }
  fetchUser() async {
    setState(() {
      isLoading = true;
    });

    String username = '395P9HBTUFYZZQSVCRJVBAU53CH4ZZAC';
    String password = ':';
    String auth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    print(auth);
    http.Response response = await http.get('https://tpowep.com/new/prestashop/api/categories/1?output_format=JSON',
        headers: <String, String>{'authorization': auth,});
    print(response.body);
    if(response.statusCode == 200){
      var items = json.decode(response.body);
      print(response.body);
      setState(() {
        users = items;
        isLoading = false;
      });
    }else{
      users = [];
      isLoading = false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Listing Users"),
      ),
      body: getBody(),
    );
  }
  Widget getBody(){
    if(users.contains(null) || users.length < 0 || isLoading){
      return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(primary),));
    }
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context,index){
          return getCard(users[index]);
        });
  }
  Widget getCard(item){

    var name = item['name'];

    var email = item['date_add'];
    var pass = item['pass'];

    return Card(
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Row(
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(60/2),

                ),
              ),
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      width: MediaQuery.of(context).size.width-140,
                      child: Text(email,style: TextStyle(fontSize: 17),)),
                  SizedBox(height: 10,),
                  Text(email,style: TextStyle(color: Colors.grey),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
