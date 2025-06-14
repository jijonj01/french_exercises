/// Data class for each module
class ModuleItem {
  final int id;
  final String moduleLabel;
  final String title;
  final String imageUrl;
  final String duration;
  final int lessonsCount;
  final bool isLocked;
  final List<SubModuleItem> subModules;

  const ModuleItem({
    required this.id,
    required this.moduleLabel,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.lessonsCount,
    required this.isLocked,
    required this.subModules,
  });
}

class SubModuleItem {
  final String title;
  final String path;

  const SubModuleItem({required this.title, required this.path});
}

final List<ModuleItem> a1Modules = const [
  ModuleItem(
    id: 1,
    title: 'A1 Course',
    imageUrl: 'https://picsum.photos/800/1200?random=10',
    moduleLabel: 'A1 Course',
    duration: '2 hours',
    lessonsCount: 6,
    isLocked: false,
    subModules: [
      SubModuleItem(title: '1', path: '/a1exercise/1'),
      SubModuleItem(title: '2', path: '/a1exercise/2'),
      SubModuleItem(title: '3', path: '/a1exercise/3'),
    ],
  ),
  ModuleItem(
    id: 2,
    title: 'A1 Course - Module 2',
    imageUrl: 'https://picsum.photos/800/1200?random=20',
    moduleLabel: 'A1 Course - Module 2',
    duration: '1 hour',
    lessonsCount: 3,
    isLocked: false,
    subModules: [
      SubModuleItem(title: '1', path: '/a1exercise/4'),
      SubModuleItem(title: '2', path: '/a1exercise/5'),
      SubModuleItem(title: '3', path: '/a1exercise/6'),
    ],
  ),
  ModuleItem(
    id: 3,
    title: 'A1 Course - Module 3',
    imageUrl: 'https://picsum.photos/800/1200?random=30',
    moduleLabel: 'A1 Course - Module 3',
    duration: '1.5 hours',
    lessonsCount: 4,
    isLocked: false,
    subModules: [
      SubModuleItem(title: '1', path: '/a1exercise/7'),
      SubModuleItem(title: '2', path: '/a1exercise/8'),
      SubModuleItem(title: '3', path: '/a1exercise/9'),
    ],
  ),
  ModuleItem(
    id: 4,
    title: 'A1 Course - Module 4',
    imageUrl: 'https://picsum.photos/800/1200?random=40',
    moduleLabel: 'A1 Course - Module 4',
    duration: '2.5 hours',
    lessonsCount: 5,
    isLocked: false,
    subModules: [SubModuleItem(title: '1', path: '/a1exercise/10')],
  ),
  ModuleItem(
    id: 5,
    title: 'A1 Course - Module 5',
    imageUrl: 'https://picsum.photos/800/1200?random=50',
    moduleLabel: 'A1 Course - Module 5',
    duration: '3 hours',
    lessonsCount: 6,
    isLocked: false,
    subModules: [
      SubModuleItem(title: '1', path: '/a1exercise/11'),
      SubModuleItem(title: '2', path: '/a1exercise/12'),
    ],
  ),
  ModuleItem(
    id: 6,
    title: 'A1 Course - Module 6',
    imageUrl: 'https://picsum.photos/800/1200?random=60',
    moduleLabel: 'A1 Course - Module 6',
    duration: '4 hours',
    lessonsCount: 7,
    isLocked: false,
    subModules: [
      SubModuleItem(title: '1', path: '/a1exercise/13'),
      SubModuleItem(title: '2', path: '/a1exercise/14'),
    ],
  ),
  ModuleItem(
    id: 7,
    title: 'A1 Course - Module 7',
    imageUrl: 'https://picsum.photos/800/1200?random=70',
    moduleLabel: 'A1 Course - Module 7',
    duration: '2 hours',
    lessonsCount: 5,
    isLocked: false,
    subModules: [
      SubModuleItem(title: '1', path: '/a1exercise/15'),
      SubModuleItem(title: '2', path: '/a1exercise/16'),
    ],
  ),
  ModuleItem(
    id: 8,
    title: 'A1 Course - Module 8',
    imageUrl: 'https://picsum.photos/800/1200?random=80',
    moduleLabel: 'A1 Course - Module 8',
    duration: '3 hours',
    lessonsCount: 6,
    isLocked: false,
    subModules: [
      SubModuleItem(title: '1', path: '/a1exercise/17'),
      SubModuleItem(title: '2', path: '/a1exercise/18'),
    ],
  ),
  ModuleItem(
    id: 9,
    title: 'A1 Course - Module 9',
    imageUrl: 'https://picsum.photos/800/1200?random=90',
    moduleLabel: 'A1 Course - Module 9',
    duration: '1 hour',
    lessonsCount: 2,
    isLocked: false,
    subModules: [SubModuleItem(title: '1', path: '/a1exercise/19')],
  ),
  ModuleItem(
    id: 10,
    title: 'A1 Course - Module 10',
    imageUrl: 'https://picsum.photos/800/1200?random=100',
    moduleLabel: 'A1 Course - Module 10',
    duration: '2 hours',
    lessonsCount: 4,
    isLocked: false,
    subModules: [
      SubModuleItem(title: '1', path: '/a1exercise/20'),
      SubModuleItem(title: '2', path: '/a1exercise/21'),
      SubModuleItem(title: '3', path: '/a1exercise/22'),
    ],
  ),
  ModuleItem(
    id: 11,
    title: 'A1 Course - Module 11',
    imageUrl: 'https://picsum.photos/800/1200?random=110',
    moduleLabel: 'A1 Course - Module 11',
    duration: '3 hours',
    lessonsCount: 5,
    isLocked: false,
    subModules: [
      SubModuleItem(title: '1', path: '/a1exercise/23'),
      SubModuleItem(title: '2', path: '/a1exercise/24'),
      SubModuleItem(title: '3', path: '/a1exercise/25'),
    ],
  ),
];
