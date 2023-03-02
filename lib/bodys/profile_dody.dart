import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

// ignore: use_key_in_widget_constructors
class ProfileBody extends StatefulWidget {
  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance
      .collection('user')
      .where('associcateID')
      .snapshots();
  
  

  @override
  Widget build(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          // ignore: prefer_const_constructors
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          // ignore: prefer_const_constructors
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
               children: [
                
               // ignore: prefer_const_constructor
                Center(
                  child: Column(
                    children: [
                      // ignore: prefer_const_constructors
                      Padding(padding:EdgeInsets.only(bottom: 30)),
                      // ignore: prefer_const_constructors
                      WidgetText(text: 'User Login'),
                      // ignore: prefer_const_constructors
                      Padding(padding: EdgeInsets.only(bottom: 20)),
                      WidgetText(text: 'Assosicate ID : ${data['associcateID']}'),
                      WidgetText(text: 'UserName : ${data['name']}'),
                      WidgetText(text: 'LastName : ${data['lastname']}'),
                    ],
                  ),
                ),
                

                
               ],
              ),
            );
          }).toList(),
        );
      },
    );
   
  }
}
