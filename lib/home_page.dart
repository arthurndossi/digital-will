import 'package:collection/collection.dart';
import 'package:dibu/models/app.dart';
import 'package:dibu/widget/circular_button.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

class HomePage extends StatefulWidget {
  final setBar;
  final appBar;

  const HomePage({this.setBar, this.appBar});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  List<App> _apps;

  int _lastIndex = 0;

  // List elements;
  //
  // Future<void> getInstalledApps() async {
  //   List _apps = await DeviceApps.getInstalledApplications(includeAppIcons: true);
  //
  //   setState(() {
  //     apps = _apps;
  //     print(apps);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // getInstalledApps();
      return FutureBuilder<List<Application>>(
        future: DeviceApps.getInstalledApplications(
          includeAppIcons: true,
        ),
        builder: (context, data) {
          if (data.data == null) {
            return const Center(child: CircularProgressIndicator(),);
          } else {
            List<Application> apps = data.data;
            List<App> _elements = [];
            for (Application application in apps) {
              var icon = application is ApplicationWithIcon ? CircleAvatar(backgroundColor: Colors.white, backgroundImage: MemoryImage(application.icon)) : null;
              switch (application.appName) {
                case 'Facebook':
                case 'Instagram':
                case 'TikTok':
                case 'Likee':
                case 'Snapchat':
                case 'WhatsApp':
                  var obj = App(application.appName, icon, 'Social');
                  _elements.add(obj);
                  break;
                case 'Google Drive':
                case 'iCloud':
                case 'Dropbox':
                  var obj = App(application.appName, icon, 'Storage');
                  _elements.add(obj);
                  break;
                case 'Bitcoin':
                case 'Ethereum':
                case 'Coinbase':
                  var obj = App(application.appName, icon, 'Crypto Wallet');
                  _elements.add(obj);
                  break;
              }
            }
            var _newMap = groupBy(
              _elements, (App obj) => obj.category
            );
            var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
            return Container(
              child: Column(
                children: _newMap.entries.map<Widget>((val) {
                  if (_apps == null)
                    _apps = val.value;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          val.key.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: val.value.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: isPortrait ? 3 : 5,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 5,
                                childAspectRatio: isPortrait ? 1 : 1.1
                              ),
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 8.0,
                                  child: SingleChildScrollView(
                                    child: InkWell(
                                      onTap: () {},
                                      onLongPress: () {
                                        widget.setBar('SelectBar');
                                      },
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: val.value[index].icon,
                                            ),
                                            Text(val.value[index].name),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: CircularButton(
                                                    color: Color(0xFF62D1EA),
                                                    width: 30,
                                                    height: 30,
                                                    icon: Icon(
                                                      Icons.arrow_forward_outlined,
                                                      size: 16,
                                                      color: Colors.white,
                                                    ),
                                                    onClick: () {
                                                      setState(() {
                                                        if (_lastIndex != index)
                                                          _apps[_lastIndex].showDialog = false;

                                                        _apps[index].showDialog = !_apps[index].showDialog;
                                                        _lastIndex = index;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: _apps[index].showDialog,
                                                  child: Expanded(
                                                    child: Container(
                                                      color: Color(0x59DADADA),
                                                      child: Scrollbar(
                                                        child: SingleChildScrollView(
                                                          scrollDirection: Axis.horizontal,
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              SizedBox(
                                                                height: 32.0,
                                                                width: 32.0,
                                                                child: IconButton(
                                                                  icon: Icon(
                                                                    Icons.launch,
                                                                    color: Color(0xFF62D1EA),
                                                                  ),
                                                                  padding: EdgeInsets.zero,
                                                                  onPressed: () {
                                                                    DeviceApps.openApp(apps[index].packageName);
                                                                  },
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 32.0,
                                                                width: 32.0,
                                                                child: IconButton(
                                                                  icon: Icon(
                                                                    Icons.person_add,
                                                                    color: Color(0xFF62D1EA),
                                                                  ),
                                                                  padding: EdgeInsets.zero,
                                                                  onPressed: () {},
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 32.0,
                                                                width: 32.0,
                                                                child: IconButton(
                                                                  icon: Icon(
                                                                    Icons.delete,
                                                                    color: Color(0xFF62D1EA),
                                                                  ),
                                                                  padding: EdgeInsets.zero,
                                                                  onPressed: () {},
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                );
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  );
                }).toList(),
              ),
            );
            // return GroupedListView<App, dynamic>(
            //   elements: _elements,
            //   groupBy: (App element) => element.category,
            //   itemComparator: (item1, item2) => item1.name.compareTo(item2.name),
            //   groupSeparatorBuilder: (dynamic value) => Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Text(value, textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            //   ),
            //   itemBuilder: (c, element) {
            //     return Card(
            //       elevation: 8.0,
            //       margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            //       child: Container(
            //         child: Column(
            //           children: [
            //             element.icon,
            //             Text(element.name)
            //           ],
            //         ),
                    // child: ListTile(
                    //   contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    //   leading: Icon(Icons.account_circle),
                    //   title: Text(element['name']),
                    //   trailing: Icon(Icons.arrow_forward_ios_outlined),
                    // ),
            //       ),
            //     );
            //   },
            // );
          }
        },
      );
  }

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree/unitRadian;
  }
}
