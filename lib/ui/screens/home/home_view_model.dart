import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:todo/ui/screens/login/login_view.dart';
import 'package:todo/core/utils/constant/kColors.dart';
import '../../../core/utils/package_utils.dart';

class HomeViewModel with ChangeNotifier {
  List todo = ["first day", 'second day'];
  final TextEditingController todoController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;
  String? labelString;
  String? userName;
  bool status = false;
  //
  //constructor for user name
  //
  HomeViewModel() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        userName = documentSnapshot.get("userName");
        notifyListeners();
      } else {
        Utils().toastMessage('User Name does Not Exist', kColors.redColor);
      }
    });
  }

  //
  //label time
  //
  String label() {
    int currentTime = DateTime.now().hour;
    if (currentTime > 5 && currentTime <= 12) {
      return labelString = 'Morning';
    } else if (currentTime > 12 && currentTime <= 17) {
      return labelString = 'Afternoon';
    } else {
      return labelString = 'Evening';
    }
  }

//
  //logout method
  //
  void logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.of(context).pushReplacementNamed(LoginView.routeName);
  }

  //
  //initialized  firebase path
  //
  stream() {
    final CollectionReference users = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('todos');
    return users;
  }

  //
  //create todos
  //
  Future<void> createTodo(BuildContext context) async {
    String todo = todoController.text.trim();

    if (todo == '') {
      Utils().toastMessage('Please Fill Todo', kColors.redColor);
    } else {
      try {
        await stream().add({"todo": todo, "status": status});
        Utils()
            .toastMessage('You have successfully add todo', kColors.blueColor);
      } on FirebaseAuthException catch (error) {
        Utils().toastMessage(error.code.toString(), kColors.redColor);
      }
    }
    todoController.text = '';
  }

//
  //update todos
  //
  Future<void> update(
      DocumentSnapshot? documentSnapshot, BuildContext context) async {
    String todo = todoController.text.trim();
    if (documentSnapshot != null) {
      todo = documentSnapshot['todo'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: todoController,
                  decoration: const InputDecoration(labelText: 'Update Todo'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    child: const Text('Update'),
                    onPressed: () async {
                      final String todo = todoController.text.trim();
                      if (todo != null) {
                        await stream()
                            .doc(documentSnapshot!.id)
                            .update({"todo": todo});
                        todoController.text = '';

                        Navigator.of(context).pop();
                      }
                    },
                  ),
                )
              ],
            ),
          );
        });
  }

//
  // update status of todo
  //
  Future<void> updateStatus(
      DocumentSnapshot? documentSnapshot, bool value) async {
    await stream().doc(documentSnapshot!.id).update({"status": value});
  }

//
  ///delete todo
  ///
  Future<void> delete(String todoId, BuildContext context) async {
    await stream().doc(todoId).delete();
    Utils().toastMessage(
        'You have successfully deleted a todo', kColors.blueColor);
  }
}
