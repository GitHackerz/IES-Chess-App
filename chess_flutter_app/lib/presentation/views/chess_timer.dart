import 'dart:async';

import 'package:flutter/material.dart';

class ChessTimerScreen extends StatefulWidget {
  @override
  _ChessTimerScreenState createState() => _ChessTimerScreenState();
}

class _ChessTimerScreenState extends State<ChessTimerScreen> {
  int player1Time = 300; // 5 minutes (in seconds)
  int player2Time = 300; // 5 minutes (in seconds)
  bool isPlayer1Turn = true;
  Timer? _player1Timer; // Make these nullable
  Timer? _player2Timer;

  @override
  void initState() {
    super.initState();
  }

  // Start the timer for Player 1
  void startPlayer1Timer() {
    _player1Timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (player1Time > 0) {
          player1Time--;
        } else {
          _player1Timer?.cancel(); // Safe null check before canceling
        }
      });
    });
  }

  // Start the timer for Player 2
  void startPlayer2Timer() {
    _player2Timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (player2Time > 0) {
          player2Time--;
        } else {
          _player2Timer?.cancel(); // Safe null check before canceling
        }
      });
    });
  }

  // Switch to Player 1 and start their timer
  void switchToPlayer1() {
    if (_player2Timer?.isActive ?? false) {
      _player2Timer?.cancel(); // Safe null check before canceling
    }
    startPlayer1Timer();
    setState(() {
      isPlayer1Turn = true;
    });
  }

  // Switch to Player 2 and start their timer
  void switchToPlayer2() {
    if (_player1Timer?.isActive ?? false) {
      _player1Timer?.cancel(); // Safe null check before canceling
    }
    startPlayer2Timer();
    setState(() {
      isPlayer1Turn = false;
    });
  }

  @override
  void dispose() {
    // Cancel the timers when the widget is disposed
    _player1Timer?.cancel(); // Safe null check
    _player2Timer?.cancel(); // Safe null check
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chess Matches',
            style: TextStyle(
                color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.only(bottom: 50),
                child: Text(
                  isPlayer1Turn ? 'Player 1 Turn' : 'Player 2 Turn',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: isPlayer1Turn ? null : switchToPlayer1,
                  child: const Text('Player 1 Timer'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: !isPlayer1Turn ? null : switchToPlayer2,
                  child: const Text('Player 2 Timer'),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Text(
              'Player 1 Time: ${formatTime(player1Time)}',
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            Text(
              'Player 2 Time: ${formatTime(player2Time)}',
              style: const TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }

  // Format time as minutes:seconds
  String formatTime(int time) {
    int minutes = time ~/ 60;
    int seconds = time % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
