// ignore_for_file: avoid_print, prefer_const_constructors, unnecessary_null_comparison, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'University.dart';

class University extends StatefulWidget {
  const University({Key? key}) : super(key: key);

  @override
  State<University> createState() => _UniversityState();
}

class _UniversityState extends State<University> {
  String? country;
  bool datafilledhua = false;
  List<String> provinceList = [];
  List<UniDataModel> datafilled = [];
  bool loading = false;
  void universitydatafun() async {
    setState(() {
      loading = true;
    });
    String url = "http://universities.hipolabs.com/search?country=$country";
    dynamic response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        datafilled = uniDataModelFromJson(response.body);
        if (datafilled.isEmpty || datafilled == null) {
          loading = true;
        }
        loading = false;
      });
      provinceList = [];
      provinceList.add("All");
      String province;
      List<Object>.from(json.decode(response.body).map((x) => {
            if (UniDataModel.fromJson(x).stateProvince != null)
              {
                province = UniDataModel.fromJson(x).stateProvince.toString(),
                if (!provinceList.contains(province))
                  {provinceList.add(province)}
              }
          }));
      datafilledhua = true;
      print(provinceList);
    } else {
      print("error");
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Country'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Country',
                suffix: IconButton(
                  onPressed: () {
                    loading = true;
                    universitydatafun();
                  },
                  icon: Icon(Icons.search),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  country = value;
                  print(country);
                });
              },
            ),
            loading == true
                ? Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: SpinKitSquareCircle(
                      color: Colors.black,
                      size: 50.0,
                    ),
                  )
                : (datafilled.isEmpty || datafilled == null)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 100.0),
                        child: country == null || country == ""
                            ? Container(
                                width: 0,
                                height: 0,
                              )
                            : Text('No Data or Wrong Country Name '),
                      )
                    : Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: datafilled.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: ListTile(
                                  title: Text(datafilled[index].name!),
                                  subtitle: Row(
                                    children: [
                                      datafilled[index].stateProvince != null
                                          ? Text(
                                              '${datafilled[index].stateProvince}')
                                          : Text("Federal University"),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        datafilled[index].webPages![0],
                                        overflow: TextOverflow.clip,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
          ],
        ),
      ),
    );
  }
}
