import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../../core/interfaces/ai_service_interface.dart';
import '../../core/security/input_validator.dart';
import '../../core/error/error_handler.dart';

class ChatRepository {
  final AIServiceInterface _aiService;
  
  ChatRepository(this._aiService);
  
  Future<types.TextMessage> getUserMessage(String text, types.User user) async {
    try {
      // Validate and sanitize input
      if (!InputValidator.isValidInput(text)) {
        throw AppError(
          type: ErrorType.validation,
          message: 'Invalid input',
        );
      }
      
      final sanitizedText = InputValidator.sanitize(text);
      
      return types.TextMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: sanitizedText,
      );
    } catch (e) {
      final error = e is AppError ? e : AppError(
        type: ErrorType.unknown,
        message: e.toString(),
      );
      error.handle();
      rethrow;
    }
  }
  
  Future<types.TextMessage> getAIResponse(String prompt, types.User aiUser) async {
    try {
      final response = await _aiService.generateResponse(prompt);
      
      return types.TextMessage(
        author: aiUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: response,
      );
    } catch (e) {
      final error = e is AppError ? e : AppError(
        type: ErrorType.server,
        message: 'Failed to get AI response',
        technicalDetails: e.toString(),
      );
      error.handle();
      
      // Return a fallback message
      return types.TextMessage(
        author: aiUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: 'I\'m having trouble processing that right now. Could you try again?',
      );
    }
  }
}
