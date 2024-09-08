import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ListDisplayer extends StatefulWidget {
  const ListDisplayer({super.key});

  @override
  State<ListDisplayer> createState() => _ListDisplayerState();
}

class _ListDisplayerState extends State<ListDisplayer> {
  List<dynamic> _fetched = [];

  Future<void> fetchList() async {
    try {
      Dio dio = Dio();
      String path = "http://127.0.0.1:8000/data";

      Response<dynamic> result = await dio.get(path).timeout(const Duration(seconds: 5));

      debugPrint("result: $result");

      setState(() {
        _fetched = result.data;
      });
    } on DioException catch (dioErr) {
      debugPrint("raise Dio Exception: $dioErr");
    } on TimeoutException catch (timeoutErr) {
      debugPrint("raise Timeout Exception: $timeoutErr");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "List Displayer",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 39, 39, 39),
        toolbarHeight: 75,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Container(
        color: const Color.fromARGB(255, 65, 65, 65),
        padding: const EdgeInsets.only(top: 10),
        child: _fetched.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : ListView.builder(
                itemCount: _fetched.length,
                itemBuilder: (context, index) {
                  final data = _fetched[index];
                  return Container(
                    height: 80,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(70, 27, 26, 26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text('${data['id']}'),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            child: Center(
                              child: Text(
                                '${data['title']}',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 230, 230, 230),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 75,
                          height: 50,
                          child: Center(
                            child: Text(
                              '${data['writer']}',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 182, 182, 182),
                                fontWeight: FontWeight.w200,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Center(
                            child: ((status) {
                              if (status == "none") {
                                return const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                );
                              } else if (status == "progress") {
                                return const Icon(
                                  Icons.edit,
                                  color: Colors.yellow,
                                );
                              } else if (status == "done") {
                                return const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                );
                              }
                              return null;
                            })(data['status']),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Test tooltip',
        shape: const CircleBorder(),
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }
}
