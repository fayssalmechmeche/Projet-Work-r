import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:my_app/Controller/global.dart';
import 'package:my_app/view/Works/ListWork.dart';
import 'package:provider/provider.dart';
import '../../Controller/global.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required String title}) : super(key: key);
  static const tag = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<GlobalData>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.logout,
            color: Colors.red,
          ),
        ),
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        toolbarHeight: 35,
        elevation: 0,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Bienvenue ${globalData.getName()}",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.75),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                      icon: const Icon(Icons.star, size: 20),
                      onPressed: () {})),
              if (globalData.getRole() == 0)
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.75),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.home_repair_service_sharp, size: 20),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListWork(),
                        ),
                      );
                    },
                  ),
                ),
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.75),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                      icon: const Icon(Icons.favorite, size: 20),
                      onPressed: () {})),
            ]),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "Les artisans du moment",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
              height: 30,
            ),
            Container(
                height: 115,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 195,
                          child: CardChat(index),
                        ),
                      ],
                    );
                  },
                )),
            const Divider(
              color: Colors.black,
              thickness: 1,
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Les nouveaux artisans",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
              height: 30,
            ),
            Container(
                height: 115,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 195,
                          child: CardChat(index),
                        ),
                      ],
                    );
                  },
                )),
            const Divider(
              color: Colors.black,
              thickness: 1,
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Vos artisans favoris",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
              height: 30,
            ),
            Container(
                height: 115,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 195,
                          child: CardChat(index),
                        ),
                      ],
                    );
                  },
                ))
          ]),
    );
  }

  Widget CardChat(int index) {
    return GestureDetector(
        onTap: () {
          const snackBar = SnackBar(
            content: Text('Page message have been lunched'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Card(
            shape: RoundedRectangleBorder(
              //<-- 3. SEE HERE
              side: const BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(40.0),
            ),
            elevation: 0,
            color: Colors.yellow.withOpacity(0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text("Phillipe")),
                  const Text("Robert"),
                  const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Plombier",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: RatingOfProfile(0.9)),
                ]),
              ],
            )));
  }

  Widget RatingOfProfile(double rating) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      DecoratedIcon(
        icon: Icon(
          rating > 0 && rating < 1 ? Icons.star_half : Icons.star,
          color: rating > 0 ? Colors.yellow : Colors.black,
          size: 16,
        ),
        decoration:
            IconDecoration(border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 1.0 && rating < 2.0 ? Icons.star_half : Icons.star,
          color: rating > 1 ? Colors.yellow : Colors.black,
          size: 16,
        ),
        decoration:
            IconDecoration(border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 2.0 && rating < 3.0 ? Icons.star_half : Icons.star,
          color: rating > 2 ? Colors.yellow : Colors.black,
          size: 16,
        ),
        decoration:
            IconDecoration(border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 3.0 && rating < 4.0 ? Icons.star_half : Icons.star,
          color: rating > 3 ? Colors.yellow : Colors.black,
          size: 16,
        ),
        decoration:
            IconDecoration(border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 4.0 && rating < 5.0 ? Icons.star_half : Icons.star,
          color: rating > 4 ? Colors.yellow : Colors.black,
          size: 16,
        ),
        decoration:
            IconDecoration(border: IconBorder(color: Colors.black, width: 2)),
      ),
    ]);
  }
}
