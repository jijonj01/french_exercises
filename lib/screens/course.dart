import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:french_exercises/exercises_model.dart';
import 'package:french_exercises/services/module_progress_service.dart';
import 'package:go_router/go_router.dart';

String? lastOpenedExercise;

class CourseDetailPage extends StatefulWidget {
  final String course;
  final String imageUrl;
  const CourseDetailPage({
    Key? key,
    required this.course,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  String? lastOpenedExercise;

  @override
  void initState() {
    super.initState();
    _loadLastOpenedExercise();
  }

  Future<void> _loadLastOpenedExercise() async {
    final lastExercise = await ModuleProgressService.getLastOpenedExercise();
    if (mounted) {
      setState(() {
        lastOpenedExercise = lastExercise;
      });
    }
  }

  // Dummy data for modules
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1) Scrollable content
          SingleChildScrollView(
            child: Column(
              children: [
                // --- HEADER IMAGE + OVERLAYS ---
                Stack(
                  children: [
                    // Header image (replace with your own asset or network)
                    ClipRRect(
                      child: Hero(
                        tag: widget.imageUrl,
                        child: CachedNetworkImage(
                          imageUrl: widget.imageUrl,
                          height: 280,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Back arrow (top left)
                    Positioned(
                      top: 40,
                      left: 16,
                      child: GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 20,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // --- AUTHOR INFO, TITLE, DESCRIPTION ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Author row: avatar, name, separator, duration
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Rona Dida',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            '·',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(width: 6),
                          Row(
                            children: const [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '1h 35 min',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Title
                      const Text(
                        'The art of speech',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Description
                      const Text(
                        'How we developed speech and how it became such a powerful tool, let’s see.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 28),

                      // “The progress” header + view icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'The progress',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.grid_view_outlined,
                                size: 22,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 16),
                              Icon(
                                Icons.view_list_outlined,
                                size: 22,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),

                // --- MODULE LIST (TIMELINE) ---
                if (widget.course == 'A1-Basic French')
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children:
                          a1Modules.asMap().entries.map((entry) {
                            final idx = entry.key;
                            final item = entry.value;
                            final bool isLast = idx == a1Modules.length - 1;
                            final bool isCurrentlyLastPlayed =
                                lastOpenedExercise == item.id.toString();
                            return _ModuleTile(
                              data: item,
                              isFirst: idx == 0,
                              isLast: isLast,
                              isLastPlayed: isCurrentlyLastPlayed,
                              imageUrl: item.imageUrl,
                            );
                          }).toList(),
                    ),
                  )
                else
                  Center(
                    child: Text(
                      'No modules available for this course',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A single module row, with a vertical timeline indicator on the left
class _ModuleTile extends StatefulWidget {
  final ModuleItem data;
  final bool isLastPlayed;
  final bool isFirst;
  final bool isLast;
  final String imageUrl;

  const _ModuleTile({
    Key? key,
    required this.data,
    required this.isLastPlayed,
    required this.isFirst,
    required this.isLast,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<_ModuleTile> createState() => _ModuleTileState();
}

class _ModuleTileState extends State<_ModuleTile> {
  @override
  void initState() {
    super.initState();
    _loadLastOpenedExercise();
  }

  Future<void> _loadLastOpenedExercise() async {
    final lastExercise = await ModuleProgressService.getLastOpenedExercise();
    if (mounted) {
      setState(() {
        lastOpenedExercise = lastExercise;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Left column width for timeline icons
    const double leftColumnWidth = 40;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ------------------ TIMELINE COLUMN ------------------
        SizedBox(
          width: leftColumnWidth,
          child: Column(
            children: [
              // Top spacing for the first item so the dot sits lower
              if (!widget.isFirst) const SizedBox(height: 8),
              // Icon: either playing or locked
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color:
                      widget.data.isLocked
                          ? Colors.grey.shade200
                          : (lastOpenedExercise == widget.data.id.toString()
                              ? Colors.amber[600]
                              : Colors.white),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        widget.data.isLocked
                            ? Colors.grey.shade400
                            : (lastOpenedExercise == widget.data.id.toString()
                                ? Colors.amber[600]!
                                : Colors.grey.shade400),
                    width: 2,
                  ),
                ),
                child:
                    widget.data.isLocked
                        ? const Icon(Icons.lock, size: 14, color: Colors.grey)
                        : (lastOpenedExercise == widget.data.id.toString()
                            ? const Icon(
                              Icons.play_arrow,
                              size: 14,
                              color: Colors.white,
                            )
                            : null),
              ),
              // Vertical line between icons, except after the last item
              if (!widget.isLast)
                Container(
                  width: 2,
                  height: 120,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  color: Colors.grey.shade300,
                ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        // ------------------ MODULE CARD ------------------
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 24),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: widget.data.isLocked ? Colors.white : Colors.green[50],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: widget.imageUrl,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                      fit: BoxFit.cover,
                      height: 30,
                      width: double.infinity,
                    ),
                  ),
                ),
                // MODULE label
                Text(
                  widget.data.moduleLabel,
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        widget.data.isLocked ? Colors.grey : Colors.green[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                // Title
                Text(
                  widget.data.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color:
                        widget.data.isLocked
                            ? Colors.grey.shade700
                            : Colors.black87,
                  ),
                ),

                const SizedBox(height: 12),

                // Duration and lessons count row
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: widget.data.isLocked ? Colors.grey : Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.data.duration,
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.data.isLocked ? Colors.grey : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.menu_book,
                      size: 14,
                      color: widget.data.isLocked ? Colors.grey : Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.data.lessonsCount} lessons',
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.data.isLocked ? Colors.grey : Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                // Wrap in a fixed-height container (so ListView knows its height)
                Container(
                  height: 50, // adjust as needed for your item’s height
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    itemCount: widget.data.subModules.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          //set shared preferences
                          await ModuleProgressService.setLastOpenedExercise(
                            widget.data.id.toString(),
                          );

                          await _loadLastOpenedExercise();

                          context.pushNamed(
                            'a1exercise',
                            pathParameters: {
                              'exerciseNumber':
                                  widget.data.subModules[index].path
                                      .split('/')
                                      .last,
                            },
                            queryParameters: {'imageUrl': widget.imageUrl},
                          );
                        },
                        child: Container(
                          // give each item a fixed width (so you can see multiple at once)
                          width: 50,
                          margin: const EdgeInsets.only(
                            right: 8,
                          ), // 4px space between items
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            widget.data.subModules[index].title,
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
