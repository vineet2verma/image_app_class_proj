import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List imgdata = [];
  List<String> imgUrllist = [];
  String imgurl =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoc34INutHnIKf96UaLX7UfhmON1r8GI9JqQ&usqp=CAU";
  String apiurl =
      'https://api.unsplash.com/photos/?client_id=HVhQ89efD2rYGR-vV5o_51v_CIoP480zCyzYUl0iyUk';

  getData() async {
    http.Response response = await http.get(Uri.parse(apiurl));
    imgdata = json.decode(response.body);
    getUrl();
  }

  getUrl() {
    for (int i = 0; i < imgdata.length; i++) {
      imgUrllist.add(imgdata.elementAt(i)['urls']['regular']);
      print("${i}   ${imgUrllist[i]}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),

            /// 1st text box for search
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, bottom: 8, top: 8, right: 8),
              child: Container(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Find Wallpaper",
                    suffixIcon: Icon(
                      Icons.search_sharp,
                      size: 26,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
            ),

            /// best of the month
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8),
              child: Text(
                "Best of the month",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
            ),

            /// 2nd -- ListView builder for images
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 10),
              child: Container(
                height: 200,
                // color: Colors.blueAccent,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imgUrllist.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 150,
                      margin: EdgeInsets.all(8),
                      child: CachedNetworkImage(
                        imageUrl: imgUrllist[index],
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        placeholder: (context, url) => Container(
                          child: Center(child: CircularProgressIndicator()),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(21)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            /// color tone
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 12, bottom: 12),
              child: Text("The color tone",
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
            ),

            /// 3rd
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 12),
              child: Container(
                height: 60,
                child: ListView.builder(
                  itemCount: imgUrllist.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Container(
                        width: 50,
                        child: Image.network(imgUrllist[index],fit: BoxFit.fill,),
                      ),
                    );
                  },
                ),
              ),
            ),

            /// categories
            Padding(
              padding: const EdgeInsets.only(left: 8.0,top: 8,bottom: 12),
              child: Text("Categories",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold)),
            ),
            /// 4th
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: GridView.builder(
                  itemCount: imgUrllist.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 150,
                    maxCrossAxisExtent: 250,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      child: Center(
                        child: Image.network(imgUrllist[index]),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
