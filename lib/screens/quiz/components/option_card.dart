import 'package:flutter/material.dart';

class OptionCard extends StatefulWidget {
  final String option;
  final int index;
  final Function onTap;
  final bool isSelected;
  final bool isCorrect;

  const OptionCard({
    super.key,
    required this.option,
    required this.index,
    required this.onTap,
    required this.isSelected,
    required this.isCorrect,
  });

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.isSelected
                  ? widget.isCorrect
                      ? Colors.green
                      : Colors.red
                  : Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
            color: widget.isSelected
                ? widget.isCorrect
                    ? const Color(0xFFABD1C6)
                    : const Color(0xFFFFE7E7)
                : Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.index + 1} ${widget.option}",
                  style: TextStyle(
                    color: widget.isSelected
                        ? (widget.isCorrect as bool)
                            ? Colors.green
                            : Colors.red
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
                  child: widget.isSelected
                      ? Icon(
                          widget.isCorrect ? Icons.done : Icons.close,
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
