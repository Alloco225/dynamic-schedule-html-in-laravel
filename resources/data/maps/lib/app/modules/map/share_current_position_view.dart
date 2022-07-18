import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SharePositionView extends StatefulWidget {
  SharePositionView({Key? key}) : super(key: key);

  @override
  State<SharePositionView> createState() => _SharePositionViewState();
}

class _SharePositionViewState extends State<SharePositionView> {
  List<Map> categories = [
    {
      'title': "Café",
      'icon': Icons.local_drink,
    },
    {
      'title': "Food",
      'icon': Icons.restaurant,
    },
    {
      'title': "Shopping",
      'icon': Icons.shopping_bag,
    },
    {
      'title': "Parking",
      'icon': Icons.local_parking,
    },
  ];

  Map options = {
    'private': false,
    'ephemere': false,
  };

  Map _selectedCategory = {};

  _selectCategory(cat) {
    _selectedCategory = cat;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return DraggableScrollableSheet(
        initialChildSize: .6,
        minChildSize: .4,
        maxChildSize: .7,
        // expand: false,
        builder: (_, controller) => Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Flex(direction: Axis.vertical, children: [
            ListTile(
              title: const Text(
                "Partager ma location",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle:
                  Text("Position actuelle: Saint jean caffe de versaille"),
              trailing: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.gps_fixed,
                ),
              ),
            ),

            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  "Chercher un lieu à partager :",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              // padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nom du lieu',
                  ),
                ),
                trailing: Icon(Icons.location_on),
                onTap: () {
                  // draggableKey.currentState.
                  // _scrollController.
                  // Focus the
                  // draggleMaxSize = 1;
                  // setState(() {});
                  // heightFactor = .9;
                  // setState(() {});
                },
              ),
            ),
            // const ListTile(
            //   title: Text("Choisis une catégorie pour ton lieu"),
            //   leading: Icon(Icons.favorite),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.check_circle,
                    size: 17,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Ou partager mon addresse actuelle :",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // * Sharing options
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              // padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const Text("Privée"),
                subtitle: const Text(
                  "Seulement les personnes que vous autorisez sont capable de voir l'addresse",
                ),
                trailing: CupertinoSwitch(
                  onChanged: (_) {
                    options['private'] = _;
                    setState(() {});
                  },
                  value: options['private'],
                ),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              // padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const Text("Ephémère"),
                subtitle: const Text(
                  "Déterminez la durée pendant laquelle le lien est actif",
                ),
                trailing: CupertinoSwitch(
                  onChanged: (_) {
                    options['ephemere'] = _;
                    setState(() {});
                  },
                  value: options['ephemere'],
                ),
                onTap: () {},
              ),
            ),
            // const SizedBox(height: 10),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      fillColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.grey.shade300)),
                      child: const Text("Annuler"),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {},
                      fillColor: Colors.orange,
                      elevation: 0,
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Partager".toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            FeatherIcons.share2,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      );
    });
  }
}
