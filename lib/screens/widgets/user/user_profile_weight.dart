import 'package:flutter/material.dart';
import 'package:full_feed_app/utilities/constants.dart';


class LostWeightItem extends StatefulWidget {
  final String lostWeight;
  const LostWeightItem({required this.lostWeight, Key? key}) : super(key: key);

  @override
  _LostWeightItemState createState() => _LostWeightItemState();
}

class _LostWeightItemState extends State<LostWeightItem> {
  final constants = Constants();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(constants.bodyScalePath, width: 55, height: 55),
            Positioned(
              top: 20,
              child: Text(widget.lostWeight,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,
                      color: Color(constants.trophyTextColor))
              ),
            )
          ],
        ),
        Text(widget.lostWeight,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
        ),
        const Text('Kg', style: TextStyle(fontSize: 10.5)),
        const Text('perdidos', style: TextStyle(fontSize: 10.5))
      ],
    );
  }
}
