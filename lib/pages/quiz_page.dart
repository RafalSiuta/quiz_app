import 'package:english_tutor/pages/question_view.dart';
import 'package:english_tutor/pages/summary_page.dart';
import 'package:flutter/material.dart';

import '../model/answers.dart';
import '../model/question.dart';
import 'home_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage(this.questionsList, this.quizColor, {super.key});

  final List<Question> questionsList;
  final Color? quizColor;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Question> wrongAnswers = [];

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

    void wrongAnswerList(Question question){
    setState(() {
      wrongAnswers.add(question);
    });
    }

    void setQuizColor(){
    setState(() {
      widget.questionsList.forEach((el){
        el.answers!.forEach((answer) {
          answer.choiceColor = widget.quizColor;
        });
      });
    });

    }

    void resetQuiz(){
      setState(() {
        correctAnswerCounter = 0;
        page_counter = 1;
        widget.questionsList.forEach((el){
          el.answers!.forEach((answer) {
            answer.choiceColor = Color(0xff9437FF);
          });
        });
      });
    }

    @override
    void initState() {
      _pageController = PageController(initialPage: 0);
      setQuizColor();
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Pyt ${page_counter}/${widget.questionsList
                        .length}"),
                    Row(
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                                radius: 12,
                                backgroundColor: Color(0xff8EFA00),
                                child: Text("${correctAnswerCounter}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),)),
                            Text("Dobre", style: TextStyle(fontSize: 10.0),)
                          ],
                        ),
                        SizedBox(width: 10,),
                        Column(
                          children: [
                            CircleAvatar(
                                radius: 12,
                                backgroundColor: Color(0xffFF5D57),
                                child: Text("${wrongAnswers.length}",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),)),
                            Text("Błędne", style: TextStyle(fontSize: 10.0),)
                          ],
                        )
                      ],
                    ),

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
                      return QuestionView(widget.questionsList[index],answerCounter, wrongAnswerList);
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
                  }, child: Text("< prev", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: widget.quizColor))),
                  TextButton(onPressed: () {
                    resetQuiz();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return HomePage();
                      }),
                    );
                  }, child: Text("esc", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: widget.quizColor))),
                  TextButton(onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,);
                    if(page_counter == widget.questionsList.length){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return SummaryPage(wrongAnswers,correctAnswerCounter, resetQuiz);
                        }),
                      );
                    }
                  }, child: Text("next >", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: widget.quizColor))),
                ],)
            ],
          ),
        ),
      );
    }
  }


