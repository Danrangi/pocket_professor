import 'dart:math';
import '../core/interfaces/ai_service_interface.dart';

class MockAIService implements AIServiceInterface {
  final _random = Random();
  
  // List of sample responses for demonstration
  final _responses = [
    'That\'s an interesting question. Let me explain...',
    'Great question! The answer involves several concepts...',
    'I understand what you\'re asking. Here\'s what you need to know...',
    'Let me break this down step by step...',
    'This is a complex topic. Let\'s start with the basics...',
  ];
  
  @override
  Future<String> generateResponse(String prompt) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1 + _random.nextInt(2)));
    
    // Simulate occasional errors for testing
    if (_random.nextDouble() < 0.05) {
      throw Exception('Service temporarily unavailable');
    }
    
    // Return a random response
    return _responses[_random.nextInt(_responses.length)];
  }
}
