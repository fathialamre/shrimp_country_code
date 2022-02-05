import 'package:flutter/material.dart';

class CircleRadioOption<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String? title;
  final bool withTitle;
  final ValueChanged<T?> onChanged;

  const CircleRadioOption(
      {required this.value,
      required this.groupValue,
      this.title,
      this.withTitle = false,
      required this.onChanged,
      Key? key})
      : super(key: key);

  Widget _buildIcon() {
    final bool isSelected = value == groupValue;

    return Container(
        width: 23,
        height: 23,
        decoration: ShapeDecoration(
          shape: CircleBorder(
            side: BorderSide(
                color: isSelected
                    ? const Color(0xFFFF4E02)
                    : const Color(0xFFCACED2),
                width: 1.2),
          ),
          color: isSelected ? const Color(0xFFFF4E02) : Colors.white,
        ),
        child: isSelected
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              )
            : Container());
  }

  Widget _buildTitle() {
    return Text(
      title!,
      style: const TextStyle(color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        onTap: () => onChanged(value),
        // splashColor: Colors.cyan.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: withTitle
              ? Row(
                  children: [
                    _buildIcon(),
                    const SizedBox(width: 10),
                    _buildTitle(),
                  ],
                )
              : _buildIcon(),
        ),
      ),
    );
  }
}
