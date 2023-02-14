import 'package:flutter/material.dart';
import 'package:my_app/view/Works/workfollow.dart';

class ListWork extends StatefulWidget {
  const ListWork({Key? key}) : super(key: key);

  @override
  State<ListWork> createState() => _ListWorkState();
}

class _ListWorkState extends State<ListWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Text(
          "Mes chantiers",
          style: TextStyle(fontSize: 18),
        ),
      ),
      Expanded(
          child: SizedBox(
              height: 200.0,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 350,
                        child: CardChat(index),
                      ),
                    ],
                  );
                },
              )))
    ]));
  }

  Widget CardChat(int index) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(WorkFollow.tag);
          const snackBar = SnackBar(
            content: Text('Works page have been lunched'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Card(
            shape: StadiumBorder(
              //<-- 3. SEE HERE
              side: BorderSide(
                color: Colors.black,
                width: index % 2 == 0 ? 1.0 : 0.0,
              ),
            ),
            elevation: 10,
            color: index % 2 == 0 ? Colors.white : Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 40),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Text("Plombier")),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Text("10/12/2022"))
                      ]),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 150),
                    height: 50,
                    width: 50,
                    child: const Icon(Icons.arrow_forward))
              ],
            )));
  }
}
