import 'package:flutter/material.dart';
import '../model/question.dart';
import 'package:flip_card/flip_card.dart';

class QuestionView extends StatefulWidget {
  const QuestionView( this.question, this.answerCounter, {super.key});
  final Question question;
  final Function answerCounter;

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  @override
  Widget build(BuildContext context) {

    var btn_width = MediaQuery.of(context).size.width - 70;
    return Column(
      children: [
        Expanded(
          child:
    FlipCard(
    fill: Fill.fillBack, // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.HORIZONTAL, // default
      side: CardSide.FRONT, // The side to initially display.
      front: Card(
        margin: EdgeInsets.all(15),
        child: SizedBox(
            width: btn_width,
            child: Center(child: Text(widget.question.question!),)),
      ),
      back: Card(
        margin: EdgeInsets.all(15),
        child: SizedBox(
            width: btn_width,
            child: Container(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(text: TextSpan(
                    text: "${widget.question.translation!.pl}\n",

                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,),

                    children:  <TextSpan>[
                      TextSpan(text: widget.question.translation!.en, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    ],
                  ),),
                  SizedBox(height: 10,),
                  Divider(color: Colors.grey,height: 0.5,),
                  SizedBox(height: 10,),
                  SingleChildScrollView(child: Text(widget.question.explanation!))
                ],
              ),
            ),)),
      ),
    )  ),

        Column(
          children: List.generate(widget.question.answers!.length, (index) =>
              ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    backgroundColor: widget.question.answers![index].choiceColor,
                    minimumSize: Size(btn_width, 40),
                    alignment: Alignment.centerLeft
                  ),
                  onPressed:(){
                    setState(() {
                      widget.question.answers![index].checkAnswer();
                      if(widget.question.answers![index].isCorrect!){
                        widget.answerCounter();
                      }
                    });
                  }, child: Text("${widget.question.answers![index].choice})  ${widget.question.answers![index].text!}",style: TextStyle(color: Colors.white),)),
          ),
        ),

      ],
    );
  }
}
