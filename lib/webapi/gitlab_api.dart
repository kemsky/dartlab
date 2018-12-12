library gitlab_api;

import 'package:dart_lab/webapi/model/gitlab_current_user.dart';
import 'package:dart_lab/webapi/model/http_method.dart';
import 'package:dart_lab/webapi/rest_client.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

class GitLabApi extends RestClient {

  static final Logger _logger = new Logger('GitLabApi');

  GitLabApi(String host, String token) : super(host, headers: {'Private-Token': token});

  Observable<GitLabCurrentUser> getCurrentUser() {
    final request = this.request(HttpMethod.get);

    request.path.update((path){
      path.add('user');
    });

    return this.execute(request)
        .doOnData((response) {
          _logger.info(response.body);
        })
        .map((response) => parseJson(GitLabCurrentUser.serializer, response.body));
  }
}
