import 'package:flutter/material.dart';
import 'package:generate_order/repository/dbhelper.dart';



class GenerateItem extends StatefulWidget {
  const GenerateItem({super.key});

  @override
  State<GenerateItem> createState() => _GenerateItemState();
}

class _GenerateItemState extends State<GenerateItem> {
  
  TextEditingController _itemName=TextEditingController();
  TextEditingController _numberOfItems=TextEditingController();
  String itemName="";
  int itemnumbers=0;
  int itemid=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Details"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                autofocus: true,

                controller: _itemName,
                onChanged: (value) {
                  setState(() {
                    itemName=_itemName.text;
                    
                  });
                },
                decoration: InputDecoration(
                  label: Text("Item Name"),
                  hintText: "Item Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: _numberOfItems,
                onChanged: (value) {
                  itemnumbers =int.parse(_numberOfItems.text);
                  
                },
                decoration: InputDecoration(
                  label: Text("Number of Items"),
                  hintText: "Number of Items",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                    minWidth: 100,
                    onPressed: (() {
                      Navigator.pop(context);
                      _itemName.clear();
                      _numberOfItems.clear();
                      print(itemName);
                      //print(numberOfItems);
                    }),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Colors.red,
                  ),
                  MaterialButton(
                    minWidth: 100,
                    onPressed: (() async{
                     await DBhelper.insert (DatabaseModel(itemName,itemid,itemnumbers));
                      Navigator.pop(context);
                       _itemName.clear();
                      _numberOfItems.clear();
                      print(itemName);
                     // print(numberOfItems);
                      
                    }),
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Colors.green,
                  ),
                 
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
