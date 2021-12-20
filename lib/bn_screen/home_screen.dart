import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal/add_modal_screen.dart';
import 'package:modal/firebase/fb_firestore_controller.dart';
import 'package:modal/responsive/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


 List<String> _images = [
   "images/out_boarding_1.jpg",
   "images/out_boarding_2.jpg",
   "images/out_boarding_3.jpg",
   "images/p1.jpg",
   "images/p2.jpg",
   "images/p3.jpg",
   "images/p4.jpg",
   "images/p5.jpg",
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color _iconColor = Colors.black;

    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      children: [
        Text(
          AppLocalizations.of(context)!.modal,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 10),
        Text(
          AppLocalizations.of(context)!.job,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 10),
          SizedBox(
          height: 200,
          child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 7,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
          return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          ),
            child: Image.asset(_images[index],fit: BoxFit.fitHeight,),
          );
          },
          ),
          ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'أهم المنتجات',
              style: TextStyle(
                  color: Color(0XFF36596A), fontWeight: FontWeight.bold, fontSize: 20),
            ),
           /* Card(
              elevation:0,
              color: Colors.black12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  'المزيد',
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 18),
                ),
              ),
            ),*/

          ],
        ),
        SizedBox(height: 10),
        StreamBuilder<QuerySnapshot>(
          stream: FbFirestoreController().readProduct(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<QueryDocumentSnapshot> data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10, childAspectRatio: 157 / 190
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Stack(
                              children:[
                                Container(
                                  height: 100,
                                  width: 150,
                                  child: Image.network(
                                    data[index].get('imagePath'),
                                    fit: BoxFit.cover,

                                  ),
                                ),
                                Positioned(

                                  child:IconButton(
                                    icon: Icon(Icons.favorite_border,color: _iconColor),
                                    onPressed: (){
                                      setState(() {
                                        _iconColor = Colors.red;
                                      });
                                    },),
                                  top: 5,
                                  right: 5,
                                ),
                              ] ),
                          Text(
                            data[index].get('name'),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            data[index].get('price'),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            data[index].get('titleCategory'),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  },
                ),

              );

            }
            else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning, size: 85, color: Colors.grey.shade500),
                    Text(
                      'NO DATA',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              );
            }
          }
        ),


    ]
    );
  }


}
/*
*  StreamBuilder<QuerySnapshot>(
              stream: FbFirestoreController().readSlider(collection: 'Slider'),
            builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
            }
            else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<QueryDocumentSnapshot> data1 = snapshot.data!.docs;
              return GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:data1.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 10,
                        childAspectRatio: 100 / 133
                    ),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(data1[index].get('imagePathSlider')
                          ,fit: BoxFit.fitHeight,),
                      );
                    },

              );
            }
            else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning, size: 85, color: Colors.grey.shade500),
                    Text(
                      'NO DATA',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              );
            }

            },
          ),
          *
          *  FloatingActionButton(
                                    elevation: 0,
                                    mini: true,
                                    child:Image.asset("images/fav.png",
                                      width: 30,
                                      height: 30,),
                                    backgroundColor: Colors.white,
                                    onPressed: (){}
                                )
*  */