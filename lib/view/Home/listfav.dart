import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:provider/provider.dart';

import '../../Controller/Note/NoteController.dart';
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
                width: 360,
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
    final allNote = NoteController.getNoteByArtisan(data['_id']);
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProfileOther.tag, arguments: data)
              .then((_) => setState(() {}));
        },
        child: Card(
            elevation: 2,
            child: Column(children: [
              ListTile(
               
    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  title: Text(data['name'] + " " + data['lastname']),
                subtitle: Text(data['domaine']),
                
              ),
              FutureBuilder(
                  future: allNote,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        var results = snapshot.data?['results'];
                        late double note;

                        if (results != null && results.isNotEmpty) {
                          double total = 0;
                          results.forEach((item) {
                            total = total + item['note'];
                          });
                          note = total / results.length;
                        } else {
                          note = 0;
                        }

                        return Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: RatingOfProfile(note));
                      } else if (snapshot.hasError) {
                        return Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: RatingOfProfile(0));
                      } else {
                        return Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: RatingOfProfile(0));
                      }
                    } else {
                      return Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: RatingOfProfile(
                              0)); // or any other widget to show progress
                    }
                  })
            ])));
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
