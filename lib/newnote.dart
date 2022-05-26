import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_lab/DB_database.dart';
import 'DB_database.dart';
import 'package:project_lab/main.dart';

class Addnotes extends StatefulWidget {
  late Map<String, dynamic>? note;
  Addnotes({this.note});

  @override
  State<Addnotes> createState() => _AddnotesState();
}

class _AddnotesState extends State<Addnotes> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  int color = 0xff1321E0;
  Future<void> _addItem() async {
    await SQLHelper.createItem(
      titleController.text,
      descriptionController.text,
      color,
    );
    Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()))
        .then((value) {
      setState(() {});
    });
  }

  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, titleController.text, descriptionController.text, color);
    Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()))
        .then((value) {
      setState(() {});
    });
  }

  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a new item!'),
    ));
    Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()))
        .then((value) {
      setState(() {});
    });
  }

  List<int> colors = [
    0xFF1321E0,
    0xFFFFFFFF,
    0xFFF28B81,
    0xFFF7BD02,
    0xFFFBF476,
    0xFFCDFF90,
    0xFFA7FEEB,
    0xFFCBF0F8,
    0xFFAFCBFA,
    0xFFD7AEFC,
    0xFFFBCFE9,
    0xFFE6C9A9,
    0xFFE9EAEE
  ];
  @override
  void initState() {
    if (widget.note != null) {
      titleController.text = widget.note!['title'];
      descriptionController.text = widget.note!['description'];
      color = widget.note!['color'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(color),
        //leading: Text(widget.note == null ? '' : ''),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 300,
                            color: Color(color),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Color(0xffA8A8A8),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.share,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                    onTap: () {},
                                    title: Text(
                                      'Share with your Friends',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  ListTile(
                                      leading: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Color(0xffA8A8A8),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                      title: Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onTap: () {
                                        _deleteItem(widget.note?['id']);
                                      }),
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Color(0xffA8A8A8),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.copy,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                    title: Text(
                                      'Deplicate',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      _addItem();
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: colors
                                          .map((e) => GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    color = e;
                                                  });
                                                },
                                                child: Container(
                                                  height: 55,
                                                  width: 55,
                                                  margin: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color: Color(e),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  child: color == e
                                                      ? Center(
                                                          child: Icon(
                                                          Icons.check,
                                                          size: 25,
                                                        ))
                                                      : Container(),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.more_vert,
                      size: 25,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 12,
                ),
                GestureDetector(
                    onTap: () {
                      if (widget.note != null) {
                        _updateItem(widget.note!['id']);
                      } else {
                        _addItem();
                      }
                    },
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 25,
                    )),
              ],
            ),
          )
        ],
        title: Text(
          "My Notes",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          //  final DateTime today = new DateTime.now();
          //  String dateSlug ="${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
          //  print(dateSlug);
          SizedBox(
            height: 30,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Color(0xff1321E0)),
                  hintText: "Type Something....",
                ),
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1321E0)),
              )),
          // SizedBox(
          //   height: 2,
          // ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.green),
                  hintText: "Type Something...",
                ),
              ))
        ],
      ),
    );
  }

  _showBottomSheet(BuildContext context) {}
}
