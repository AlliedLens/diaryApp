
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui/widgets/diary_entry_card.dart';
import 'package:ui/models/diaryEntry.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget{
  const HomePage({super.key});


  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {


  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  int selectedDay = DateTime.now().day;
  int selectedTime = DateTime.now().hour;


  void updateMonth(int diff){
    setState(() {
      selectedMonth += diff;
    });

    if (selectedMonth > 12){
      
      setState(() {
        selectedMonth = 1;
        selectedYear = selectedYear+1;        
      });
    }else if (selectedMonth < 1){
      setState(() {
        selectedMonth = 12;
        selectedYear = selectedYear - 1;        
      },);
    }
  }

  late Future<List<Diaryentry>> entries;

  Future<List<Diaryentry>> fetchDiaryEntries() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/diaryentries/all'),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Diaryentry> unfilteredDiaryEntries =  body.map((obj) => Diaryentry.fromJson(obj)).toList();

      return unfilteredDiaryEntries.where((entry) => int.parse(entry.date.split('/')[0]) == selectedYear && int.parse(entry.date.split('/')[1]) == selectedMonth).toList();

    } else {
      throw Exception('Failed to load entries');
    }

  }

  @override
  void initState(){
    super.initState();
    entries = fetchDiaryEntries();

  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        title: Center(child: 
          Text(
            DateFormat('MMM, y').format(DateTime(selectedYear, selectedMonth, selectedDay) )
          )
        ),

        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left),
          tooltip: 'Move Behind',
          onPressed: (){
            updateMonth(-1);
            print(selectedMonth);
            entries = fetchDiaryEntries();
          },
        ),

        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_circle_right),
            tooltip: 'Move Ahead',
            onPressed: (){
              updateMonth(1);
              print(selectedMonth);
              entries = fetchDiaryEntries();
            },
          ),
        

        ]
      ),

      body: FutureBuilder<List<Diaryentry>>(
        future: entries,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: 
              snapshot.data!.map((entry) {
                return (
                  Diaryentrycard(title: entry.title, entry: entry.entry, mood: entry.mood)
                );
              }).toList(),
            );
          }else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),

    );
  }
}