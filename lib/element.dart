import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Element extends StatelessWidget {
  Element({Key? key}) : super(key: key);
  final List<String> tasks = ['En Progres', 'A Faire', 'Termine'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEFF5),
      appBar: _buildAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            serchBox(),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50, bottom: 20),
                    child: Text(
                      'Mes tâches',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  for (String task in tasks) TaskWidget(taskName: task),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/ajouter_element.dart');
        },
        child: Icon(Icons.add), // Utiliser l'icône "+" ici
      ),
    );
  }

  Widget serchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Color(0xFFEEEFF5), borderRadius: BorderRadius.circular(20)),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFF3A3A3A),
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Chercher',
          hintStyle: TextStyle(color: Color(0xFF3A3A3A)),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFFEEEFF5),
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/1338415.webp'),
            ),
          ),
          Icon(
            Icons.menu,
            color: Color(0xFF3A3A3A),
            size: 30,
          ),
        ],
      ),
    );
  }
}

class TaskWidget extends StatelessWidget {
  final String taskName;

  const TaskWidget({required this.taskName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            taskName,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class ElementInformation extends StatefulWidget {
  const ElementInformation({super.key});

  @override
  State<ElementInformation> createState() => _ElementInformationState();
}



class _ElementInformationState extends State<ElementInformation> {
  final Stream<QuerySnapshot> _elementsStream=
  FirebaseFirestore.instance.collection('Element').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _elementsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
      }
    );
  }
}