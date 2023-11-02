class PromptDetails {
  int promptId;
  int userId;
  String topicToLearn;
  String experienceLevel;
  int hoursPerWeek;
  int preferredCourseLength;
  String goal;
  String learningMode;
  String learningPreference;
  String similarExpertise;

  PromptDetails({
    required this.promptId,
    required this.userId,
    required this.topicToLearn,
    required this.experienceLevel,
    required this.hoursPerWeek,
    required this.preferredCourseLength,
    required this.goal,
    required this.learningMode,
    required this.learningPreference,
    required this.similarExpertise,
  });
}
