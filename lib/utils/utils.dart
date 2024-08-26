class Utils {
  //Create Singleton class instance
  static final Utils _utils = Utils._internal();

  //Private constructor
  Utils._internal();

  //Factory constructor
  factory Utils() {
    return _utils;
  }
  String getFirstTwoWords(String text) {
    final words = text.split(' ');
    if (words.length > 1) {
      text = '${words[0]} ${words[1]}';
    }

    //do the into string first character uppercase and rest lowercase
    text = text[0].toUpperCase() + text.substring(1).toLowerCase();
    return text;
  }

  static const jobDescription =
      '''We are seeking creative and highly skilled UI/UX Designers to join our team. This is an exciting opportunity to work on innovative projects and collaborate with a dynamic and talented group of professionals.

Requirements:
Portfolio: Strong Behance portfolio
Skills: Proficiency in Figma
Creativity: Ability to create engaging user experiences

Job Details:
Position: Full-time, remote
Hours: Flexible (IST time zone)
Projects: 2-3 simultaneous projects
Tasks: Wireframes, high-fidelity mockups, animated prototypes

Why Join Us?
Work on cutting-edge projects that push the boundaries of design
Collaborative and innovative work environment
Opportunity to grow and expand your skills
Competitive compensation and benefits

Teamwork: Close work with senior designers and developers''';
}
