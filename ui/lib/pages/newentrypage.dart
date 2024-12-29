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
  final String _mood = "";
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Entry logged for ${DateFormat.yMMMMEEEEd().format(_selectedDate ?? DateTime.now())}') 
      )
    );


    entryController.clear();
    titleController.clear();

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

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: ElevatedButton.icon(
            onPressed: () => datePicker(context),
            icon: const Icon(Icons.calendar_today),        
            label: Text(
              _selectedDate == null ? 'No date selected' : DateFormat.yMMMMEEEEd().format(_selectedDate ?? DateTime.now())
            ),
          ),
        ),


      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: MediaQuery.of(context).size.height * 0.05),

            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: "Title",
                labelStyle: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.4) )
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.15),

            TextFormField(
              controller: entryController,
              maxLines: 12,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Write about your day...',
                labelStyle: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.4) )

              ),
            ),

            // Word Count and Log Entry Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${entryController.text.split(' ').length} words',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => logEntry(context),
                  child: const Text("Save Entry"),
                ),
              ],
            ),


          ],
        )
      )



    );

  }
}