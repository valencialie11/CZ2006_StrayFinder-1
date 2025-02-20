
import '../screens/AuthResultStatus.dart';

/// Represents the control class that has methods controlling Registration
class RegisterMngr {
  
  /// A method to handle exception and return error messages
  static handleException(e) {
    print(e.code);
    var status;
    switch (e.code) {
      case "weak-password":
        status= AuthResultStatus.weakPassword;
        break;
      case "email-already-in-use":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      case "invalid-email":
        status = AuthResultStatus.invalidEmail;
        break;
      case "ERROR_USER_DISABLED":
        status = AuthResultStatus.userDisabled;
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        status = AuthResultStatus.tooManyRequests;
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        status = AuthResultStatus.operationNotAllowed;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  /// A method to generate an exception message in the event of an error committed by the user
  static generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = "The email address you entered is invalid. Please check and try again later.";
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "Your password is wrong.";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "User with this email doesn't exist.";
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = "User with this email has been disabled.";
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = "Too many requests. Try again later.";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage =
        "The email has already been registered. Please login to your existing account.";
        break;
      case AuthResultStatus.weakPassword:
        errorMessage =
        "The password used to register this account is too weak. Please ensure that your password has a minimum of 6 characters.";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }

    return errorMessage;
  }
}