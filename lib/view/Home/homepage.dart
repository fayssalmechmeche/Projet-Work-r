import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';
import 'package:my_app/Controller/Particulier/ParticulierController.dart';
import 'package:my_app/Controller/global.dart';
import 'package:my_app/view/Home/listfav.dart';
import 'package:my_app/view/Home/search.dart';
import 'package:my_app/view/Login/selectionPage.dart';

import 'package:my_app/view/Profile/profileother.dart';

import 'package:provider/provider.dart';

// socket.Io
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../Controller/Note/NoteController.dart';
import '../LunchPage/firstpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const tag = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

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
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
  return const FirstPage(title: '',);
}), (r){
  return false;
});
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
                          Navigator.of(context)
                              .pushNamed(ListFav.tag)
                              .then((_) => setState(() {}));
                        })),
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.75),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                      icon: const Icon(Icons.search, size: 20),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(Search.tag)
                            .then((_) => setState(() {}));
                      })),
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
              children: [Text("Aucun artisan")],
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
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: Container(
                      width: 20.0, height: 20.0, child: statusIcon(data)),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 100,
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        data['lastname'],
                        overflow: TextOverflow.ellipsis,
                      )),
                  Container(
                    width: 100,
                    child: Text(
                      data['name'],
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        data['domaine'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
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
                                padding: const EdgeInsets.only(top: 10),
                                child: RatingOfProfile(note));
                          } else if (snapshot.hasError) {
                            return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: RatingOfProfile(0));
                          } else {
                            return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: RatingOfProfile(0));
                          }
                        } else {
                          return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: RatingOfProfile(
                                  0)); // or any other widget to show progress
                        }
                      })
                ]),
              ],
            )));
  }

  Widget statusIcon(data) {
    if (data['domaine'] == 'Plomberie') {
      return Icon(
        Icons.water_drop,
      );
    } else if (data['domaine'] == 'Maçonnerie') {
      return Icon(
        Icons.handyman,
      );
    } else {
      return Icon(
        Icons.flash_on,
      );
    }
  }

  Widget RatingOfProfile(double rating) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      DecoratedIcon(
        icon: Icon(
          rating > 0 && rating < 1 ? Icons.star_half : Icons.star,
          color: rating > 0 ? Color.fromARGB(255, 242, 210, 2) : Colors.black,
          size: 16,
        ),
        decoration:
            IconDecoration(border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 1.0 && rating < 2.0 ? Icons.star_half : Icons.star,
          color: rating > 1 ? Color.fromARGB(255, 242, 210, 2) : Colors.black,
          size: 16,
        ),
        decoration:
            IconDecoration(border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 2.0 && rating < 3.0 ? Icons.star_half : Icons.star,
          color: rating > 2 ? Color.fromARGB(255, 242, 210, 2) : Colors.black,
          size: 16,
        ),
        decoration:
            IconDecoration(border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 3.0 && rating < 4.0 ? Icons.star_half : Icons.star,
          color: rating > 3 ? Color.fromARGB(255, 242, 210, 2) : Colors.black,
          size: 16,
        ),
        decoration:
            IconDecoration(border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 4.0 && rating < 5.0 ? Icons.star_half : Icons.star,
          color: rating > 4 ? Color.fromARGB(255, 242, 210, 2) : Colors.black,
          size: 16,
        ),
        decoration:
            IconDecoration(border: IconBorder(color: Colors.black, width: 2)),
      ),
    ]);
  }
}
