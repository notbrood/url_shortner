import 'package:http/http.dart' as http;

Future<String> getUrl(String? custom, String url) async{
  var client = http.Client();
  var uri;
  if(custom == ""){
    uri = Uri.parse("https://ulvis.net/api.php?url=$url");
  }
  else{
    uri = Uri.parse("https://ulvis.net/api.php?url=$url&custom=$custom");
  }
  var response = await client.get(uri);
  if(response.statusCode == 200){
    return response.body;
  }
  else{
    return 'There was an error!';
  }
}