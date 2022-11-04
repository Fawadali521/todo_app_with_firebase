import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/utils/constant/kColors.dart';

import 'home_view_model.dart';
import 'package:todo/core/utils/constant/kColors.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

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
              actions: [
                IconButton(
                    onPressed: () {
                      model.logOut(context);
                    },
                    icon: Icon(Icons.logout_outlined))
              ],
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
                  //user name
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kColors.whiteColor,
                    ),
                    height: 80,
                    child: Center(
                      child: model.userName == null
                          ? CircularProgressIndicator()
                          : Text(
                              "Hello ${model.userName}",
                              style: TextStyle(fontSize: 30),
                            ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // good time
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kColors.whiteColor,
                    ),
                    height: 80,
                    child: Center(
                      child: Text(
                        'Good ${model.label()}',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // todos
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: model.stream().snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.hasData) {
                          return ListView.builder(
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];
                              return Dismissible(
                                key: UniqueKey(),
                                onDismissed: (DismissDirection direction) {
                                  model.delete(documentSnapshot.id, context);
                                },
                                child: Card(
                                  margin: const EdgeInsets.all(10),
                                  child: ListTile(
                                    title: documentSnapshot['status'] == false
                                        ? Text(documentSnapshot['todo'])
                                        : Text(
                                            documentSnapshot['todo'],
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                    leading: Checkbox(
                                      value: documentSnapshot['status'],
                                      onChanged: (Value) {
                                        model.updateStatus(
                                            documentSnapshot, Value!);
                                      },
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () => model.update(
                                          documentSnapshot, context),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }

                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
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
                                  model.createTodo(context);
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
