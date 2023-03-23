import 'package:animal_game_app/helpers/api_helpers.dart';
import 'package:animal_game_app/models/post_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      // theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List allColumns = ['Image', 'Id', 'Title'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDBE4C6),
      appBar: AppBar(
        backgroundColor: const Color(0xffBBD6B8),
        title: Text(
          "Random Data",
          style: TextStyle(
            color: Colors.green.shade900,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              FutureBuilder(
                future: ApiHelper.apiHelper.getPost(),
                builder: (context, snapShot) {
                  if (snapShot.hasError) {
                    return Text("${snapShot.error}");
                  } else if (snapShot.hasData) {
                    List<Posts>? P = snapShot.data;
                    return DataTable(
                      showBottomBorder: true,
                      headingRowColor:
                          MaterialStateProperty.all(Colors.green.shade900),
                      headingTextStyle: const TextStyle(
                        color: Color(0xffBBD6B8),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      headingRowHeight: 50,
                      columns: allColumns
                          .map(
                            (e) => DataColumn(
                              label: Text(e),
                            ),
                          )
                          .toList(),
                      rows: List.generate(
                        P!.length,
                        (index) => DataRow(
                          cells: [
                            DataCell(
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        P[index].thumbnailUrl,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                "${P[index].id}",
                              ),
                            ),
                            DataCell(
                              Text(
                                P[index].title,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
