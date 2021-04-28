import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dibu/models/notification.dart' as notification;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'services/database.dart';

class Notifications extends StatefulWidget {
  final String uid;

  const Notifications({required this.uid});

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: DatabaseService(uid: widget.uid).notifications,
      builder: (context, data) {
        if (data.data == null) {
          return const Center(child: CircularProgressIndicator(),);
        } else {
          List<notification.Notification> notifications = DatabaseService(uid: widget.uid)
              .notificationsFromSnapshot(data.data as QuerySnapshot);
          return Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'NOTIFICATIONS',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: notifications.length,
                    itemBuilder: (context, position) {
                      notification.Notification model = notifications[position];
                      return Card(
                        elevation: 8.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: model.dp!.isEmpty ?
                            Container(
                              height: 30.0,
                              width: 30.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: ClipOval(
                                child: SvgPicture.asset(
                                  'assets/images/svg/user-avatar.svg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ) :
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(model.dp!),
                            ),
                            onTap: () => {
                            },
                            onLongPress: () {
                            },
                            title: Text('${model.name}'),
                            subtitle: Text('${model.email}', style: TextStyle(fontSize: 10)),
                            trailing: Container(
                              width: 100,
                              height: 50,
                              child: Stack(
                                  alignment: AlignmentDirectional.centerEnd,
                                  children: []
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
