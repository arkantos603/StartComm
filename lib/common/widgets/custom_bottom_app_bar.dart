import 'package:flutter/material.dart';

import 'package:startcomm/common/constants/app_colors.dart';

class CustomBottomAppBar extends StatefulWidget {
  final Color? selectedItemColor;
  final List<CustomBottomAppBarItem> children;
  const CustomBottomAppBar({
    super.key,
    this.selectedItemColor,
    required this.children,
  }) : assert(children.length == 4, 'children.length must be 4');

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int _selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.children.map<Widget>(
          (item) {
            final currentItem =
                widget.children.indexOf(item) == _selectedItemIndex;
            return Expanded(
              child: InkWell(
                onTap: item.onPressed,
                onTapUp: (_) => setState(() {
                  _selectedItemIndex = widget.children.indexOf(item);
                }),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Icon(
                    currentItem ? item.primaryIcon : item.secondaryIcon,
                    color: currentItem
                        ? widget.selectedItemColor
                        : AppColors.lightGrey,
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

class CustomBottomAppBarItem {
  final String? label;
  final IconData? primaryIcon;
  final IconData? secondaryIcon;
  final VoidCallback? onPressed;

  CustomBottomAppBarItem({
    this.label,
    this.primaryIcon,
    this.secondaryIcon,
    this.onPressed,
  });

  CustomBottomAppBarItem.empty({
    this.label,
    this.primaryIcon,
    this.secondaryIcon,
    this.onPressed,
  });
}
