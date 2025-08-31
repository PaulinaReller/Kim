import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// IMPORTANT: Do NOT hardcode the API Key 
const String _apiKey = String.fromEnvironment('API_KEY');

void main() {
  runApp(const GeminiApp());
}

class GeminiApp extends StatelessWidget { // Stateless Widget does not change internal state
  const GeminiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Main Container for the whole App 
      title: 'Flutter + Gemini',
      theme: ThemeData( // Theme set-up 
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const ChatScreen(), // Home-Screen of the APP 
    );
  }
}

class ChatScreen extends StatefulWidget { // Not Stateless, because it needs to change 
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> { // Variables to manage screen state 
  late final GenerativeModel _model;
  final TextEditingController _textController = TextEditingController();
  String? _response;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-1.5-flash', 
      apiKey: _apiKey,
    );
  }

  // Gemini Chatbot logic 

  Future<void> _generateContent() async {
    if (_textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a question.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _response = null;
    });

    try {
      final content = [Content.text(_textController.text)];
      final response = await _model.generateContent(content);
      setState(() {
        _response = response.text;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _response = 'Error: ${e.toString()}';
        _isLoading = false;
      });
    } finally {
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with KIM'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter your question...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (_) => _generateContent(),
            ),
            const SizedBox(height: 16),
            // Button to send the prompt
            ElevatedButton(
              onPressed: _isLoading ? null : _generateContent,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Generate'),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Text(
                          _response ?? 'Response will appear here...',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}