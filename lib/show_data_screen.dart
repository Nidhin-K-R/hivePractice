import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_practice/create_data_screen.dart';
import 'package:hive_practice/edit_screen.dart';
import 'package:hive_practice/model_class.dart';

class ShowDataScreen extends StatefulWidget {
  const ShowDataScreen({super.key});

  @override
  State<ShowDataScreen> createState() => _ShowDataScreenState();
}

class _ShowDataScreenState extends State<ShowDataScreen> {
  @override
  void dispose() {
    Hive.box('PersonBox').clear();
    //or
    //close all box
    // Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Data"),
        actions: [
          IconButton(
            onPressed: () {
              //delete all box
              Hive.box('PersonBox').clear();
            },
            icon: Icon(Icons.delete_forever),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CreateDataScreen()));
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: Hive.openBox('PersonBox'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final hiveBox = Hive.box('PersonBox');
              return ValueListenableBuilder(
                  valueListenable: hiveBox.listenable(),
                  builder: (context, Box box, child) {
                    if (box.isEmpty) {
                      return Center(
                        child: Text('Empty'),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: hiveBox.length,
                          itemBuilder: (context, index) {
                            final helper = hiveBox.getAt(index) as ModelClass;
                            return ListTile(
                              trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      useSafeArea: true,
                                      builder: (context) => AlertDialog(
                                            scrollable: true,
                                            title: Text('Delete'),
                                            content:
                                                Text("Do you want delete it ?"),
                                            actions: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.red),
                                                onPressed: () {
                                                  hiveBox.deleteAt(index);

                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Delete it",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Return"),
                                              ),
                                            ],
                                          ));
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              leading: IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => EditScreen(
                                            index: index,
                                            age: helper.age,
                                            name: helper.name,
                                            phone: helper.phone,
                                          )));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                              ),
                              title: Text(helper.name),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Phone : ${helper.phone.toString()}'),
                                  Text('Age : ${helper.age.toString()}'),
                                ],
                              ),
                            );
                          });
                    }
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
