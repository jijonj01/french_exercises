/// Data class for each module
class ModuleItem {
  final String moduleLabel;
  final String title;
  final String duration;
  final int lessonsCount;
  final bool isLocked;
  final String path;

  const ModuleItem({
    required this.moduleLabel,
    required this.title,
    required this.duration,
    required this.lessonsCount,
    required this.isLocked,
    required this.path,
  });
}

final List<ModuleItem> a1 = const [
  ModuleItem(
    title: 'How it all started. Explanation',
    moduleLabel: 'MODULE 1',
    duration: '22 min',
    path: '/a1exercise/1',
    lessonsCount: 2,
    isLocked: false,
  ),
  ModuleItem(
    title: 'What we didn’t know about catastrophe',
    moduleLabel: 'MODULE 2',
    duration: '12 min',
    path: '/a1exercise/2',
    lessonsCount: 2,
    isLocked: false,
  ),
  ModuleItem(
    title: 'The rise of language. Deep dive',
    moduleLabel: 'MODULE 3',
    duration: '18 min',
    path: '/a1exercise/3',
    lessonsCount: 3,
    isLocked: false,
  ),
  ModuleItem(
    title: 'The rise of language. Deep dive 1',
    moduleLabel: 'MODULE 3',
    duration: '18 min',
    path: '/a1exercise/4',
    lessonsCount: 3,
    isLocked: false,
  ),
];
