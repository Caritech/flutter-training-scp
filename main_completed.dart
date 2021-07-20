import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var enemyInput = '剪刀';
  var myInput = '';
  var winner = '';

  var myHp = 100;
  var enemyHp = 100;

  Function selectInput(input) {
    setState(() => myInput = input);
    checkWinner();
  }

  Function checkWinner() {
    /*
      石头
      剪刀
      布
    */
    winner = ''; //重置

    if (myInput == '石头' && enemyInput == '剪刀') {
      winner = '胜';
    }
    if (myInput == '石头' && enemyInput == '布') {
      winner = '败';
    }

    if (myInput == '剪刀' && enemyInput == '布') {
      winner = '胜';
    }
    if (myInput == '剪刀' && enemyInput == '石头') {
      winner = '败';
    }

    if (myInput == '布' && enemyInput == '石头') {
      winner = '胜';
    }
    if (myInput == '布' && enemyInput == '剪刀') {
      winner = '败';
    }

    if (myInput == enemyInput) {
      winner = '平';
    }

    if (winner == '胜') {
      enemyHp = enemyHp - 10;
    }
    if (winner == '败') {
      myHp = myHp - 10;
    }

    setState(() {});
  }

  Function restartGame() {
    myHp = 100;
    enemyHp = 100;
    nextGame();
  }

  Function nextGame() {
    myInput = '';
    winner = '';

    List gameInputs = [
      '剪刀',
      '石头',
      '布'
    ];

    enemyInput = (gameInputs..shuffle()).first;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('剪刀石头布')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50, width: double.infinity),
          Text('对方 HP: $enemyHp'),
          SizedBox(height: 10),
          BigText('$enemyInput'),
          SizedBox(height: 50),
          BigText('$winner'),
          SizedBox(height: 50),
          Text('我方 HP: $myHp'),
          BigText('$myInput'),
          myInput == ''
              ? ControlButton(selectInput)
              : RaisedButton(
                  child: Text('下一场'),
                  onPressed: () {
                    nextGame();
                  },
                ),
          SizedBox(height: 50),
          RaisedButton(
            child: Text('重来'),
            onPressed: () {
              restartGame();
            },
          ),
        ],
      ),
    );
  }
}

class ControlButton extends StatelessWidget {
  final Function selectInput;
  ControlButton(this.selectInput);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        RaisedButton(
            onPressed: () {
              selectInput('剪刀');
            },
            child: Text('剪刀')),
        RaisedButton(
            onPressed: () {
              selectInput('石头');
            },
            child: Text('石头')),
        RaisedButton(
            onPressed: () {
              selectInput('布');
            },
            child: Text('布')),
      ]),
    );
  }
}

class BigText extends StatelessWidget {
  var text;
  BigText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 50));
  }
}
