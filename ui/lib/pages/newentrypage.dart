import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Newentrypage extends StatefulWidget {
  const Newentrypage({super.key});

  @override
  _NewentrypageState createState() => _NewentrypageState();

}

class _NewentrypageState extends State<Newentrypage> {
  DateTime? _selectedDate = DateTime.now();
  String _entry = "";
  String _title = "";
  String _mood = "";
  List<String> tags = [];

  final TextEditingController entryController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  datePicker(BuildContext context) async{

    DateTime now = DateTime.now();
    DateTime initialDate = _selectedDate ?? now;
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime(2100);

    DateTime? pickedDate = await showDatePicker(
      context: context, 
      firstDate: firstDate, 
      lastDate: lastDate,
      initialDate: initialDate,
    );

    if (pickedDate != null){
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void logEntry(BuildContext context) async{

    setState((){
      _entry = entryController.text;
      _title = titleController.text;
    });

    showDialog(context: context, builder: (context){
      return AlertDialog( content: Text(_entry) );
    });



    entryController.text = "";
    titleController.text = "";

  }

  @override
  void dispose(){
    entryController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    entryController.addListener((){
      setState( (){});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () => datePicker(context),

          child: Column(
            children: [
              const Divider(),
              Text(
                _selectedDate == null ? 'No date selected' : DateFormat.yMMMMEEEEd().format(_selectedDate ?? DateTime.now())
              ),
              const Divider(),
            ],
          ),
        ),

        TextFormField(
          controller: titleController,
          decoration:  const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'enter title',
          ),
        ), 

        TextFormField(
          controller: entryController,

          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Dear Diary...',
          ),
        ),

        InkWell(
          onTap: () => logEntry(context),
          child: 
          Column(
            children: [
              const Divider(),
              Text(
                ' Log ${entryController.text.split(' ').length} words'
              ),
              const Divider(),
            ],
          ),
        ),

      ],
    );
  }
}