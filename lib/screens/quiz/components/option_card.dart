import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String option;
  final int index;
  final Function onTap;
  final bool isSelected;
  final bool isCorrect;

  const OptionCard({
    required this.option,
    required this.index,
    required this.onTap,
    required this.isSelected,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected
                  ? (isCorrect ? Colors.green : Colors.red)
                  : Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
            color: isSelected
                ? (isCorrect
                    ? const Color(0xFFABD1C6)
                    : const Color(0xFFFFE7E7))
                : Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$index. $option",
                  style: TextStyle(
                    color: isSelected
                        ? (isCorrect ? Colors.green : Colors.red)
                        : Colors.black,
                  ),
                ),
                Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(color: const Color(0xFFABD1C6)),
                  ),
                  child: isSelected
                      ? Icon(
                          isCorrect ? Icons.done : Icons.close,
                          size: 16.0,
                        )
                      : null,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
