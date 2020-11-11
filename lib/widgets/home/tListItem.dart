import 'package:expenseTracker/Model/transaction.dart';
import 'package:expenseTracker/Provider/transactionProvider.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TListItem extends StatelessWidget {
  final Transaction e;
  final Function cV;
  const TListItem({Key key, this.e, this.cV}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Dismissible(
        background: Container(
          color: Colors.red,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 16,
              ),
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              )
            ],
          ),
        ),
        direction: DismissDirection.startToEnd,
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Are You Sure?'),
                content: Text('Do you want to delete this transaction?'),
                elevation: 20,
                actions: <Widget>[
                  FlatButton.icon(
                    onPressed: () {
                      cV(false);
                      Navigator.of(context).pop(false);
                    },
                    icon: Icon(Icons.clear),
                    label: Text('No'),
                  ),
                  FlatButton.icon(
                    onPressed: () {
                      Provider.of<TransactionProvider>(context, listen: false)
                          .delete(e.date);
                      cV(true);
                      Navigator.of(context).pop(true);
                    },
                    icon: Icon(Icons.check),
                    label: Text('Yes'),
                  ),
                ],
              );
            },
          );
        },
        key: Key(e.date.toString()),
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(
                IconData(
                  e.icon,
                  fontFamily: e.iconFamily,
                  fontPackage: e.iconPackage,
                ),
                color: Colors.white,
                size: 22,
              ),
              backgroundColor: e.transactionType == TransactionType.Income
                  ? Colors.green
                  : Colors.lightBlue,
              radius: 28,
            ),
            title: Text(e.title),
            subtitle: Text(DateFormat.yMMMd().add_jm().format(e.date)),
            trailing: Text('₹ ${e.amount.toString()}'),
          ),
        ),
      ),
    );
  }
}
