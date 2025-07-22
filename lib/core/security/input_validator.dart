class InputValidator {
  static String sanitize(String input) {
    // Remove potentially dangerous HTML/script tags
    final sanitized = input.replaceAll(RegExp(r'<[^>]*>'), '');
    return sanitized;
  }

  static bool isValidInput(String input) {
    // Check for empty or just whitespace
    if (input.trim().isEmpty) {
      return false;
    }
    
    // Check for maximum length (prevent DOS attacks)
    if (input.length > 1000) {
      return false;
    }
    
    return true;
  }
}
