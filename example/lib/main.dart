import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_utils_smartid_bam/flutter_utils_smartid_bam.dart';
import 'package:flutter_utils_smartid_bam_example/model/smart_id_example.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController initResultController = TextEditingController(text: '');
  TextEditingController userNameController =
      TextEditingController(text: 'test');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SmartId flutter example app'),
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: initResultController,
                    decoration: InputDecoration(
                      labelText: 'Result',
                      enabled: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            var result =
                                await FlutterUtilsSmartidBam.getInstance();

                            initResultController.text = result['response'];
                          },
                          child: Text('Init Instance'),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      labelText: 'username',
                      enabled: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            SmartIdExample smartIdExample = SmartIdExample(
                              data: initResultController.text,
                              channelId: '2',
                              username: userNameController.text,
                            );

                            var jsonData =
                                jsonEncode(smartIdExample).toString();
                            print(jsonData);

                            final response = await http.post(
                              Uri.parse(
                                  'https://fifth-webapp-dummy.smartidonline.com/api/app/login'),
                              body: jsonData,
                              headers: <String, String>{
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                                'Access-Control-Allow-Origin': '*',
                              },
                            );

                            print('Post response: ${response.body}');
                          },
                          child: Text('Log in'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
