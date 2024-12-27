import 'package:flutter/material.dart';

class Diaryentrycard extends StatefulWidget {
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
  State<Diaryentrycard> createState() => _DiaryentrycardState();
}

class _DiaryentrycardState extends State<Diaryentrycard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    
    return AnimatedContainer(
      duration : const Duration(seconds : 2),
      curve: Curves.easeIn,
      child: InkWell(
        
        onTap: (){
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },


        child: Center(
          child: SizedBox(
            height: _isExpanded ? MediaQuery.of(context).size.height * 0.75 : MediaQuery.of(context).size.height * 0.25,
            child: Card(
              child: ListTile(
                title: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  widget.entry,
                  maxLines: _isExpanded ? 20: 2, // Restrict to a single line
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(widget.mood),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
