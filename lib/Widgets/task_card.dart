import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.confirm,
                headerBackgroundColor: Colors.purple,
                text: ' you want to delete',
                confirmBtnText: 'Yes',
                cancelBtnText: 'No',
                confirmBtnColor: Colors.green,
                onConfirmBtnTap: () {},
              )
            },
            icon: Icons.delete,
            label: 'Delete',
            backgroundColor: Colors.red,
          ),
          SlidableAction(
            onPressed: (context) => {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.confirm,
                headerBackgroundColor: Colors.purple,
                text: ' you want to mark as completed',
                confirmBtnText: 'Yes',
                cancelBtnText: 'No',
                confirmBtnColor: Colors.green,
                onConfirmBtnTap: () {},
              )
            },
            icon: Icons.verified,
            label: 'Completed',
            backgroundColor: Colors.green,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
        child: Card(
          elevation: 10,
          shadowColor: Colors.purple,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'code',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                      Text(
                        'Todo', // Customize this part
                        style: TextStyle(fontSize: 18, color: Colors.orange),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'coding on mondays',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Due - ',
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          ),
                          Text(
                            '23/09/23',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Text(
                        '10:23',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
