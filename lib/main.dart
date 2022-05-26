import 'package:project_lab/newnote.dart';
import 'package:flutter/material.dart';
import 'DB_database.dart';
import 'startpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff1321E0),
      ),
      home: StartPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> notes = [];
  void getnotes() async {
    final data = await SQLHelper.getItems();
    setState(() {
      notes = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getnotes();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff1321E0),
        title: Text(
          "My Notes",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: notes.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 600,
                  width: 600,
                  child: Image.asset(
                    'assets/nonote.png',
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Addnotes(note: notes[index])));
                  },
                  child: Container(
                    height: 110,
                    width: 100,
                    margin: new EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 110,
                          width: 5,
                          decoration: BoxDecoration(
                              color: Color(notes[index]['color']),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30))),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: Column(
                            children: [
                              Text(
                                notes[index]['title']!,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff1321E0),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                notes[index]['description']!,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => Addnotes()));
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient:
                  LinearGradient(colors: [Color(0xff1321E0), Colors.purple])),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
