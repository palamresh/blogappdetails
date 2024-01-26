import 'package:blogapp/blogeample/components/utils.dart';
import 'package:blogapp/blogeample/screen/login_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'uploadimage.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final ref = FirebaseDatabase.instance.ref().child("Post");
  final auth = FirebaseAuth.instance;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UploadImage()));
                  },
                  icon: Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  )),
            ),
            IconButton(
                onPressed: () {
                  auth.signOut().then((value) {
                    Util().toastMessage('You are Logout');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }).onError((error, stackTrace) {
                    Util().toastMessage(error.toString());
                  });
                },
                icon: Icon(Icons.logout))
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Blog Pages"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search'),
              ),
              Expanded(
                  child: FirebaseAnimatedList(
                      physics: BouncingScrollPhysics(),
                      query: ref.child('Post List'),
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, index) {
                        final title = snapshot.child('ptitle').value.toString();
                        if (searchController.text.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage.assetNetwork(
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .25,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1,
                                        placeholder: 'lib/image/M.png',
                                        image: snapshot
                                            .child('pUrl')
                                            .value
                                            .toString()),
                                  ),
                                  Text(
                                    snapshot.child('ptitle').value.toString(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    snapshot
                                        .child('pdiscription')
                                        .value
                                        .toString(),
                                    style: TextStyle(fontSize: 17),
                                  )
                                ],
                              ),
                            ),
                          );
                        } else if (title.toString().contains(
                            searchController.text.toString().toLowerCase())) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage.assetNetwork(
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .25,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1,
                                        placeholder: 'lib/image/M.png',
                                        image: snapshot
                                            .child('pUrl')
                                            .value
                                            .toString()),
                                  ),
                                  Text(
                                    snapshot.child('ptitle').value.toString(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    snapshot
                                        .child('pdiscription')
                                        .value
                                        .toString(),
                                    style: TextStyle(fontSize: 17),
                                  )
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
