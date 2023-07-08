



class PushMessage{
  final String messageId;
  final String title;
  final String body;
  final DateTime senDate;
  final Map<String, dynamic>? data;
  final String? imageUrl;

  PushMessage({
    required this.messageId,
    required this.title, 
    required this.body, 
    required this.senDate, 
    required this.data,
    required this.imageUrl, 

  });

@override
String toString(){
  return '''
    PushMessage -
   id: $messageId  
   title: $title 
   body: $body
   senDate: $senDate 
   data:$data
   imageUrl:$imageUrl
''';
}
}