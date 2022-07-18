import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SearchView extends StatefulWidget {
  SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

enum SearchTab { recents, favorites }

class _SearchViewState extends State<SearchView> with TickerProviderStateMixin {
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

  double heightFactor = 1;
  double draggleMaxSize = .5;

  bool fullScreen = false;

  SearchTab _activeTab = SearchTab.recents;

  final GlobalKey draggableKey = GlobalKey();
  late BuildContext draggableSheetContext;
  static const double minExtent = .5;
  static double maxExtent = 1;

  bool isExpanded = false;
  // double initialExtent = minExtent;
  double initialExtent = .5;

  @override
  Widget build(BuildContext context) {
    double paddingTop = 10;
    fullScreen = false;

    if (fullScreen) {
      paddingTop = 30;
    }
    if (isExpanded) {
      fullScreen = true;
    }

    void toggleDraggableScrollableSheet() {
      debugPrint(">>< toggle $isExpanded");
      // if (draggableSheetContext != null) {
      setState(() {
        // maxExtent = isExpanded ? .5 : 1;
        initialExtent = isExpanded ? minExtent : maxExtent;
        isExpanded = !isExpanded;
      });
      DraggableScrollableActuator.reset(draggableSheetContext);
      // }
    }

    _toggleSearchTab() {
      _activeTab = _activeTab == SearchTab.recents
          ? SearchTab.favorites
          : SearchTab.recents;
      setState(() {});
    }

    return
        // FractionallySizedBox(
        //   heightFactor: heightFactor,
        //   child:
        KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return DraggableScrollableActuator(
        child: DraggableScrollableSheet(
            key: draggableKey,
            initialChildSize: initialExtent,
            // maxChildSize: draggleMaxSize,
            maxChildSize: maxExtent,
            minChildSize: minExtent,
            builder: (draggleContext, _scrollController) {
              draggableSheetContext = draggleContext;

              _scrollController.addListener(() {
                debugPrint(">> scrolling");
                // if (_scrollController.position.viewportDimension >=
                //     MediaQuery.of(context).size.height * .7) {
                //   fullScreen = true;
                // } else {
                //   fullScreen = false;
                // }
              });

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                margin: EdgeInsets.all(fullScreen ? 0 : 10),
                padding: EdgeInsets.fromLTRB(0, fullScreen ? 30 : 10, 0, 10),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView(controller: _scrollController, children: [
                  // Search Title Text
                  if (fullScreen)
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Recherchez ici",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                        ),
                        onTap: toggleDraggableScrollableSheet,
                      ),
                      trailing: Icon(Icons.search),
                      onTap: () {
                        toggleDraggableScrollableSheet();
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...categories
                            .take(5)
                            .map((category) => Expanded(
                                  child: RawMaterialButton(
                                    onPressed: () {},
                                    padding: EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey.shade300),
                                          child: Icon(category['icon']),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          category['title'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                        Expanded(
                          child: RawMaterialButton(
                            onPressed: () {},
                            padding: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade300),
                                  child: Icon(Icons.more_vert),
                                ),
                                const SizedBox(height: 10),
                                // Text(category['title'])
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RawMaterialButton(
                        onPressed: _toggleSearchTab,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        fillColor: _activeTab == SearchTab.recents
                            ? Colors.blue
                            : null,
                        child: Text(
                          "Récents".toUpperCase(),
                          style: TextStyle(
                            color: _activeTab == SearchTab.recents
                                ? Colors.white
                                : null,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      RawMaterialButton(
                        onPressed: _toggleSearchTab,
                        fillColor: _activeTab == SearchTab.favorites
                            ? Colors.blue
                            : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "Favoris".toUpperCase(),
                          style: TextStyle(
                            color: _activeTab == SearchTab.favorites
                                ? Colors.white
                                : null,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const ListTile(
                      horizontalTitleGap: 0,
                      leading: Icon(Icons.home_outlined),
                      title: Text(
                        "Maison",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      trailing: Text(
                        "2km",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const ListTile(
                      title: Text(
                        "Abidjan Mall",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      trailing: Text(
                        "2km",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Spacer(),
                  if (fullScreen)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                    side: BorderSide(
                                        color: Colors.grey.shade300)),
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
                      ),
                    )
                ]),
              );
            }),
        // ),
      );
    });
  }
}
