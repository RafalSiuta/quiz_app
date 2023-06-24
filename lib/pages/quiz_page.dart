import 'package:english_tutor/pages/question_view.dart';
import 'package:flutter/material.dart';

import '../model/question.dart';

class QuizPage extends StatefulWidget {
  const QuizPage(this.questionsList,{super.key});

  final List<Question> questionsList;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late final PageController _pageController;


  var page_counter = 1;
  var correctAnswerCounter = 0;

  _onPageViewChange(int page) {
    setState(() {
      //print("Current Page: " + page.toString());
      int previousPage = page;
      if (page != 0)
        previousPage--;
      else
        previousPage = 2;
      // print("Previous page: $previousPage");
      page_counter = page + 1;
    });
  }

    void answerCounter(){
    setState(() {
      correctAnswerCounter++;
    });
    }

    void resetQuiz(){
      setState(() {
        correctAnswerCounter = 0;
        page_counter = 1;
        widget.questionsList.forEach((el){
          el.answers!.forEach((answer) {
            answer.choiceColor = Colors.blue;
          });
        });
      });
    }

    @override
    void initState() {
      _pageController = PageController(initialPage: 0);
      super.initState();
    }

    @override
    void dispose() {
      _pageController.dispose();
      super.dispose();
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15, vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Question ${page_counter}/${widget.questionsList
                        .length}"),
                    Text("Correct: ${correctAnswerCounter}")
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.questionsList.length,
                    onPageChanged: _onPageViewChange,
                    itemBuilder: (ctx, index) {
                      return QuestionView(widget.questionsList[index],answerCounter);
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {
                    if (_pageController.hasClients) {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,);
                    }
                  }, child: Text("< prev")),
                  TextButton(onPressed: () {
                    resetQuiz();
                    Navigator.pop(context);
                  }, child: Text("esc")),
                  TextButton(onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,);
                  }, child: Text("next >")),
                ],)
            ],
          ),
        ),
      );
    }
  }


