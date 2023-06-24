import 'dart:convert';
import 'dart:io';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:english_tutor/pages/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/question.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Question> quiz_1 = [];
  final List<Question> quiz_25 = [];

  void res(String asset_path, List<Question> list) async{
    var input = await rootBundle.loadString(asset_path);//File("assets/grammar_80.json").readAsStringSync();
    var jsonData = jsonDecode(input);
    final map = jsonData['questions'];

    map.forEach((el){
      final question = Question.fromJson(el);
      list.add(question);
      // print("_________________________________________");
      // print(question.id);
      // print(question.question);
      // question.answers!.forEach((element) {
      //   print(element.text);
      // });
      // print(question.answers);
      // print(question.translation);
      //
      // print("_________________________________________\n");
    });
  }

 @override
  void initState() {
    res("assets/grammar_80.json", quiz_1);
    res("assets/grammar_25.json", quiz_25);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Text("Choose Your Destiny ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: 5,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.0,
            ), itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        var Page = QuizPage(quiz_1);
                        if(index == 0){
                          Page = QuizPage(quiz_1);
                        }else if(index == 1){
                          Page = QuizPage(quiz_25);
                        }else{
                          return Page;
                        }
                        return Page;
                      }),
                    );
                  },
                  child: Card(
                    child: Center(child: Text("Text ${index}")),
                  ),
                );
            })
          ),
        ],
      ),
    );
  }
}
