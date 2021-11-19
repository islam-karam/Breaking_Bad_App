class Quote{
  String quote;

  Quote.fromJason(Map<String, dynamic>jason){
    quote = jason['quote'];
  }
}