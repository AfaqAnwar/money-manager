// Module List Item a class that will create an module object for the three modules
class ModulesListItems {

// the attributes for the module
  String moduleTitle;
  Map<String, String> lessons;
  Set<dynamic> quiz;

  //constructur initalizing all the attributes  
  ModulesListItems(this.moduleTitle, this.lessons, this.quiz);

  // methods to get and set each attributes
  void setModuleTitle(String title){
    moduleTitle = title;
  }
  void setLesson(Map<String, String> lesson){
    lessons = lesson;
  }
  void setQuiz(Set<dynamic> quiz){
    quiz = quiz;
  }

  String getModuleTitle(){
    return moduleTitle;
  }
  List<String> getLesson(){
    List<String> l = [];
    lessons.forEach((key, value) {
      print('Lesson Title: $key' + "and " + "Lesson Description: $value");
      l.add(key);
      l.add(value);
    });
    return l;

  }
  Set<dynamic> getQuiz(){
    return quiz;
  }
}