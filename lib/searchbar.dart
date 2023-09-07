import 'dart:async';
import 'package:scholarship/config.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scholarship/filterlib.dart';
import 'package:scholarship/searchresult.dart';

List? alltext = [];
late Map searchRes;
List? listdata;

class SearchBar extends StatefulWidget {
  final token;
  const SearchBar({@required this.token ,super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  
  Future gettextSearch() async{
  const path = baseUrl + "textsearch";
  final resp = await http.get(Uri.parse(path));
  if(alltext!.length == 0){
    if(resp.statusCode == 200){
      setState(() {
        searchRes = json.decode(resp.body);
        alltext = searchRes['sname'];
        print(searchRes);
      });
    }
  }else{
    print('Text ready to use');
  }
}


  @override
  void initState(){
    gettextSearch();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
            color: Color.fromARGB(255, 95, 111, 255),
            iconSize: 35,
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: dataSearch(ourname: alltext, token: widget.token)
                );
            },
            );
  }
}


class dataSearch extends SearchDelegate<String> {
  final token;
  final ourname;
  dataSearch({@required this.token, this.ourname});
  String name = "Scholarship";
  

  @override
  List<Widget> buildActions(BuildContext context){
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
      IconButton(
        onPressed: (){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => SearchResult(token: token, query: query)), (Route<dynamic> route) => false);
        },
        icon: Icon(Icons.search))
    ];
  }

  @override 
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: Icon(Icons.arrow_back),
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for(var s in ourname) {
      if (s.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(s);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          leading: Icon(Icons.search_outlined),
          title: Text(result),
          onTap: () {
          },
        );
      },
      );
  }


  @override
  Widget buildSuggestions(BuildContext context){
    List<String> matchQuery = [];
    for(var s in ourname){
      if (s.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(s);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return Container(
          child: ListTile(
            leading: Icon(Icons.search),
            onTap: () {
              print(result);
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => SearchResult(token: token, query: result)), (Route<dynamic> route) => false);
            },
            title: Text(result),
            trailing: Text(name,
            style: TextStyle(fontSize: 12),
            ),
          ),
        );
      },
      );
  }
}