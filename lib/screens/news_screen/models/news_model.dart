class NewsItem {
  final String title;
  final String link;
  final String description;
  final String pubDate;
  final String? imageUrl;

  NewsItem({
    required this.title,
    required this.link,
    required this.description,
    required this.pubDate,
    this.imageUrl,
  });
}