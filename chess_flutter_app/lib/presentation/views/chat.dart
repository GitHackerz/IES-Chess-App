import 'package:chess_game_ies/core/routes.dart';
import 'package:flutter/material.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chess AI Chatbot',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown, // Changed to brown
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
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: const [
                ChatMessage(
                  message:
                      "Hello! I'm your chess AI. How can I assist you today?",
                  isBot: true,
                ),
                ChatMessage(
                  message: "Can you help me with the rules of chess?",
                  isBot: false,
                ),
                ChatMessage(
                  message:
                      "Sure! In chess, two players take turns to move pieces across an 8x8 board. The objective is to checkmate the opponent's king.",
                  isBot: true,
                ),
                ChatMessage(
                  message: "What is checkmate?",
                  isBot: false,
                ),
                ChatMessage(
                  message:
                      "Checkmate occurs when the opponent's king is under attack and there is no way to move the king to a safe position.",
                  isBot: true,
                ),
                ChatMessage(
                  message: "What are the different chess pieces?",
                  isBot: false,
                ),
                ChatMessage(
                  message:
                      "The main pieces are the King, Queen, Rook, Bishop, Knight, and Pawn. Each has its own unique movement rules.",
                  isBot: true,
                ),
                // Add more static messages as needed
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                    ),
                    onSubmitted: (message) {
                      // Handle sending message (currently just clears input)
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // Handle send button press
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isBot;

  const ChatMessage({
    Key? key,
    required this.message,
    required this.isBot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isBot ? Colors.brown[100] : Colors.brown, // Changed to brown
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isBot ? Colors.black : Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
