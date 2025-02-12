class FirebaseErrorFormatter {
  String formatFirebaseError(String errorMessage) {
    final regex = RegExp(r'\[.*?\]\s*');
    return errorMessage.replaceAll(regex, '');
  }
}
