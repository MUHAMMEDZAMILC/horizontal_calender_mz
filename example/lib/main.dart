import 'package:flutter/material.dart';
import 'package:horizontal_calender_mz/apptext.dart';
import 'package:horizontal_calender_mz/horizontal_calender_mz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horizontal Calender Mz',
      theme: ThemeData(
       
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Horizontal Calender'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
ValueNotifier<DateTime?> selecteddate = ValueNotifier<DateTime?>(null);
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           HorizontalCalenderMZ(
            selectedDate: selecteddate,
            onDateSelected: (selectedDate) {
              selecteddate.value = selectedDate;
              setState(() {
                
              });
              // Handle the selected date here
            },
            startyear: 2000,
            endyear: 2050,
            footer: true,
            ),

          ],
        ),
      ),
      
    );
  }
}
