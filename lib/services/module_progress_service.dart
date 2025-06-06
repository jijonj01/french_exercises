import 'package:shared_preferences/shared_preferences.dart';

class ModuleProgressService {
  static const String _lastExerciseKey = 'last_opened_exercise';
  static const String _courseProgressPrefix = 'course_progress_';

  // Get the last opened exercise path
  static Future<String?> getLastOpenedExercise() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastExerciseKey);
  }

  // Set the last opened exercise path
  static Future<void> setLastOpenedExercise(String exercisePath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastExerciseKey, exercisePath);
  }

  // Check if a specific exercise path is the last played one
  static Future<bool> isLastPlayedExercise(String exercisePath) async {
    final lastExercise = await getLastOpenedExercise();
    return lastExercise == exercisePath;
  }

  // Get course progress (completed exercises)
  static Future<Set<String>> getCourseProgress(String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    final progressList =
        prefs.getStringList('$_courseProgressPrefix$courseId') ?? [];
    return Set<String>.from(progressList);
  }

  // Mark an exercise as completed
  static Future<void> markExerciseCompleted(
    String courseId,
    String exercisePath,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final progress = await getCourseProgress(courseId);
    progress.add(exercisePath);
    await prefs.setStringList(
      '$_courseProgressPrefix$courseId',
      progress.toList(),
    );
  }

  // Check if an exercise is completed
  static Future<bool> isExerciseCompleted(
    String courseId,
    String exercisePath,
  ) async {
    final progress = await getCourseProgress(courseId);
    return progress.contains(exercisePath);
  }

  // Clear all progress (useful for testing or reset functionality)
  static Future<void> clearAllProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_lastExerciseKey);

    // Remove all course progress
    final keys = prefs.getKeys();
    for (final key in keys) {
      if (key.startsWith(_courseProgressPrefix)) {
        await prefs.remove(key);
      }
    }
  }
}
