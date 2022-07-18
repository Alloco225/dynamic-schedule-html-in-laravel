import 'package:flutter/material.dart';

class AddPlaceView extends StatefulWidget {
  AddPlaceView({Key? key}) : super(key: key);

  @override
  State<AddPlaceView> createState() => _AddPlaceViewState();
}

class _AddPlaceViewState extends State<AddPlaceView> {
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

  Map _selectedCategory = {};

  _selectCategory(cat) {
    _selectedCategory = cat;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .6,
      minChildSize: .4,
      maxChildSize: .7,
      expand: false,
      builder: (_, controller) => Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          ListTile(
            title: const Text(
              "Ajouter un place",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Position actuelle: Saint jean caffe de versaille"),
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
                "Choisis un nom :",
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
                  "Choisis une catégorie pour ton lieu :",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // * Place categories
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 2 / 2.5,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: categories.length,
                itemBuilder: (ctx, i) => RawMaterialButton(
                  onPressed: () {
                    _selectCategory(categories[i]);
                  },
                  padding: const EdgeInsets.all(10),
                  fillColor: _selectedCategory == categories[i]
                      ? Colors.orange.shade400
                      : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade300),
                        child: Icon(categories[i]['icon']),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        categories[i]['title'],
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          // const Spacer(),
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
                    child: Text(
                      "Modifier".toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
