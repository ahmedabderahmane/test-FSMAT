import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Element extends StatelessWidget {
  const Element({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEFF5),
      appBar: _buildAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [],
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
                child: Image.asset('assets/images/1338415.webp')),
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

class AddElement extends StatefulWidget {
  const AddElement({super.key});

  @override
  State<AddElement> createState() => _AddElementState();
}

class _AddElementState extends State<AddElement> {
  final typeController = TextEditingController();
  final titreController = TextEditingController();
  late DateTime datedebut;
  late DateTime datefin;
  final etatController = TextEditingController();
  double avancement = 0.0;

  // Ajout d'une liste d'options pour le champ "Type"
  List<String> types = ['Scolarité', 'Personnel'];
  List<String> etats = ['En Progress', 'A Faire', 'Terminer'];
  late String selectedType;
  late String selectedEtat;

  @override
  void initState() {
    super.initState();
    selectedType = types[0]; // Initialisez avec la première option
    selectedEtat = etats[0]; // Initialisez avec la première option
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Element'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  Text('Type'),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value!;
                      });
                    },
                    items: types.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(color: Colors.white30, width: 1.5),
              ),
              title: Row(
                children: [
                  Text('Titre'),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: titreController,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(color: Colors.white30, width: 1.5),
              ),
              title: Row(
                children: [
                  Text('Date Début'),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != datedebut) {
                        setState(() {
                          datedebut = pickedDate;
                        });
                      }
                    },
                    child: Text(
                      // ignore: unnecessary_null_comparison
                      datedebut != null
                          ? DateFormat('yyyy-MM-dd').format(datedebut)
                          : 'Sélectionnez la date',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(color: Colors.white30, width: 1.5),
              ),
              title: Row(
                children: [
                  Text('Date Fin'),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != datefin) {
                        setState(() {
                          datefin = pickedDate;
                        });
                      }
                    },
                    child: Text(
                      // ignore: unnecessary_null_comparison
                      datefin != null
                          ? DateFormat('yyyy-MM-dd').format(datefin)
                          : 'Sélectionnez la date',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(color: Colors.white30, width: 1.5),
              ),
              title: Row(
                children: [
                  Text('Etat'),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value!;
                      });
                    },
                    items: types.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(color: Colors.white30, width: 1.5),
              ),
              title: Row(
                children: [
                  Text('Avancement'),
                  const SizedBox(width: 10),
                  // Utilisation du Slider pour sélectionner le pourcentage
                  Expanded(
                    child: Slider(
                      value: avancement,
                      onChanged: (value) {
                        setState(() {
                          avancement = value;
                        });
                      },
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: '$avancement%', // Affiche la valeur du Slider
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50)),
                onPressed: () {
                  FirebaseFirestore.instance.collection('element').add({
                    'type': typeController.value.text,
                    'titre': titreController.value.text,
                    'Date Début': datedebut,
                    'Date Fin': datefin,
                    'Etat': etatController.value.text,
                    'Avancement': avancement,
                  });
                  Navigator.pop(context);
                },
                child: const Text('Creer une Tâche')),
          ],
        ),
      ),
    );
  }
}
