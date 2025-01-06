enum HttpResponses {
  success('Success'),
  failed('Failed'),
  unauthorized("Unauthorized");

  final String message;

  const HttpResponses(this.message);
}