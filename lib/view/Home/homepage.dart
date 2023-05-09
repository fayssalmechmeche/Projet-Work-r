import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';
import 'package:my_app/Controller/Particulier/ParticulierController.dart';
import 'package:my_app/Controller/global.dart';
import 'package:my_app/view/Home/listfav.dart';
import 'package:my_app/view/Home/search.dart';
import 'package:my_app/view/Home/homepageart.dart';
import 'package:my_app/view/Profile/profileother.dart';
import 'package:my_app/view/Works/ListWork.dart';
import 'package:my_app/view/Works/listworkartisan.dart';
import 'package:provider/provider.dart';
import '../../Controller/global.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const tag = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<GlobalData>(context);
    final allArtisan = ArtisanController.getAllArtisan();
    final recentArtisan = ArtisanController.getRecentArtisan();
    final FavoriteArtisans =
        ParticulierController.getFavoriteArtisanOfParticulier(
            globalData.getId());

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
              if (globalData.getRole() == 1)
                Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.75),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                        icon: const Icon(Icons.star, size: 20),
                        onPressed: () {
                          Navigator.of(context).pushNamed(ListFav.tag);
                        })),
                Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.75),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                        icon: const Icon(Icons.search, size: 20),
                        onPressed: () { Navigator.of(context).pushNamed(Search.tag);})),
           
           
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
            Container(height: 115, child: ArtisanList(allArtisan)),
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
            Container(height: 115, child: ArtisanList(recentArtisan)),
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
            Container(height: 115, child: ArtisanList(FavoriteArtisans))
          ]),
    );
  }

  Widget ArtisanList(artisans) {
    return FutureBuilder(
      future: artisans,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['results'] == null) {
            print(snapshot.data);
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Aucun artisan trouvé")],
            ));
          }
          if (snapshot.data['results'].length >= 0) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data['results'].length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 195,
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
