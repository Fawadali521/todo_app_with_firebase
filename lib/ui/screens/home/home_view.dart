import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import 'package:todo/core/utils/constant/kColors.dart';
import 'home_view_model.dart';

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
              title: const Text("Home"),
              actions: [
                IconButton(
                    onPressed: () {
                      model.logOut(context);
                    },
                    icon: const Icon(Icons.logout_outlined))
              ],
            ),
            //
            ///body section start
            //
            body: Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.teal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  //
                  //user name
                  //
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kColors.whiteColor,
                    ),
                    height: 80,
                    child: Center(
                      child: model.userName == null
                          ? const CircularProgressIndicator()
                          : Text(
                              "Hello ${model.userName}",
                              style: const TextStyle(fontSize: 30),
                            ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  //
                  // show time
                  //
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kColors.whiteColor,
                    ),
                    height: 80,
                    child: Center(
                      child: Text(
                        'Good ${model.label()}',
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  //
                  // show todos
                  //
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
                                            style: const TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                    leading: Checkbox(
                                      value: documentSnapshot['status'],
                                      onChanged: (value) {
                                        model.updateStatus(
                                            documentSnapshot, value!);
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
                  //
                  //add todos
                  //
                  Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: TextField(
                        controller: model.todoController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          hintText: 'add todo',
                          hintStyle: TextStyle(
                            color: kColors.mainColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      trailing: SizedBox(
                        width: 100.w,
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
