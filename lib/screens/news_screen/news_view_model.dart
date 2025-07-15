import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'models/news_model.dart';

class NewsScreenController extends GetxController {
  var newsList = <NewsItem>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }

  Future<void> fetchNews() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse('https://www.aljazeera.com/xml/rss/all.xml'));
      if (response.statusCode == 200) {
        final document = xml.XmlDocument.parse(response.body);
        final items = document.findAllElements('item');
        newsList.value = items.map((item) {
          final mediaContent = item.findElements("media:content").isNotEmpty
              ? item.findElements("media:content").first.getAttribute("url")
              : null;

          // print('test doc images = $mediaContent');
          return NewsItem(
            title: item.getElement('title')?.text ?? '',
            link: item.getElement('link')?.text ?? '',
            description: item.getElement('description')?.text ?? '',
            pubDate: item.getElement('pubDate')?.text ?? '',
            imageUrl: mediaContent,
          );
        }).toList();
      }
    } catch (e) {
      print("Error fetching news: $e");
    } finally {
      isLoading.value = false;
    }
  }
}