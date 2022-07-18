import 'package:flutter/material.dart';

class UserProfileView extends StatefulWidget {
  UserProfileView({Key? key}) : super(key: key);

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .4,
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
              "User name",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text("user phone"),
            trailing: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset("assets/avatars/f1.png"),
            ),
          ),
          const ListTile(
            title: Text("Mes addresses"),
            leading: Icon(Icons.favorite),
          ),
          const ListTile(
            title: Text("Mes addresses"),
          ),
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
                    padding:  const EdgeInsets.all(15),
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
