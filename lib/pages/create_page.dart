import 'package:flutter/material.dart';

import '../model/post-model.dart';
import '../services/auth_service.dart';
import '../services/rtdb_service.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  var isLoading = false;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var contentController = TextEditingController();
  var dateController = TextEditingController();

  _createPost() {
    String firstName = firstNameController.text.toString();
    String lastName = lastNameController.text.toString();
    String content = contentController.text.toString();
    String date = dateController.text.toString();
    if (firstName.isEmpty || lastName.isEmpty || content.isEmpty || date.isEmpty) return;

    _apiCreatePost(firstName, lastName, content, date);
  }

  _apiCreatePost(String firstName, String lastName, String content, String date,) {
    setState(() {
      isLoading = true;
    });
    var post =
    Post(firstName: firstName, lastName: lastName, content: content, date: date, userId: AuthService.currentUserId());
    RTDBService.addPost(post).then((value) => {
      _resAddPost(),
    });
  }

  _resAddPost() {
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop({'data': 'done'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Add Post"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                //#first name
                TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(hintText: "First Name"),
                ),
                const SizedBox(
                  height: 10,
                ),

                //#last name
                TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(hintText: "Last Name"),
                ),
                const SizedBox(
                  height: 10,
                ),

                //#content
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(hintText: "Content"),
                ),
                const SizedBox(
                  height: 10,
                ),

                //#date
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(hintText: "Date"),
                ),
                const SizedBox(
                  height: 10,
                ),


                MaterialButton(
                  onPressed: () {
                    _createPost();
                  },
                  //color: Colors.blue,
                  child: Container(
                    height: 50,
                    //padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Center(
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            isLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}