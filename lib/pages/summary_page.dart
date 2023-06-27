import 'package:english_tutor/pages/home_page.dart';
import 'package:english_tutor/pages/quiz_page.dart';
import 'package:flutter/material.dart';

import '../model/question.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage(this.wrongAnswers, this.goodAnswers, this.reset, {super.key});

  final List<Question> wrongAnswers;
  final int goodAnswers;
  final Function reset;

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {

  var degree = "%";

  var summaryDescription = "Zaliczone!!! Tym rqazem się udało, jest całkiem spoko ale nie idealnie, musisz jeszcze trochę popracować ;) ";

  void summaryPoints(){
    setState(() {
      var percentage = 100 * widget.goodAnswers / (widget.goodAnswers + widget.wrongAnswers.length);
      if(percentage <= 50){
        degree = "${percentage.toStringAsFixed(2)}% - ocena NIEDOSTATECZNA";
        summaryDescription = "Słabiutko, wygląda na to, że musisz jeszcze trochę się pouczyć. Głowa do góry, przejdziesz test parę razy i bedzie dobrze - POWODZENIA :) ";
      }else if(percentage >= 51 && percentage <= 60){
        degree = "${percentage.toStringAsFixed(2)}% - ocena DOSTATECZNA";
        summaryDescription = "Zaliczenie jest ale czy to cię zadawala? Może warto jeszcze trochę sie pouczyć i sprawdzić ile tak naprawdę potrafisz - TRZYMAM KCIUKI ZA TWÓJ SUKCES ! ";
      }else if(percentage >= 61 && percentage <= 70){
        degree = "${percentage.toStringAsFixed(2)}% - ocena DOSTATECZNA PLUS";
        summaryDescription = "Nienajgorzej, niewiele brakuje na ocenę DOBRĄ? Może warto jeszcze trochę sie pouczyć i sprawdzić ile tak naprawdę potrafisz - TRZYMAM KCIUKI ZA TWÓJ SUKCES ! ";
      }else if(percentage >= 71 && percentage <= 80){
        degree = "${percentage.toStringAsFixed(2)}% - ocena DOBRA";
        summaryDescription = "Super! całkiem dobrze Ci poszło - gratuluję :) Jeszcze parę razy przerobisz test i będzie PIĄTUŃKA - DASZ RADĘ TRZYMAM KCIUKI :) ";
      }else if(percentage >= 81 && percentage <= 90){
        degree = "${percentage.toStringAsFixed(2)}% - ocena DOBRA PLUS";
        summaryDescription = "Super! GRATULUJĘ SUKCESU :)- zbliżasz się do topki najlepszych - nie poddawaj się dasz radę :) ";
      }else if(percentage >= 91 && percentage <= 100){
        degree = "${percentage.toStringAsFixed(2)}% - ocena BARDZO DOBRA";
        summaryDescription = "MEGA SZACUN :) Jesteś wśród najlepszych - taki wynik to nielada wyczyn - wygląda na to, że kolokwium nie jest Ci straszne - DASZ RADĘ :) ";
      }
    });
  }

  @override
  void initState() {
    summaryPoints();
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var btn_width = MediaQuery.of(context).size.width - 70;
    var smallSpacing = 20.0;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: btn_width - 50,
              child: Image(image: AssetImage('assets/img/summary.png')),
            ),
            SizedBox(height: smallSpacing,),
            Text("Dobre odpowiedzi: ${widget.goodAnswers}", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff9437FF))),
            SizedBox(height: 10.0,),
            Text("Błędne odpowiedzi: ${widget.wrongAnswers.length}", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffFF5D57))),
            SizedBox(height: smallSpacing,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Text("""${degree} \n""", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff9437FF), height: 1.5)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Text("""${summaryDescription}""", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff9437FF), height: 1.5)),
            ),
            SizedBox(height: smallSpacing,),
            Visibility(
              visible: widget.wrongAnswers.length == 0 ? false : true,
              child: ElevatedButton(
                  style:ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff9437FF),
                      minimumSize: Size(btn_width, 40),
                      alignment: Alignment.centerLeft
                  ),
                  onPressed: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return QuizPage(widget.wrongAnswers, Color(0xff9437FF));
                      }),
                    );
                  }, child: Text("Popraw błędne")),
            ),
            SizedBox(height: smallSpacing,),
            ElevatedButton(
                style:ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff9437FF),
                    minimumSize: Size(btn_width, 40),
                    alignment: Alignment.centerLeft
                ),
                onPressed: (){
                  widget.reset();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return HomePage();
                    }),
                  );
            }, child: Text("Strona Startowa"))
          ],
        ),
      ),
    );
  }
}
