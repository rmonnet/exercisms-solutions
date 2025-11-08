class Bob {
  String response(String question) {
    question = question.trimRight();
    // response to silence
    if (question == "") {
      return "Fine. Be that way!";
    }
    // response to yelling (must contain some text)
    if (question.contains(RegExp(r'[a-zA-Z]')) &&
        question == question.toUpperCase()) {
      if (question.endsWith("?")) {
        return "Calm down, I know what I'm doing!";
      } else {
        return "Whoa, chill out!";
      }
    }
    // response to normal question
    if (question.endsWith("?")) {
      return "Sure.";
    }
    // default response
    return "Whatever.";
  }
}
