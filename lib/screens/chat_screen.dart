import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:shimmer/shimmer.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../core/error/error_handler.dart';
import '../data/repositories/chat_repository.dart';
import '../services/mock_ai_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: 'user');
  final _professor = const types.User(id: 'professor', firstName: 'Professor');
  bool _isTyping = false;
  late ChatRepository _chatRepository;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initRepository();
    _addWelcomeMessage();
  }

  void _initRepository() {
    // Initialize with our mock service (will replace with real service later)
    final aiService = MockAIService();
    _chatRepository = ChatRepository(aiService);
  }

  void _addWelcomeMessage() {
    final message = types.TextMessage(
      author: _professor,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: 'welcome',
      text: 'Hello! I\'m your Pocket Professor. How can I help you today?',
    );

    setState(() {
      _messages.insert(0, message);
    });
  }

  Future<void> _handleSendPressed(types.PartialText message) async {
    setState(() {
      _errorMessage = null;
    });
    
    try {
      // Get validated user message
      final userMessage = await _chatRepository.getUserMessage(message.text, _user);
      
      setState(() {
        _messages.insert(0, userMessage);
        _isTyping = true;
      });
      
      // Get AI response
      final aiResponse = await _chatRepository.getAIResponse(message.text, _professor);
      
      setState(() {
        _messages.insert(0, aiResponse);
        _isTyping = false;
      });
    } catch (e) {
      final error = e is AppError ? e : AppError(
        type: ErrorType.unknown,
        message: e.toString(),
      );
      
      setState(() {
        _isTyping = false;
        _errorMessage = error.userFriendlyMessage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pocket Professor'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          if (_errorMessage != null)
            Container(
              color: Colors.red.shade900,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          Expanded(
            child: Chat(
              messages: _messages,
              onSendPressed: _handleSendPressed,
              user: _user,
            ),
          ),
          if (_isTyping)
            GlassmorphicContainer(
              width: double.infinity,
              height: 50,
              borderRadius: 0,
              blur: 20,
              alignment: Alignment.center,
              border: 0,
              linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.purple.withOpacity(0.1),
                  Colors.blue.withOpacity(0.1),
                ],
              ),
              borderGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                ],
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.purple[300]!,
                highlightColor: Colors.blue[300]!,
                child: const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Professor is thinking...',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
