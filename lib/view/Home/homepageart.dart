import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:icon_decoration/icon_decoration.dart';

import '../Works/listworkartisan.dart';

class HomePageArt extends StatefulWidget {
  const HomePageArt({super.key});
  static const tag = "/HomePageArt";
  @override
  State<HomePageArt> createState() => _HomePageArtState();
}

class _HomePageArtState extends State<HomePageArt> {
  @override
  Widget build(BuildContext context) {
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
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(padding: EdgeInsets.only(top: 20), child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              
            
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.yellow.withOpacity(0.5),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: Colors.black)
                ),
                child: IconButton(
                  icon: const Icon(Icons.home_repair_service_sharp, size: 20),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListWorkArtisan(),
                      ),
                    );
                  },
                ),
              ),
            
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.yellow.withOpacity(0.5),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: Colors.black)
                ),
                child: IconButton(
                  icon: const Icon(Icons.favorite, size: 20),
                  onPressed: () {
                  },
                ),
              ),
               ])),
          Container(padding: EdgeInsets.only(top: 20),width: 330,child: 
              Card(
                        shape: RoundedRectangleBorder(
                          //<-- 3. SEE HERE
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 0,
                        color: Colors.yellow.withOpacity(0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                               
                                height: 85,
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text('Nombre de Clients',
                                            style: TextStyle(fontSize: 18))),
                                    Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text('20',
                                            style: TextStyle(fontSize: 28)))
                                  ],
                                ))
                          ],
                        ))),
          Container(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    Card(
                        shape: RoundedRectangleBorder(
                          //<-- 3. SEE HERE
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 0,
                        color: Colors.yellow.withOpacity(0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                           Container(
                                width: 165,
                                height: 145,
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Text('Chantiers en cours',
                                            style: TextStyle(fontSize: 15))),
                                    Padding(
                                        padding: EdgeInsets.only(top: 25),
                                        child: Text('5',
                                            style: TextStyle(fontSize: 38))),
                                    
                                  ],
                                ))
                          ],
                        )),
                    Card(
                        shape: RoundedRectangleBorder(
                          //<-- 3. SEE HERE
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 0,
                        color: Colors.yellow.withOpacity(0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                width: 165,
                                height: 145,
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Text('Chantiers terminés',
                                            style: TextStyle(fontSize: 15))),
                                    Padding(
                                        padding: EdgeInsets.only(top: 25),
                                        child: Text('5',
                                            style: TextStyle(fontSize: 38))),
                                    
                                  ],
                                ))
                          ],
                        ))
                  ]),
                  Column(children: [
                    Card(
                        shape: RoundedRectangleBorder(
                          //<-- 3. SEE HERE
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 0,
                        color: Colors.yellow.withOpacity(0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                               width: 165,
                                height: 145,
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Text(' Devis acceptés  ',
                                            style: TextStyle(fontSize: 15))),
                                    Padding(
                                        padding: EdgeInsets.only(top: 25),
                                        child: Text('5',
                                            style: TextStyle(fontSize: 38))),
                                    
                                  ],
                                ))
                          ],
                        )),
                    Card(
                        shape: RoundedRectangleBorder(
                          //<-- 3. SEE HERE
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 0,
                        color: Colors.yellow.withOpacity(0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                width: 165,
                                height: 145,
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Text(' Devis refusés  ',
                                            style: TextStyle(fontSize: 15))),
                                    Padding(
                                        padding: EdgeInsets.only(top: 25),
                                        child: Text('50',
                                            style: TextStyle(fontSize: 38))),
                                    
                                  ],
                                ))
                          ],
                        ))
                  ]),
                ],
              )),
              Container(padding: EdgeInsets.only(top: 20),width: 330,child: 
              Card(
                        shape: RoundedRectangleBorder(
                          //<-- 3. SEE HERE
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 0,
                        color: Colors.yellow.withOpacity(0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                               
                                height: 105,
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text('Ma note',
                                            style: TextStyle(fontSize: 18))),
                                    Container(
                                        padding: EdgeInsets.only(top: 10),
                                        child: RatingOfProfile(3.5)),
                                    Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text('3.5 / 5',
                                            style: TextStyle(fontSize: 20)))
                                  ],
                                ))
                          ],
                        )))
        ]));
  }
  Widget RatingOfProfile(double rating) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      DecoratedIcon(
        icon: Icon(
          rating > 0 && rating < 1 ? Icons.star_half : Icons.star,
          color: rating > 0 ? Colors.yellow : Colors.black,
          size: 25,
        ),
        decoration:
            IconDecoration(border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 1.0 && rating < 2.0 ? Icons.star_half : Icons.star,
          color: rating > 1 ? Colors.yellow : Colors.black,
          size: 25,
        ),
        decoration:
            IconDecoration(border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 2.0 && rating < 3.0 ? Icons.star_half : Icons.star,
          color: rating > 2 ? Colors.yellow : Colors.black,
          size: 25,
        ),
        decoration:
            IconDecoration(border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 3.0 && rating < 4.0 ? Icons.star_half : Icons.star,
          color: rating > 3 ? Colors.yellow : Colors.black,
          size: 25,
        ),
        decoration:
            IconDecoration(border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 4.0 && rating < 5.0 ? Icons.star_half : Icons.star,
          color: rating > 4 ? Colors.yellow : Colors.black,
          size: 25,
        ),
        decoration:
            IconDecoration(border: IconBorder(color: Colors.black, width: 2)),
      ),
    ]);
  }
}
