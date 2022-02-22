import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satya_sai/constants/constants.dart';
import 'package:satya_sai/generated/l10n.dart';
import 'package:satya_sai/model_class/exhibit_model.dart';
import 'package:satya_sai/provider/selected_exhibit_provider.dart';

class ListCard extends StatelessWidget {
  final ExhibitModel exhibit;
  const ListCard({Key? key,required this.exhibit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Container(
        height: 90,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: white,
            boxShadow: [
              BoxShadow(
                color: textHeadingColor.withAlpha(20),
                blurRadius: 2, // soften the shadow
                spreadRadius: 1, //extend the shadow
              )
            ]),
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: ListTile(
            tileColor: Colors.red,
            onTap: () {
              Provider.of<SelectedExhibitProvider>(context,listen:false).setCurrentExhibit(exhibit.zones[0]);
              Navigator.pushNamed(context, '/DetailedZone',arguments: exhibit);
            },
            leading:
            // Hero(
            //   tag: uuid.v4(),
            //   child:
            //   child:
            SizedBox(
                width: 70,
                height: 70,
                child: Image.asset(
                  exhibit.zoneImage,
                  width: 50,
                  height: 50,
                )),
            // ),
            title: Text(
              exhibit.zoneName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.watch_later_outlined,
                  size: 15,
                ),
                const SizedBox(width: 5),
                Text(
                  '10 '+S.of(context).min,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
            minVerticalPadding: 3,
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      );
  }
}
