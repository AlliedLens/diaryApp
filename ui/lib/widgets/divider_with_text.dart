import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget{
  final String subtitle;


  const DividerWithText({
    super.key,
    required this.subtitle
  });

  @override
  Widget build(BuildContext context) {
    return 
      Row(children: [
          const Expanded(child: Divider()),
          Text(
            subtitle,
            textScaler: const TextScaler.linear(0.75),
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
          const Expanded(child: Divider())
        ]
    );
  }

}