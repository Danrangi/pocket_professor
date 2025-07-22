import 'package:flutter/foundation.dart';

enum ErrorType {
  network,
  authentication,
  server,
  validation,
  unknown
}

class AppError {
  final ErrorType type;
  final String message;
  final String? technicalDetails;

  AppError({
    required this.type,
    required this.message,
    this.technicalDetails,
  });

  // Log error for developers but show friendly message to users
  void handle() {
    // Log detailed error for developers
    if (kDebugMode) {
      print('ERROR [${type.name}]: $message');
      if (technicalDetails != null) {
        print('Technical details: $technicalDetails');
      }
    }
    
    // In production, would send to error reporting service
    // errorReportingService.report(this);
  }

  // User-friendly error message
  String get userFriendlyMessage {
    switch (type) {
      case ErrorType.network:
        return 'Unable to connect. Please check your internet connection.';
      case ErrorType.server:
        return 'We\'re having trouble with our servers. Please try again later.';
      case ErrorType.authentication:
        return 'Please sign in again to continue.';
      case ErrorType.validation:
        return 'Please check your input and try again.';
      case ErrorType.unknown:
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
