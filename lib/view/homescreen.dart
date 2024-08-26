import 'package:flutter/material.dart';
import 'package:zoft_care/controller/repo/posts_repo.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title, required this.token});

  final String title;
  String token;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: PostRepo().getPost(10, widget.token),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData && snapshot.data?.postsData != null) {
              return ListView.builder(
                itemCount: snapshot.data!.postsData!.pageSize,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.blue,
                    child: Text(index.toString()),
                  );
                },
              );
            } else {
              return Text(snapshot.data?.error ?? "error");
            }
          },
        ),
      ),
    );
  }
}
