import 'package:flutter/material.dart';

class Diaryentrycard extends StatelessWidget {
  final String title;
  final String entry;
  final String mood;
  final IconData leadingIcon;

  const Diaryentrycard({
    super.key,
    required this.title,
    required this.entry,
    required this.mood,
    this.leadingIcon = Icons.add_chart_sharp
  });

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(leadingIcon),
                title: Text(title),
                subtitle: Text(entry),
                trailing: Text(mood),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
