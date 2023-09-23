import 'package:flutter/material.dart';

import '../../../model/CategoryModel.dart';

class CategoryDropdown extends StatefulWidget {
  final CategoryModel category;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const CategoryDropdown({
    super.key,
    required this.category,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  bool isChecked = false;

  @override
  void initState() {
    isChecked = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenuItem(
      value: widget.category,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (bool? checked) {
              setState(() {
                isChecked = checked ?? false;
                widget.onChanged(isChecked);
              });
            },
          ),
          Text(widget.category.category ?? ""),
        ],
      ),
    );
  }
}
