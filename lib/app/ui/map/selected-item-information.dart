import 'package:coronavirushelp/app/model/demand.dart';
import 'package:coronavirushelp/app/ui/demand-detail-page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectedItemInformation extends StatefulWidget {
  SelectedItemInformation({Key key, this.demand}) : super(key: key);

  final Demand demand;
  @override
  _SelectedItemInformationState createState() =>
      _SelectedItemInformationState();
}

class _SelectedItemInformationState extends State<SelectedItemInformation> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          fit: FlexFit.tight,
          child: Padding(
            padding: const EdgeInsets.only(left: 35, top: 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  (widget.demand != null) ? widget.demand.title : '',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style:
                      TextStyle(color: Colors.redAccent.shade700, fontSize: 16),
                ),
                Text(
                  (widget.demand != null) ? widget.demand.description : '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      (widget.demand != null)
                          ? 'Demandé par : ' + widget.demand.demander.name
                          : '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                    ),
                  ],
                ),
                Expanded(
                  child: Text(
                    (widget.demand != null)
                        ? 'A faire pour le ' +
                            DateFormat('dd MMM à kk:mm')
                                .format(widget.demand.demandDatetime)
                        : '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 100,
          child: FlatButton(
            child: Row(
              children: <Widget>[Text("Voir"), Icon(Icons.chevron_right)],
            ),
            onPressed: _help,
          ),
        )
      ],
    );
  }

  void _help() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DemandDetailPage(demand: widget.demand)),
    );
  }
}
