import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:provider/provider.dart';

import '../../Controller/Particulier/ParticulierController.dart';
import '../../Controller/global.dart';
import '../Profile/profileother.dart';

class ListFav extends StatefulWidget {
  const ListFav({super.key});
  static const tag = "/listFav";
  @override
  State<ListFav> createState() => _ListFavState();
}

class _ListFavState extends State<ListFav> {
  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<GlobalData>(context);
    final FavoriteArtisans =
        ParticulierController.getFavoriteArtisanOfParticulier(
            globalData.getId());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const BackButton(
            color: Colors.black,
          ),
          title: const Text(
            "Liste des favoris",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          toolbarHeight: 35,
          elevation: 0,
        ),
        body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
                padding: EdgeInsets.only(top: 30),
                height: 740,
                width: 220,
                child: listOfFavArtisan(FavoriteArtisans))
          ]),
        ]));
  }

  Widget listOfFavArtisan(artisans) {
    return FutureBuilder(
      future: artisans,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['results'] == null) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Aucun artisan trouvé")],
            ));
          }
          if (snapshot.data['results'].length >= 0) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data['results'].length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 120,
                    child: CardArtisan(index, snapshot.data['results'][index]),
                  );
                });
          } else {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Aucun Artisan")],
            ));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget CardArtisan(int index, data) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(ProfileOther.tag, arguments: data);
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
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(data['lastname'])),
                  Text(data['name']),
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        data['domaine'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: RatingOfProfile(double.parse(data['note']))),
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
