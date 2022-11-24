import 'package:flutter/material.dart';
import 'package:generate_order/repository/dbhelper.dart';
import 'generateItem.dart';

class DisplayItem extends StatefulWidget {
 DisplayItem();
  @override
  State<DisplayItem> createState() => _DisplayItemState();
}

class _DisplayItemState extends State<DisplayItem> {
List databaseItems=[];
updateList()async{
List   tdatabaseItems=await DBhelper.readData();
  setState(() {

databaseItems=[];   
if(tdatabaseItems.isNotEmpty){

   tdatabaseItems.forEach((element){
DatabaseModel databaseModel=DatabaseModel('',0,0);
databaseModel.name=element['name'];
databaseModel.number=element['number'];
databaseModel.id=element['id'];
databaseItems.add(databaseModel);
});
}            
  
  });
}

@override
  void initState() {
 setState(() {
updateList();
 });  
    // TODO: implement initState

    super.initState();
  }
  TextEditingController _name=TextEditingController();
  TextEditingController _number=TextEditingController();
  String itemName="";
  int itemnumbers=0;
  _showEditDetials(BuildContext context,DatabaseModel databaseModel){
    setState(() {
      
_name.text=databaseModel.name.toString();
_number.text=databaseModel.number.toString();
 itemName=_name.text;
 itemnumbers=int.parse(_number.text);
   
    }); return showDialog(context: context,
    barrierDismissible: true,
     builder:(param){
      return AlertDialog(
        title: Text("Edit Your Order",textAlign: TextAlign.center,),
        content: SingleChildScrollView(
          child: Column(
                children: [
                  TextField(
                    autofocus: true,
                    //keyboardType: TextInputType.number,
                    controller: _name,
                    
                    onChanged: (value) {
                      setState(() {
                        itemName = _name.text;
                        
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "item name", labelText: "item name"),
                  ),
                  TextField(
                     controller: _number,
                     keyboardType: TextInputType.number,
                     onChanged: (value) {
                       setState(() {
                         itemnumbers =int.parse( _number.text);
                         
                       });
                     },
                    decoration: InputDecoration(
                        hintText: "Number of Items", labelText: "Number of Items"),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                     MaterialButton(
                    onPressed: (()async {
                      databaseModel.name=itemName;
                      databaseModel.number=itemnumbers;
                  await DBhelper.updateData(databaseModel);
  
await             updateList();
_name.clear();
_number.clear();

                      Navigator.pop(context);}),
                    child: Text("Save"),
                    color: Colors.green,
                  ),
                 
                    
                  
                  ],
                 )
                ],
              ),
        ),
      ); 
     });
  }
 
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(title: Text('Display Item')),
      body: ListView.builder(
        itemCount: databaseItems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.green,
                  child: IconButton(onPressed:()async {
       await            _showEditDetials(context,databaseItems[index],);
                }, icon: Icon(Icons.edit_outlined,size: 30,color: Colors.white,),),
                ),
                title: Text(databaseItems[index].name,
                ),
                subtitle: Text("Number of Items is:${databaseItems[index].number}"),
                trailing: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.red,
                  child: IconButton(onPressed:()async {
                  await DBhelper.deleteData(databaseItems[index]);
      await                 updateList();  
                 }, icon: Icon(Icons.delete_outline,size: 30,color: Colors.white,),),
                ),
              ),
            ),
          )
          ;
        },
        ),
    );

   }
}