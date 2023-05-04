class AppwriteConstants{
  static const String databaseID="644bb07808c3f831018b";
  static const String projectID="644bab3b35742f6c9bf4";
  static const String userCollection="644f40437898c07ffb74";
  static const String tweetCollection="644fb93c2c7dc63726d3";
  static const String imagesBucket = '644fe02851e38100a29c';
  static const String endPoint="http://192.168.0.104/v1";
  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectID&mode=admin';
}