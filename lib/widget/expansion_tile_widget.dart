import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpansionTileWidget extends StatelessWidget {
  final String? leading;
  final String title;
  final String area;
  final String? fathersName;
  final String type;
  final IconData? icon;
  final String? contact;
  final String? amount;
  final VoidCallback edit;
  final VoidCallback delete;
  
  const ExpansionTileWidget({
    super.key,
    this.leading,
    required this.title,
    required this.area,
    this.fathersName,
    required this.type,
    this.icon,
    this.contact,
    this.amount,
    required this.edit,
    required this.delete
  });

  @override
  Widget build(BuildContext context) => ExpansionTile(
    leading: Container(
      padding: const EdgeInsets.all(4.0),
      height: 54,
      width: 54,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(color: Colors.grey),
      ),
      child: Center(
        child: Text(
          leading!,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        )
      ),
    ),
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: Row(
      children: [
        if (fathersName != null && fathersName!.isNotEmpty)
        Text(
          type == 'customer' ? "Father : ${fathersName!}" : "Institute : ${fathersName!}",
          style: const TextStyle(fontSize: 10.0),
        ),
        const SizedBox(width: 14.0),
        Text(
          'Area : $area',
          style: const TextStyle(fontSize: 10.0)
        )
      ],
    ),
    shape: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Colors.grey)
    ),
    children: [
      buildTile(),
      buildTileIcon()
    ],
  );

  Widget buildTile() => Padding(
    padding: const EdgeInsets.only(left: 18.0, top: 18.0, right: 18.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () async {
                final Uri phoneUri = Uri(scheme: 'tel', path: contact);

                if (await canLaunchUrl(phoneUri)) {
                  await launchUrl(phoneUri);
                } else {
                  
                }
              },
              icon: Icon(
                icon,
                size: 12,
              ),
            ),
            const SizedBox(width: 8.0),
            SelectableText(
              contact!,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
        Text(
          amount!,
          style: const TextStyle(
            color: Color(0xff730505),
            fontSize: 14,
            fontWeight: FontWeight.bold
          ),
        )
      ],
    ),
  );

  Widget buildTileIcon() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: edit,
          icon: const SizedBox(
            height: 48,
            width: 48,
            child: Column(
              children: [
                Icon(Icons.edit_note),
                Text(
                  'Edit',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ),
        IconButton(
          onPressed: delete,
          icon: const SizedBox(
            height: 48,
            width: 48,
            child: Column(
              children: [
                Icon(Icons.delete, color: Colors.red),
                Text(
                  'Delete',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        )
      ],
    ),
  );
}
