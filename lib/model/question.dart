import 'dart:convert';
import 'dart:io';
import 'package:english_tutor/model/translation.dart';
import 'answers.dart';

class Question {
  int? id;
  String? question;
  List<Answers>? answers;
  Translation? translation;
  String? explanation;

  Question(
      {this.id,
        this.question,
        this.answers,
        this.translation,
        this.explanation});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
    translation = json['translation'] != null
        ? new Translation.fromJson(json['translation'])
        : null;
    explanation = json['explanation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    if (this.translation != null) {
      data['translation'] = this.translation!.toJson();
    }
    data['explanation'] = this.explanation;
    return data;
  }
}



