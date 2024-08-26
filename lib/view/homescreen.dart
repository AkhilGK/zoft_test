import 'package:flutter/material.dart';
import 'package:zoft_care/controller/repo/auth_repo.dart';
import 'package:zoft_care/controller/repo/posts_repo.dart';
import 'package:zoft_care/view/error_widget.dart';
import 'package:zoft_care/view/login_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;
  //String token;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () => showAlertDialog(context),
              icon: const Icon(Icons.logout))
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: PostRepo().getPost(
              10,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasData && snapshot.data?.postsData != null) {
                return ListView.builder(
                  itemCount: snapshot.data!.postsData!.pageSize,
                  itemBuilder: (context, index) {
                    final item = snapshot.data!.postsData!.data![index];
                    return Container(
                      // height: 250,

                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color.fromARGB(255, 252, 236, 241)),

                      child: Column(
                        children: [
                          Text(
                            item.title ?? "Title",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Container(
                              height: 250,
                              decoration: const BoxDecoration(
                                  // color: Colors.blue,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://images.pexels.com/photos/307008/pexels-photo-307008.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" ??
                                              '')))),
                          Text(item.body ?? "...")
                        ],
                      ),
                    );
                  },
                );
              } else {
                return ErrorWidgets(
                    errorMessage: (snapshot.error ??
                            snapshot.data?.error ??
                            "Error getting data")
                        .toString());
              }
            },
          ),
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log out'),
          content: const Text('This is the content of the alert dialog.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Log Out'),
              onPressed: () {
                AuthRepo().logout();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
