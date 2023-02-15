import 'package:flutter/material.dart';
import 'package:my_app/view/Works/workfollow.dart';
import 'addwork.dart';

class ListWork extends StatefulWidget {
  const ListWork({Key? key}) : super(key: key);

  @override
  State<ListWork> createState() => _ListWorkState();
}

class _ListWorkState extends State<ListWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const BackButton(
            color: Colors.black,
          ),
          title: Text(
            "Mes chantiers",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          toolbarHeight: 35,
          elevation: 0,
        ),
        body:  Column( mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Visibility(
                visible:true,
                child: SizedBox(height: 50, width: 350, child: addWork(),),
              ),
              ListTest()
            ])
    );
  }
  Widget addWork(){
    return  GestureDetector(
        onTap: () {
      Navigator.of(context).pushNamed(AddWork.tag);
      const snackBar = SnackBar(
        content: Text('Works page have been lunched'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    },
    child:Card(
        shape:  const StadiumBorder( //<-- 3. SEE HERE
          side: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        elevation: 10,
        color: Colors.white,
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:  <Widget> [
            Container( padding: const EdgeInsets.only(left:45), child:
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  const [
                  Padding(padding: EdgeInsets.all(5), child: Text("Créer un nouveau chantier"))
                ]
            ),
            ),
            Container(
                padding: const EdgeInsets.only(left: 70),
                height: 50,
                width: 50,
                child: const Icon(Icons.add))
          ],
        )
    )
    );
  }
  Widget ListTest(){
    return Expanded(
        child: SizedBox(
            height: 200.0,
            child: ListView.builder(
              itemCount:  10,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100, width: 350, child: CardChat(index),),
                  ],
                );
              },)
        )
    );

  }
  Widget CardChat(int index){
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
              children:  <Widget> [
                Padding(padding: const EdgeInsets.only(left:20), child:
                Container(
                  width: 20.0,
                  height: 20.0,
                  decoration:  const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                ),
                Container( padding: const EdgeInsets.only(left:25), child:
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  const [
                        Padding(padding: EdgeInsets.all(5), child: Text("Nom du Chantier",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
                        Padding(padding: EdgeInsets.only(left:5,right: 2,top: 2,bottom: 2), child: Text("Plomberie")),
                        Padding(padding: EdgeInsets.all(5), child: Text("Achevé le 10/12/2022"))
                      ]
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 70),
                    height: 50,
                    width: 50,
                    child: const Icon(Icons.arrow_forward_ios))
              ],
            )));
  }
}
