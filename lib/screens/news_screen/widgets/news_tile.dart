import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../web_view_screen/webview_screen.dart';
import '../models/news_model.dart';


class NewsTile extends StatelessWidget {
  final NewsItem item;
  const NewsTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.imageUrl != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                item.imageUrl!,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),
          ListTile(
            title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item.description, maxLines: 2, overflow: TextOverflow.ellipsis),
            trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Theme.of(context).primaryColor),
            onTap: () => Get.to(() => WebViewScreen(url: item.link, title: item.title)),
          ),
        ],
      ),
    );
  }
}
