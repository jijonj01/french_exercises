import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavBar extends StatefulWidget {
  final StatefulNavigationShell shell;

  const CustomBottomNavBar({super.key, required this.shell});
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  final List<IconData> _icons = [Icons.home_outlined, Icons.person_outline];

  final List<String> _labels = ['Home', 'About'];

  final Color _selectedColor = Colors.cyan;
  final Color _unselectedColor = Colors.grey;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
      widget.shell.goBranch(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30, left: 100, right: 100),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_icons.length, (index) {
          final isSelected = _selectedIndex == index;
          return GestureDetector(
            onTap: () => _onTap(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _icons[index],
                  color: isSelected ? _selectedColor : _unselectedColor,
                ),
                SizedBox(height: 4),
                Text(
                  _labels[index],
                  style: TextStyle(
                    color: isSelected ? Colors.black54 : _unselectedColor,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
