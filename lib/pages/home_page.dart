import 'dart:convert';
import 'dart:io';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:english_tutor/pages/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_tutor/model/manu_model.dart';
import '../model/question.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<MenuModel> menu = [
    MenuModel(title: "Grammar 80", imgPath: "assets/img/edu3.png", quizColor: Color(0xff9437FF)),
    MenuModel(title: "Vocabulary 80", imgPath: "assets/img/edu2.png", quizColor: Color(0xffFF40FF)),

    MenuModel(title: "Vocabulary 25", imgPath: "assets/img/edu1.png", quizColor: Color(0xff9437FF)),
    MenuModel(title: "Grammar 25", imgPath: "assets/img/edu5.png", quizColor: Color(0xff9437FF)),
    MenuModel(title: "Marathon", imgPath: "assets/img/edu4.png", quizColor: Color(0xff9437FF)),
  ];



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
              itemCount: menu.length,
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
                        var Page = QuizPage(quiz_1, Color(0xff9437FF));
                        if(index == 0){
                          Page = QuizPage(quiz_1, Color(0xffFF40FF));
                        }else if(index == 1){
                          Page = QuizPage(quiz_25, Color(0xff9437FF));
                        }else{
                          return Page;
                        }
                        return Page;
                      }),
                    );
                  },
                  child: Card(
                    child: Stack(children:[
                      Image(image: AssetImage(menu[index].imgPath!)),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(menu[index].title!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black, )),
                          )),


                    ], ),
                  ),
                );
            })
          ),
        ],
      ),
    );
  }
}
