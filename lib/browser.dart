import 'package:day18/view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Browser extends StatefulWidget {
  const Browser({Key? key}) : super(key: key);

  @override
  State<Browser> createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  TextEditingController textCntrl = TextEditingController();
  String sourceCode = '';
  bool isLoading = false;

  void getUrl() async {
    setState(() {
      isLoading = true;
    });
    http.Response response = await http.get(Uri.parse(textCntrl.text));

    setState(() {
      sourceCode = response.body;
    });
    isLoading = false;
  }

  @override
  void initState() {
    textCntrl.text = "https://www.";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Browser"),
      ),
      body: Column(
        children: [
          Divider(
            color: Colors.black,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: textCntrl,
                    decoration: InputDecoration(
                      labelText: "Enter the URL",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 55,
                  width: 50,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                    onPressed: getUrl,
                    icon: Icon(Icons.search_rounded),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        sourceCode,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
          FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewPage(url: textCntrl as Uri)));
              },
              child: Text("View"))
        ],
      ),
    );
  }
}
