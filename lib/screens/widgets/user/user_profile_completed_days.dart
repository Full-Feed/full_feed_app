import 'package:flutter/material.dart';
import 'package:full_feed_app/utilities/constants.dart';


class CompletedDaysItem extends StatefulWidget {
  final String completedDays;
  const CompletedDaysItem({required this.completedDays, Key? key}) : super(key: key);

  @override
  _CompletedDaysItemState createState() => _CompletedDaysItemState();
}

class _CompletedDaysItemState extends State<CompletedDaysItem> {
  final constants = Constants();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(constants.trophyPath, width: 55, height: 55),
            Positioned(
              top: 8,
              child: Text(widget.completedDays,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,
                      color: Color(constants.trophyTextColor))
              ),
            )
          ],
        ),
        Text(widget.completedDays,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
        ),
        const Text('Días', style: TextStyle(fontSize: 10.5)),
        const Text('cumplidos', style: TextStyle(fontSize: 10.5))
      ],
    );
  }
}
