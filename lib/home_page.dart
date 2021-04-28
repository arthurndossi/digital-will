import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:dibu/models/app.dart';
import 'package:dibu/widget/circular_button.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:provider/provider.dart';

import 'add_account.dart';
import 'app_account.dart';
import 'models/keys.dart';
import 'providers/default_bar.dart';
import 'services/database.dart';

class HomePage extends StatefulWidget {
  final String uid;

  const HomePage({required this.uid});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _row = -1;
  int _pos = -1;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        DeviceApps.getInstalledApplications(
          includeAppIcons: true,
        ),
        DatabaseService(uid: widget.uid).myApps
      ]),
      builder: (context, data) {
        if (data.data == null) {
          return const Center(child: CircularProgressIndicator(),);
        } else {
          List<Object> map = data.data as List<Object>;
          List<Application> apps = map[0] as List<Application>;
          List<App> _elements = [];
          for (Application application in apps) {
            var icon = application is ApplicationWithIcon ?
            CircleAvatar(backgroundColor: Colors.white, backgroundImage:
            MemoryImage(application.icon)) : null;
            switch (application.appName) {
              case 'Facebook':
              case 'Instagram':
              case 'TikTok':
              case 'Likee':
              case 'Snapchat':
              case 'WhatsApp':
              case 'Skype':
                var obj = App.installed(application.appName, icon, 'Social');
                _elements.add(obj);
                break;
              case 'Google Drive':
              case 'iCloud':
              case 'Dropbox':
                var obj = App.installed(application.appName, icon, 'Storage');
                _elements.add(obj);
                break;
              case 'Bitcoin':
              case 'Ethereum':
              case 'Coinbase':
                var obj = App.installed(
                    application.appName, icon, 'Crypto Wallet');
                _elements.add(obj);
                break;
              case 'Netflix':
              case 'Prime Video':
              case 'Spotify':
                var obj = App.installed(application.appName, icon, 'Streaming');
                _elements.add(obj);
                break;
            }
          }
          List<App> dbApps = DatabaseService(uid: widget.uid).appsFromSnapshot(
              map[1] as QuerySnapshot);
          for (App app in dbApps) {
            String iconUrl = setAppIcon(app.name!);
            app.icon = iconUrl;
            switch (app.name) {
              case 'Facebook':
              case 'Instagram':
              case 'TikTok':
              case 'Likee':
              case 'Snapchat':
              case 'WhatsApp':
              case 'Skype':
                app.category = "Social";
                _elements.add(app);
                break;
              case 'Google Drive':
              case 'iCloud':
              case 'Dropbox':
                app.category = "Storage";
                _elements.add(app);
                break;
              case 'Bitcoin':
              case 'Ethereum':
              case 'Coinbase':
                app.category = "Crypto Wallet";
                _elements.add(app);
                break;
              case 'Netflix':
              case 'Prime Video':
              case 'Spotify':
                app.category = "Streaming";
                _elements.add(app);
                break;
            }
          }
          var _newMap = groupBy(
              _elements, (App obj) => obj.category
          );
          var isPortrait = MediaQuery
              .of(context)
              .orientation == Orientation.portrait;
          return GestureDetector(
            onTap: () => {
              setState(() {
                _row = -1;
                _pos = -1;
              })
            },
            child: SingleChildScrollView(
                child: Column(
                    children: [
                      for (int i = 0; i < _newMap.entries.length; i++)
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _newMap.entries.elementAt(i).key.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                                children: [
                                  Expanded(
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: _newMap.entries.elementAt(i).value.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: isPortrait ? 3 : 5,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 5,
                                          childAspectRatio: isPortrait ? 1 : 1.1
                                      ),
                                      itemBuilder: (context, index) {
                                        var defaultBar = context.read<DefaultBar>();
                                        bool showSelect = defaultBar.showSelect;
                                        bool isSelected = defaultBar.isItemSelected(i, index);
                                        return Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            IgnorePointer(
                                              child: Container(
                                                color: Colors.transparent,
                                                height: 150.0,
                                                width: 150.0,
                                              ),
                                            ),
                                            Card(
                                                elevation: 8.0,
                                                child: InkWell(
                                                    onTap: () {
                                                      if (defaultBar.getCurrentBar == 'SelectBar') {
                                                        defaultBar
                                                            .setCurrentBar(
                                                            'AppBar');
                                                        defaultBar.clearSelected();
                                                        defaultBar.update();
                                                      }
                                                      if (_newMap.entries.elementAt(i).value[index]
                                                          .hasCredentials) {
                                                        NavKey.innerNavKey
                                                            .currentState!.push(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    AppAccount(
                                                                        app: _newMap.entries.elementAt(i).value[index]
                                                                    )
                                                            )
                                                        );
                                                      } else {
                                                        NavKey.innerNavKey
                                                            .currentState!.push(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    AddAccount(
                                                                      appName: _newMap.entries.elementAt(i).value[index]
                                                                          .name,
                                                                      category: _newMap.entries.elementAt(i).value[index]
                                                                          .category,
                                                                      isInstalled: _newMap.entries.elementAt(i).value[index]
                                                                          .isInstalled,
                                                                      uid: widget.uid,
                                                                    )
                                                            )
                                                        );
                                                      }
                                                    },
                                                    onLongPress: () {
                                                      if (defaultBar.getCurrentBar ==
                                                          'AppBar') {
                                                        defaultBar.setCurrentBar(
                                                            'SelectBar');
                                                        defaultBar.toggleShowSelect();
                                                        defaultBar.addToSelected(
                                                            i, index);
                                                        defaultBar.update();
                                                      }
                                                    },
                                                    child: Stack(
                                                        children: [
                                                          Container(
                                                              width: 100,
                                                              height: 100,
                                                              child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(4.0),
                                                                      child: _newMap.entries.elementAt(i).value[index]
                                                                          .avatar ==
                                                                          null
                                                                          ? CircleAvatar(
                                                                          radius: 30.0,
                                                                          backgroundColor: Colors
                                                                              .transparent,
                                                                          child: Image
                                                                              .asset(
                                                                              _newMap.entries.elementAt(i).value[index]
                                                                                  .icon!,
                                                                              width: 60.0,
                                                                              height: 60.0
                                                                          )
                                                                      )
                                                                          : _newMap.entries.elementAt(i).value[index]
                                                                          .avatar,
                                                                    ),
                                                                    Text(_newMap.entries.elementAt(i).value[index]
                                                                        .name!),
                                                                  ]
                                                              )
                                                          ),
                                                          Positioned(
                                                            top: 0,
                                                            right: 0,
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .all(4.0),
                                                              child: CircularButton(
                                                                color: Color(
                                                                    0xFF62D1EA),
                                                                width: 30,
                                                                height: 30,
                                                                icon: Icon(
                                                                  Icons.more_vert,
                                                                  size: 16,
                                                                  color: Colors.white,
                                                                ),
                                                                onClick: () {
                                                                  setState(() {
                                                                    if (_row == i && _pos == index) {
                                                                      _row = -1;
                                                                      _pos = -1;
                                                                    } else {
                                                                      _row = i;
                                                                      _pos = index;
                                                                    }
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          )
                                                        ]
                                                    )
                                                )
                                            ),
                                            Visibility(
                                              visible: showSelect,
                                              child: Positioned(
                                                child: Container(
                                                  width: 24,
                                                  height: 24,
                                                  decoration: isSelected ?
                                                  BoxDecoration(
                                                      color: Color(0xFF62D1EA),
                                                      shape: BoxShape.circle
                                                  ) :
                                                  BoxDecoration(
                                                    border: Border.all(
                                                        color: Color(0xFF62D1EA),
                                                        width: 2.0),
                                                    color: Colors.transparent,
                                                    borderRadius: BorderRadius
                                                        .circular(12),
                                                  ),
                                                  child: showSelect ? InkWell(
                                                    onTap: () => {
                                                      isSelected ?
                                                      defaultBar.removeFromSelected(i, index)
                                                          : defaultBar.addToSelected(i, index)
                                                    },
                                                    child: isSelected ? Icon(
                                                      Icons.check_sharp,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ) : null,
                                                  ) : null,
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: _row == i && _pos == index,
                                              child: Positioned(
                                                top: 5,
                                                right: 0,
                                                child: Card(
                                                    elevation: 10.0,
                                                    child: Container(
                                                        width: 30,
                                                        height: 100,
                                                        child: Scrollbar(
                                                          child: SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                SizedBox(
                                                                  height: 32.0,
                                                                  width: 32.0,
                                                                  child: IconButton(
                                                                    icon: Icon(
                                                                      Icons.launch,
                                                                      color: Color(
                                                                          0xFF62D1EA),
                                                                    ),
                                                                    padding: EdgeInsets
                                                                        .zero,
                                                                    onPressed: () {
                                                                      DeviceApps
                                                                          .openApp(
                                                                          apps[index]
                                                                              .packageName);
                                                                    },
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 32.0,
                                                                  width: 32.0,
                                                                  child: IconButton(
                                                                    icon: Icon(
                                                                      Icons
                                                                          .edit_outlined,
                                                                      color: Color(
                                                                          0xFF62D1EA),
                                                                    ),
                                                                    padding: EdgeInsets
                                                                        .zero,
                                                                    onPressed: () {},
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 32.0,
                                                                  width: 32.0,
                                                                  child: IconButton(
                                                                    icon: Icon(
                                                                      Icons.delete,
                                                                      color: Color(
                                                                          0xFF62D1EA),
                                                                    ),
                                                                    padding: EdgeInsets
                                                                        .zero,
                                                                    onPressed: () {},
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                    )
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ]
                            )
                          ],
                        ),
                    ]
                )
            ),
            // child: Column(
            //   children: _newMap.entries.map<Widget>((val) {
            //     _apps = val.value;
            //     return Column(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text(
            //             val.key.toString(),
            //             textAlign: TextAlign.center,
            //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //           ),
            //         ),
            //         Row(
            //           children: [
            //             Expanded(
            //                 child: GridView(
            //                   shrinkWrap: true,
            //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //                     crossAxisCount: isPortrait ? 3 : 5,
            //                     mainAxisSpacing: 10,
            //                     crossAxisSpacing: 5,
            //                     childAspectRatio: isPortrait ? 1 : 1.1
            //                   ),
            //                   children: [
            //                     for (int i = 0; i < _apps.length; i++)
            //                       Stack(
            //                       clipBehavior: Clip.none,
            //                       children: [
            //                         IgnorePointer(
            //                           child: Container(
            //                             color: Colors.transparent,
            //                             height: 150.0,
            //                             width: 150.0,
            //                           ),
            //                         ),
            //                         Card(
            //                           elevation: 8.0,
            //                           child: InkWell(
            //                             onTap: () {
            //                               if (_apps[i].hasCredentials) {
            //                                 NavKey.innerNavKey.currentState!.push(
            //                                   MaterialPageRoute(
            //                                     builder: (context) => AppAccount(
            //                                       app: _apps[i]
            //                                     )
            //                                   )
            //                                 );
            //                               } else {
            //                                 NavKey.innerNavKey.currentState!.push(
            //                                   MaterialPageRoute(
            //                                     builder: (context) =>
            //                                       AddAccount(
            //                                         appName: _apps[i].name,
            //                                         category: _apps[i].category,
            //                                         isInstalled: _apps[i].isInstalled,
            //                                         uid: widget.uid,
            //                                       )
            //                                   )
            //                                 );
            //                               }
            //                             },
            //                             onLongPress: () {
            //                               var defaultBar = context.read<DefaultBar>();
            //                               if (defaultBar.getCurrentBar == 'AppBar') {
            //                                 defaultBar.setCurrentBar('SelectBar');
            //                                 defaultBar.toggleShowSelect();
            //                                 defaultBar.addToSelected(i);
            //                               }
            //                             },
            //                             child: Stack(
            //                               children: [
            //                                 Container(
            //                                   width: 100,
            //                                   height: 100,
            //                                   child: Column(
            //                                     mainAxisAlignment: MainAxisAlignment.center,
            //                                     children: [
            //                                       Padding(
            //                                         padding: const EdgeInsets.all(4.0),
            //                                         child: _apps[i].avatar == null
            //                                             ? CircleAvatar(radius: 30.0,
            //                                             backgroundColor: Colors.transparent,
            //                                             child: Image.asset(
            //                                               _apps[i].icon!,
            //                                               width: 60.0,
            //                                               height: 60.0
            //                                             )
            //                                         )
            //                                             : _apps[i].avatar,
            //                                       ),
            //                                       Text(_apps[i].name!),
            //                                     ]
            //                                   )
            //                                 ),
            //                                 Positioned(
            //                                   top: 0,
            //                                   right: 0,
            //                                   child: Padding(
            //                                     padding: const EdgeInsets.all(4.0),
            //                                     child: CircularButton(
            //                                       color: Color(0xFF62D1EA),
            //                                       width: 30,
            //                                       height: 30,
            //                                       icon: Icon(
            //                                         Icons.more_vert,
            //                                         size: 16,
            //                                         color: Colors.white,
            //                                       ),
            //                                       onClick: () {
            //                                         setState(() {
            //                                           if (_overlay == i)
            //                                             _overlay = -1;
            //                                           else
            //                                             _overlay = i;
            //                                         });
            //                                       },
            //                                     ),
            //                                   ),
            //                                 )
            //                               ]
            //                             )
            //                           )
            //                         ),
            //                         Visibility(
            //                           visible: context.read<DefaultBar>().showSelect,
            //                           child: Positioned(
            //                             child: Container(
            //                               width: 24,
            //                               height: 24,
            //                               decoration: BoxDecoration(
            //                                 border: Border.all(color: Color(0xFF62D1EA), width: 2.0),
            //                                 color: Colors.transparent,
            //                                 borderRadius: BorderRadius.circular(12),
            //                               ),
            //                               child: context.read<DefaultBar>().showSelect ? InkWell(
            //                                 onTap: () => {
            //                                   context.read<DefaultBar>()
            //                                       .getSelected.contains(i) ?
            //                                   context.read<DefaultBar>()
            //                                       .removeFromSelected(i) :
            //                                   context.read<DefaultBar>()
            //                                       .addToSelected(i)
            //                                 },
            //                                 child: context.read<DefaultBar>()
            //                                     .getSelected.contains(i) ?
            //                                 Icon(
            //                                   Icons.check_sharp,
            //                                   color: Color(0xFF62D1EA),
            //                                   size: 20,
            //                                 ) : null,
            //                               ) : null,
            //                             ),
            //                           ),
            //                         ),
            //                         Visibility(
            //                           visible: _overlay == i,
            //                           child: Positioned(
            //                             top: 5,
            //                             right: 0,
            //                             child: Card(
            //                               elevation: 10.0,
            //                               child: Container(
            //                                 width: 30,
            //                                 height: 100,
            //                                 child: Scrollbar(
            //                                   child: SingleChildScrollView(
            //                                     child: Column(
            //                                       mainAxisAlignment: MainAxisAlignment.center,
            //                                       children: [
            //                                         SizedBox(
            //                                           height: 32.0,
            //                                           width: 32.0,
            //                                           child: IconButton(
            //                                             icon: Icon(
            //                                               Icons.launch,
            //                                               color: Color(0xFF62D1EA),
            //                                             ),
            //                                             padding: EdgeInsets.zero,
            //                                             onPressed: () {
            //                                               DeviceApps.openApp(apps[i].packageName);
            //                                             },
            //                                           ),
            //                                         ),
            //                                         SizedBox(
            //                                           height: 32.0,
            //                                           width: 32.0,
            //                                           child: IconButton(
            //                                             icon: Icon(
            //                                               Icons.edit_outlined,
            //                                               color: Color(0xFF62D1EA),
            //                                             ),
            //                                             padding: EdgeInsets.zero,
            //                                             onPressed: () {},
            //                                           ),
            //                                         ),
            //                                         SizedBox(
            //                                           height: 32.0,
            //                                           width: 32.0,
            //                                           child: IconButton(
            //                                             icon: Icon(
            //                                               Icons.delete,
            //                                               color: Color(0xFF62D1EA),
            //                                             ),
            //                                             padding: EdgeInsets.zero,
            //                                             onPressed: () {},
            //                                           ),
            //                                         )
            //                                       ],
            //                                     ),
            //                                   ),
            //                                 )
            //                               )
            //                             ),
            //                           ),
            //                         )
            //                       ],
            //                     )
            //                   ],
            //                 )
            //             )
            //           ],
            //         )
            //       ],
            //     );
            //   }).toList(),
            // ),
          );
        }
        }
    );
  }

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree/unitRadian;
  }

  String setAppIcon(String appName) {
    String iconUrl = '';
    switch(appName) {
      case 'Facebook':
        iconUrl = 'assets/images/png/fb-icon.png';
        break;
      case 'Instagram':
        iconUrl = 'assets/images/png/instagram-icon.png';
        break;
      case 'Linked In':
        iconUrl = 'assets/images/png/linked_in-icon.png';
        break;
      case 'Snapchat':
        iconUrl = 'assets/images/png/snapchat-icon.png';
        break;
      case 'Twitter':
        iconUrl = 'assets/images/png/twitter-icon.png';
        break;
      case 'TikTok':
        iconUrl = 'assets/images/png/tiktok-icon';
        break;
      case 'Tinder':
        iconUrl = 'assets/images/png/tinder-icon.png';
        break;
      case 'WhatsApp':
        break;
      case 'Google Drive':
        iconUrl = 'assets/images/png/g-icon.png';
        break;
      case 'iCloud':
        break;
      case 'Dropbox':
        break;
      case 'Bitcoin':
        iconUrl = 'assets/images/png/bitcoin-icon.png';
        break;
      case 'Ethereum':
      case 'Coinbase':
        break;
      default:
        return '';
    }
    return iconUrl;
    /*
    - assets/images/png/amazon-icon.png
    - assets/images/png/brand_apple_pay-icon.png
    - assets/images/png/discord-icon.png
    - assets/images/png/ebay-icon.png
    - assets/images/png/evernote-icon.png
    - assets/images/png/gmail-icon.png
    - assets/images/png/netflix-icon.png
    - assets/images/png/pinterest-icon.png
    - assets/images/png/reddit-icon.png
    - assets/images/png/skype-icon.png
    - assets/images/png/soundcloud-icon.png
    - assets/images/png/spotify-icon.png
    - assets/images/png/tumbler-icon.png
    - assets/images/png/xbox-icon.png
    - assets/images/png/yahoo-icon.png
    - assets/images/png/youtube-icon.png
    */
  }
  // bool showSelect() {
  //   var showSelect = context.select<DefaultBar, bool>(
  //     (defaultBar) => defaultBar.showSelect,
  //   );
  //   return showSelect;
  // }

  // void toggleSelectedState(int index) {
  //   var defaultBar = context.read<DefaultBar>();
  //   bool isSelected = defaultBar.getSelected.contains(index);
  //   if (isSelected)
  //     defaultBar.removeFromSelected(index);
  //   else
  //     defaultBar.addToSelected(index);
  // }
}
