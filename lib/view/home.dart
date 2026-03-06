import 'package:flutter/material.dart';
import 'package:mytownmysymptom/config.dart';
import 'package:mytownmysymptom/model/hospital.dart';
import 'package:mytownmysymptom/view/google_map.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var test = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try{
      test = await hospitalHandler.queryK({"name":"서울대학교치과병원"});

      setState(() {
        
      });
    }catch(err){
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("1st Page"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(Hospital.keys.join(", ")),
            test.length>0 ? Text('${test[0].name}') : Text(''),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) {
                      return Gmap();
                    }
                ));
                

              }, 
              child: Text('병원찾기')
            )
          ],
        ),
      ),
    );
  }
}