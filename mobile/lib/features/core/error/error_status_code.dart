import 'dart:io';

class SystemFailureStatusCode {
  static int unknownError = 000;
  static int networkError = 001;
  static int databaseError = 002;
  static int parsingError = 004;
  static int valueError = 005;
  static int noFailure = 099;

  // Related to server side
  static int authError = 401;
  static int notFound = HttpStatus.notFound;
}
