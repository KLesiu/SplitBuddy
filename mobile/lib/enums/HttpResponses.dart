enum HttpResponses {
  success('Success'),
  failed('Failed');

  final String message;

  const HttpResponses(this.message);
}