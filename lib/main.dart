import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo de Adivinhação'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen(level: 1)),
                );
              },
              child: Text('Nível 1'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen(level: 2)),
                );
              },
              child: Text('Nível 2'),
            ),
          ],
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  final int level;

  GameScreen({required this.level});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _randomNumber = Random().nextInt(100) + 1;
  int _attempts = 0;
  int _maxAttempts = 0;
  TextEditingController _controller = TextEditingController(); // Adicionando um controlador

  @override
  void initState() {
    super.initState();
    _maxAttempts = widget.level == 1 ? 10 : 5;
  }

  void _checkNumber() {
    setState(() {
      _attempts++;
      int number = int.tryParse(_controller.text) ?? 0; // Obtendo o número digitado pelo jogador

      if (number == _randomNumber) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WinScreen(attempts: _attempts)),
        );
      } else if (_attempts >= _maxAttempts) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoseScreen(randomNumber: _randomNumber)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nível ${widget.level}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Tente adivinhar o número entre 1 e 100.'),
            Text('Tentativas restantes: ${_maxAttempts - _attempts}'),
            SizedBox(height: 20),
            TextField( // Adicionando um campo de entrada de texto
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Seu Palpite',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _checkNumber, // Agora não passamos mais um valor fixo
              child: Text('Verificar'),
            ),
          ],
        ),
      ),
    );
  }
}

class WinScreen extends StatelessWidget {
  final int attempts;

  WinScreen({required this.attempts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Você Ganhou!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Parabéns! Você adivinhou o número em $attempts tentativas.'),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Jogar Novamente'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoseScreen extends StatelessWidget {
  final int randomNumber;

  LoseScreen({required this.randomNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Você Perdeu!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Que pena! O número correto era $randomNumber.'),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Jogar Novamente'),
            ),
          ],
        ),
      ),
    );
  }
}
