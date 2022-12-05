// Module List Item a class that will create an module object for the three modules
class ModulesItems {
// the instances every module class would have
  String moduleTitle;
  Map<String, String> lessons;
  Set<dynamic> quiz;

  //constructur initalizing all the attributes  R
  ModulesItems(this.moduleTitle, this.lessons, this.quiz);

  // Set Methods to set the following instance fields: moduleTitle, Lessons, Quizs
  void setModuleTitle(String title) {
    moduleTitle = title;
  }

  void setLesson(Map<String, String> lesson) {
    lessons = lesson;
  }

  void setQuiz(Set<dynamic> quiz) {
    quiz = quiz;
  }

  // Get the methods
  String getModuleTitle() {
    return moduleTitle;
  }

  List<String> getLesson() {
    List<String> l = [];
    lessons.forEach((key, value) {
      //print('Lesson Title: $key' + "and " + "Lesson Description: $value");
      //print("Key: ");
      //print(key);
      l.add(key);
      //print("Value: ");
      //print(value);
      l.add(value);
    });
    return l;
  }

  Set<dynamic> getQuiz() {
    return quiz;
  }
}

// Class for Quiz Questions and Option Lists
class Question {
  final String text;
  final List<Option> options;
  bool isLocked;
  Option? selectedOption;

  Question(
      {required this.text,
      required this.options,
      this.isLocked = false,
      this.selectedOption});
}

// Class the hold the multiple choice for each question
class Option {
  final String text;
  final bool isCorrect;

  const Option({required this.text, required this.isCorrect});
}
