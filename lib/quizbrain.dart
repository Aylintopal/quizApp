import 'questions.dart';

class QuizBrain {
  int _questionNumber = 0;
  List<Question> _questionBank = [
    Question(questionText: 'Sharks are mammals', questionAnswer: false),
    Question(
        questionText:
            'Sea otters have a favorite rock they use to break open food',
        questionAnswer: true),
    Question(
        questionText: 'The blue whale is the biggest animal to have ever lived',
        questionAnswer: true),
    Question(questionText: 'Bats are blind', questionAnswer: false),
    Question(
        questionText: 'A dog sweats by panting its tongue',
        questionAnswer: false),
    Question(
        questionText: 'It takes a sloth two weeks to digest a meal',
        questionAnswer: true),
    Question(
        questionText:
            'The largest living frog is the Goliath frog of West Africa',
        questionAnswer: true),
    Question(
        questionText: 'An ant can lift 1,000 times its body weight',
        questionAnswer: false),
    Question(
        questionText:
            'When exiting a cave, bats always go in the direction of the wind',
        questionAnswer: false),
    Question(
        questionText: 'An octopus has seven hearts', questionAnswer: false),
  ];
  String getText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  bool isFinished() {
    if (_questionNumber == _questionBank.length - 1) {
      return true;
    } else
      return false;
  }

  void reset() {
    _questionNumber = 0;
  }
}
