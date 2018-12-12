import 'package:dart_lab/main.dart' as production;

//use this file during development as entry point
void main() {
  //set test credentials and host name
  final host = 'https://gitlab.com';
  final privateToken = '123123123123123';
  production.main([host, privateToken]);
}