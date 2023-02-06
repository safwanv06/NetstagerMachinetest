import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../Services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController txt1 = TextEditingController();
  TextEditingController txt2 = TextEditingController();
  TextEditingController txt3 = TextEditingController();
  TextEditingController txt4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: Services.items.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Slidable(
                            direction: Axis.horizontal,
                            startActionPane:
                                ActionPane(motion: ScrollMotion(), children: [
                              SlidableAction(
                                onPressed: (context) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child: AlertDialog(actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('cancel')),
                                          TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  Services.items
                                                      .removeAt(index);
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                              child: Text('Ok'))
                                        ], title: Text('Delete')),
                                      );
                                    },
                                  );
                                },
                                icon: Icons.delete,
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  txt1.text = Services.items[index]['title'];
                                  txt2.text = Services.items[index]['subtitle'];
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                          child: AlertDialog(
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Edit!!!'),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    label: Text('Title'),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    2)))),
                                                controller: txt1,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller: txt2,
                                                decoration: InputDecoration(
                                                    label: Text('SubTitle'),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    2)))),
                                              ),
                                            )
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('cancel')),
                                          TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  Services.items[index]
                                                      ['title'] = txt1.text;
                                                  Services.items[index]
                                                      ['subtitle'] = txt2.text;
                                                  Navigator.of(context).pop();
                                                });

                                              },
                                              child: Text('Ok'))
                                        ],
                                      ));
                                    },
                                  );
                                },
                                icon: Icons.edit,
                              )
                            ]),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(30)),
                              child: ListTile(
                                title: Text(Services.items[index]['title']),
                                subtitle:
                                    Text(Services.items[index]['subtitle']),
                              ),
                            ),
                          ),
                          Divider()
                        ],
                      );
                    },
                  ),
                )),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Center(
                    child: Container(
                        child: AlertDialog(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Add to List'),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              label: Text('Title'),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)))),
                          controller: txt3,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: txt4,
                          decoration: InputDecoration(
                              label: Text('SubTitle'),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)))),
                        ),
                      )
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('cancel')),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            Services.items.add({
                              'title': txt3.text.isEmpty ? 'null' : txt3.text,
                              'subtitle': txt4.text.isEmpty ? 'null' : txt4.text
                            });
                            Navigator.pop(context);
                            txt3.clear();
                            txt4.clear();
                          });

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Added'),
                            elevation: 10,
                            behavior: SnackBarBehavior.floating,
                          ));
                        },
                        child: Text('Add'))
                  ],
                )));
              },
            );
          },
          child: Icon(Icons.add),
        ));
  }
}
