import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/utils/constant/kColors.dart';
import 'package:todo/ui/custom_widgets/custom_textformfield.dart';

import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  static const routeName = '/home-page';
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Home"),
            ),
            body: Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.teal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Container(
                      height: 80,
                      color: kColors.whiteColor,
                      child: Center(
                        child: Text(
                          "Hello user",
                          style: TextStyle(fontSize: 30),
                        ),
                      )),
                  SizedBox(height: 10),
                  Container(
                    height: 80,
                    color: kColors.whiteColor,
                    child: Center(
                      child: Text(
                        'Good ${model.label()}',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: model.todo.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(model.todo[index]),
                            onDismissed: (DismissDirection direction) {
                              setState(() {
                                model.todo.removeAt(index);
                              });
                            },
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              child: ListTile(
                                title: Text(model.todo[index]),
                                trailing: SizedBox(
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {}),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: TextField(
                        controller: model.todoController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              top: 15), // add padding to adjust text
                          isDense: true,
                          hintText: 'add todo',
                          hintStyle: TextStyle(
                            color: kColors.mainColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    model.label();
                                    model.todo.add(
                                        model.todoController.text.toString());
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
