import 'package:flutter/material.dart';

import '../../core/routes.dart';

class ChessMatchListScreen extends StatelessWidget {
  const ChessMatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chess Matches',
            style: TextStyle(
                color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.brown,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.brown,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // List of menu items
            ListTile(
              title: const Text('Home'),
              onTap: () {
                // Navigate to home screen
              },
            ),
            ListTile(
              title: const Text('Game Timer'),
              onTap: () {
                Navigator.pushNamed(context, Routes.chessTimer);
              },
            ),
            ListTile(
              title: const Text('Matches'),
              onTap: () {
                Navigator.pushNamed(context, Routes.matches);
              },
            ),
            ListTile(
              title: const Text('AI Chatbot'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ChessMatchTile(
            playerName: "Player 1",
            aiName: "AI Robot",
            score: "1 - 0",
            matchDate: "2024-11-20",
            matchTime: "12:00 PM",
          ),
          ChessMatchTile(
            playerName: "Player 2",
            aiName: "AI Robot",
            score: "0 - 1",
            matchDate: "2024-11-19",
            matchTime: "3:00 PM",
          ),
          ChessMatchTile(
            playerName: "Player 3",
            aiName: "AI Robot",
            score: "1 - 0",
            matchDate: "2024-11-18",
            matchTime: "10:00 AM",
          ),
          // Add more matches as needed
        ],
      ),
    );
  }
}

class ChessMatchTile extends StatelessWidget {
  final String playerName;
  final String aiName;
  final String score;
  final String matchDate;
  final String matchTime;

  const ChessMatchTile({
    Key? key,
    required this.playerName,
    required this.aiName,
    required this.score,
    required this.matchDate,
    required this.matchTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.games, size: 40, color: Color(0xFF2A4ECA)),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$playerName vs $aiName',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    'Score: $score',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF61677D),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    'Date: $matchDate',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF61677D),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    'Time: $matchTime',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF61677D),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                // Navigate to match details screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
