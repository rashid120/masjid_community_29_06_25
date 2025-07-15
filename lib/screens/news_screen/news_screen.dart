import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masjid_community_29_06_25/screens/news_screen/widgets/news_tile.dart';
import 'news_view_model.dart';

class NewsScreen extends StatelessWidget {

  NewsScreen({super.key});

  final NewsScreenController controller = Get.put(NewsScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Al Jazeera News")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.newsList.isEmpty) {
          return const Center(child: Text("No news found"));
        }
        return RefreshIndicator(
          onRefresh: controller.fetchNews,
          child: ListView.builder(
            itemCount: controller.newsList.length,
            itemBuilder: (context, index) => NewsTile(item: controller.newsList[index]),
          ),
        );
      }),
    );
  }
}