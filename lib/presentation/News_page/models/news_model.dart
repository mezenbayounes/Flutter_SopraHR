//while the app is building let's create the NewsData class

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
        "https://www.soprasteria.com/images/librariesprovider2/sopra-steria-corporate-images/banner-inner-and-carousel-(1560x515)/banner_cea_soprasteria.jpg?sfvrsn=86f45fdb_3"),
    NewsData(
        "Sopra Steria positioned as AI technology leader by Quadrant Knowledge Solutions!",
        "Sopra Steria positioned as AI technology leader",
        "Sopra Steria has been positioned as a 2024 AI technology leader in the SPARK Matrix™ analysis of the global Artificial Intelligence Services market.",
        "May 21, 2024",
        "https://www.soprasteria.com/images/librariesprovider2/sopra-steria-benelux-images/banner-3d2053334e7fd6c36b458ff000034b0d9.jpg?sfvrsn=caf85fdb_2"),
    NewsData(
        "IVèS, Sopra Steria, and IBM Join Forces to Create the World's First Conversational Assistant in Sign Language",
        "the World's First Conversational Assistant in Sign Language",
        "Named IRIS, the world's first signbot combines the power of AI solutions from all three tech players to enable digital sign language communication.",
        "May 21, 2024",
        "https://fiverr-res.cloudinary.com/videos/t_main1,q_auto,f_auto/gm9wicrhjhw2aev5jusi/create-and-edit-your-synthesia-ai-avatar-videos.png"),
  ];

  static List<NewsData> recentNewsData = [
    NewsData(
        "Sopra Steria and the CEA, towards a strategic alliance",
        "Sopra Steria and the CEA",
        "Sopra Steria and the CEA have announced their intention to form a strategic alliance in the defense and security sector. ",
        "Jun 21, 2024",
        "https://www.soprasteria.com/images/librariesprovider2/sopra-steria-corporate-images/banner-inner-and-carousel-(1560x515)/banner_cea_soprasteria.jpg?sfvrsn=86f45fdb_3"),
    NewsData(
        "Sopra Steria Next adds Copilot for Microsoft 365 ",
        "Sopra Steria Next adds Copilot for Microsoft 365",
        "Sopra Steria Next harnesses the arrival of Copilot for Microsoft 365 to speed up the adoption of generative artificial intelligence. ",
        "Jul 11, 2024",
        "https://licendi.com/media/wysiwyg/Microsoft_365.jpg"),
    NewsData(
        "Sopra Steria positioned as AI technology leader by Quadrant Knowledge Solutions!",
        "Sopra Steria positioned as AI technology leader",
        "Sopra Steria has been positioned as a 2024 AI technology leader in the SPARK Matrix™ analysis of the global Artificial Intelligence Services market.",
        "May 21, 2024",
        "https://www.soprasteria.com/images/librariesprovider2/sopra-steria-benelux-images/banner-3d2053334e7fd6c36b458ff000034b0d9.jpg?sfvrsn=caf85fdb_2"),
    NewsData(
        "the World's First Conversational Assistant in Sign Language",
        "the World's First Conversational Assistant in Sign Language",
        "Named IRIS, the world's first signbot combines the power of AI solutions from all three tech players to enable digital sign language communication.",
        "May 21, 2024",
        "https://fiverr-res.cloudinary.com/videos/t_main1,q_auto,f_auto/gm9wicrhjhw2aev5jusi/create-and-edit-your-synthesia-ai-avatar-videos.png"),
  ];
}
