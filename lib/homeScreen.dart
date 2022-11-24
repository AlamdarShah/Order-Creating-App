import 'package:flutter/material.dart';
import 'package:generate_order/displayItem.dart';
import 'package:generate_order/repository/dbhelper.dart';
import 'generateItem.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
   String itemName="";
   int itemnumber=0;
  @override
  List databaseItems=[];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generate Item"),
        centerTitle: true,
      ),
      body: Center(
        // ignore: unnecessary_new
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>GenerateItem()));
              },
              child: Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.green,),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Create Order",textAlign: TextAlign.center,style: TextStyle(fontSize: 26,color: Colors.white),),
                ),
              ),
            ),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: () async{
                // print(databaseItems);
               Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayItem()));
              },
              child: Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.purple,),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Get Data",textAlign: TextAlign.center,style: TextStyle(fontSize: 26,color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  
  }
}
