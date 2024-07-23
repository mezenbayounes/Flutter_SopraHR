//while the app is building let's create the NewsData class

import 'package:sopraflutter/core/constants/constants.dart';

class NewsData {
  String? title;
  String? author;
  String? content;
  String? urlToImage;
  String? date;

  //let's create the constructor
  NewsData(
    this.title,
    this.author,
    this.content,
    this.date,
    this.urlToImage,
  );

  //we will use dummy data to generate the news,but you can use a third party api or your own backend to extract the data
  //I will copy the data from my previous code, you can create your own data , I used newsApi to get the data
  static List<NewsData> breakingNewsData = [
    NewsData(
        "Sopra Steria and the CEA, towards a strategic alliance",
        "Sopra Steria and the CEA",
        "Sopra Steria and the CEA have announced their intention to form a strategic alliance in the defense and security sector. ",
        "Jun 21, 2024",
        "$baseUrl/assets/CEA.jpg"),
    NewsData(
        "Sopra Steria positioned as AI technology leader by Quadrant Knowledge Solutions!",
        "Sopra Steria positioned as AI technology leader",
        "Sopra Steria has been positioned as a 2024 AI technology leader in the SPARK Matrix™ analysis of the global Artificial Intelligence Services market.",
        "May 21, 2024",
        "$baseUrl/assets/AI.jpg"),
    NewsData(
        "IVèS, Sopra Steria, and IBM Join Forces to Create the World's First Conversational Assistant in Sign Language",
        "the World's First Conversational Assistant in Sign Language",
        "Named IRIS, the world's first signbot combines the power of AI solutions from all three tech players to enable digital sign language communication.",
        "May 21, 2024",
        "$baseUrl/assets/EVIS.png"),
  ];

  static List<NewsData> recentNewsData = [
    NewsData(
        "Sopra Steria and the CEA, towards a strategic alliance",
        "Sopra Steria and the CEA",
        "Sopra Steria and the CEA have announced their intention to form a strategic alliance in the defense and security sector. ",
        "Jun 21, 2024",
        "$baseUrl/assets/CEA.jpg"),
    NewsData(
        "Sopra Steria Next adds Copilot for Microsoft 365 ",
        "Sopra Steria Next adds Copilot for Microsoft 365",
        "Sopra Steria Next harnesses the arrival of Copilot for Microsoft 365 to speed up the adoption of generative artificial intelligence. ",
        "Jul 11, 2024",
        "$baseUrl/assets/mic.jpg"),
    NewsData(
        "Sopra Steria positioned as AI technology leader by Quadrant Knowledge Solutions!",
        "Sopra Steria positioned as AI technology leader",
        "Sopra Steria has been positioned as a 2024 AI technology leader in the SPARK Matrix™ analysis of the global Artificial Intelligence Services market.",
        "May 21, 2024",
        "$baseUrl/assets/AI.jpg"),
    NewsData(
        "the World's First Conversational Assistant in Sign Language",
        "the World's First Conversational Assistant in Sign Language",
        "Named IRIS, the world's first signbot combines the power of AI solutions from all three tech players to enable digital sign language communication.",
        "May 21, 2024",
        "$baseUrl/assets/EVIS.png"),
  ];
}
