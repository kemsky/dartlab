import 'package:meta/meta.dart';
import 'package:dart_lab/webapi/api.configuration.dart';

abstract class ApiClass {
  final Configuration Config;

  @protected
  ApiClass(this.Config);

  @protected
  String createUrl() {
    if (this.Config.IsSecure) {
      return 'https://${this.Config.Host}/api/v4/';
    } else {
      return 'http://${this.Config.Host}/api/v4/';
    }
  }

  @protected
  Map<String, String> createHeaders() {
    return {
      'Private-Token': this.Config.PersonalToken,
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
  }
}
