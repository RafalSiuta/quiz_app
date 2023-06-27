import 'package:flutter/material.dart';
import '../model/question.dart';
import 'package:flip_card/flip_card.dart';

class QuestionView extends StatefulWidget {
  const QuestionView( this.question, this.answerCounter,this.appendWrongAnswer, {super.key});
  final Question question;
  final Function answerCounter;
  final Function appendWrongAnswer;

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {


  bool isChecked = false;

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
            child: Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("""${widget.question.question!}""", ),
            ),)),
      ),
      back: Card(
        margin: EdgeInsets.all(15),
        child: SizedBox(
            width: btn_width,
            child: Container(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(text: TextSpan(
                    text: "${widget.question.translation!.en}\n\n", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff9437FF), height: 1.5),
                    children:  <TextSpan>[
                      TextSpan(text: "${widget.question.translation!.pl}",
                     style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black, height: 1.5)),
                    ],
                  ),),
                  SizedBox(height: 10,),
                  Divider(color: Colors.grey,height: 0.5,),
                  SizedBox(height: 10,),
                  Expanded(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text("""${widget.question.explanation!}""", style: TextStyle(fontSize: 12.0, height: 1.5),)),
                  )
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
                  onPressed: isChecked ? (){} : (){
                    setState(() {
                      isChecked = true;
                      widget.question.answers![index].checkAnswer();
                      if(widget.question.answers![index].isCorrect!){
                        widget.answerCounter();
                      }else{
                        widget.appendWrongAnswer(widget.question);
                      }
                    });
                  }, child: Text("${widget.question.answers![index].choice})  ${widget.question.answers![index].text!}",style: TextStyle(color: Colors.white),)),
          ),
        ),

      ],
    );
  }
}
