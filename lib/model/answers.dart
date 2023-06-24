import 'package:flutter/material.dart';

class Answers {
  String? choice;
  String? text;
  bool? isCorrect;
  Color? choiceColor = Colors.blue;


  Answers({this.choice, this.text, this.isCorrect, this.choiceColor});

  Answers.fromJson(Map<String, dynamic> json) {
    choice = json['choice'];
    text = json['text'];
    isCorrect = json['is_correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['choice'] = this.choice;
    data['text'] = this.text;
    data['is_correct'] = this.isCorrect;
    return data;
  }

  void checkAnswer(){
    if(isCorrect!){
      choiceColor = Colors.green;
    }else{
      choiceColor = Colors.red;
    }
  }
}