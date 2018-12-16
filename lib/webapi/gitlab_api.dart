library gitlab_api;

import 'package:dart_lab/webapi/model/gitlab_current_user.dart';
import 'package:dart_lab/webapi/model/http_method.dart';
import 'package:dart_lab/webapi/rest_client.dart';
import 'package:logging/logging.dart';
import 'package:quiver/core.dart';
import 'package:rxdart/rxdart.dart';

class GitLabApi extends RestClient {
  static final Logger _logger = new Logger('GitLabApi');

  GitLabApi(String host, String token) : super(host, headers: {'Private-Token': token});

  Observable<Optional<GitLabCurrentUser>> getCurrentUser() {
    final request = this.request(HttpMethod.get);

    request.path.update((path) {
      path.add('user');
    });

    return this.execute(request).map((response) => Optional.of(parseJson(GitLabCurrentUser.serializer, response.body))).onErrorResume((e) {
      _logger.info('error: $e');
      return Observable.just(Optional<GitLabCurrentUser>.absent());
    });
  }
}
