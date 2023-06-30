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

    MenuModel(title: "Vocabulary 45", imgPath: "assets/img/edu1.png", quizColor: Color(0xff9437FF)),
    MenuModel(title: "Grammar 65", imgPath: "assets/img/edu5.png", quizColor: Color(0xff9437FF)),
    MenuModel(title: "Marathon", imgPath: "assets/img/edu4.png", quizColor: Color(0xff9437FF)),
  ];



  final List<Question> grammar_80 = [];
  final List<Question> grammar_65 = [];
  final List<Question> vocabulary_80 = [];
  final List<Question> vocabulary_45 = [];
  final List<Question> marathon = [];

  List<String> pathList = [
    "assets/grammar_80.json",
    "assets/grammar_65.json",
    "assets/vocabulary_80.json",
    "assets/vocabulary_45.json"
  ];

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

  void marathonQuiz(List asset_path_list, List<Question> list) async{

    asset_path_list.forEach((path) async {
      var input = await rootBundle.loadString(path);//File("assets/grammar_80.json").readAsStringSync();
      var jsonData = jsonDecode(input);
      final map = jsonData['questions'];
      map.forEach((el){
        final question = Question.fromJson(el);
        list.add(question);
      });
      setState(() {
        list.shuffle();
      });
    });

  }

 @override
  void initState() {
    res("assets/grammar_80.json", grammar_80);
    res("assets/grammar_65.json", grammar_65);
    res("assets/vocabulary_80.json", vocabulary_80);
    res("assets/vocabulary_45.json", vocabulary_45);
    marathonQuiz(pathList, marathon);

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
                        var page = QuizPage(grammar_80, Color(0xff9437FF));
                        if(index == 0){
                          page = QuizPage(grammar_80,Color(0xff9437FF));
                        }else if(index == 1){
                          page = QuizPage(vocabulary_80,Color(0xffFF40FF));
                        }else if(index == 2){
                          page = QuizPage(vocabulary_45,Color(0xffFF40FF));
                        }else if(index == 3){
                          page = QuizPage(grammar_65,Color(0xff9437FF));
                        }else if(index == 4){
                          page = QuizPage(marathon,Color(0xff9437FF));
                        }
                        return page;
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
