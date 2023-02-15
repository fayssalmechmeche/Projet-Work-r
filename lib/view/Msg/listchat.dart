import 'package:flutter/material.dart';
import 'package:my_app/view/Msg/chat.dart';
class ListChat extends StatefulWidget {
  const ListChat({Key? key}) : super(key: key);

  @override
  State<ListChat> createState() => _ListChatState();
}

class _ListChatState extends State<ListChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(
          "Mes conversations",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        toolbarHeight: 35,
        elevation: 0,
      ),
      body:  Column( mainAxisAlignment: MainAxisAlignment.start,
          children: [
        Expanded(
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
        )
      ])
    );
  }

  Widget CardChat(int index){
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(Chat.tag);
          const snackBar = SnackBar(
            content: Text('Page message have been lunched'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child:
            Card(
                shape: StadiumBorder( //<-- 3. SEE HERE
                  side: BorderSide(
                    color: Colors.black,
                    width: index %2 == 0? 1.0 : 0.0,
                    ),
                ),
                elevation: 10,
                color: index %2 == 0? Colors.white: Colors.grey,
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  <Widget> [
                Padding(padding: const EdgeInsets.only(left:20,right: 20), child:
                    Container(
                      width: 20.0,
                      height: 20.0,
                      decoration:  const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  const [
                        Padding(padding: EdgeInsets.all(10), child: Text("Plombier")),
                          Padding(padding: EdgeInsets.all(10), child: Text("Phillipe"))
                     ]
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 150),
                        height: 50,
                        width: 50,
                        child: Icon(Icons.arrow_forward_ios))
                  ],
                )
            )
    );
  }
}
