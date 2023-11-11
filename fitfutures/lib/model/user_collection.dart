import 'package:fitfutures/model/base/a_base_entity.dart';
import 'package:fitfutures/model/token.dart';
import 'package:fitfutures/model/user_token.dart';

class UserCollection extends BaseEntity {
  String name;
  String reward;
  List<Token> tokens;
  List<UserToken> userTokens;

  UserCollection(
      {required int id,
      required this.name,
      required this.reward,
      required this.tokens,
      required this.userTokens})
      : super(id: id);

  factory UserCollection.fromJson(Map<String, dynamic> json) {
    List<dynamic> tokensData = json['tokens'] ?? [];
    List<Token> tokensList = tokensData.map((tokenData) {
      return Token.fromJson(tokenData);
    }).toList();

    List<dynamic> userTokensData = json['userOwnedTokens'] ?? [];
    List<UserToken> userTokensList = userTokensData.map((userTokenData) {
      return UserToken.fromJson(userTokenData);
    }).toList();

    return UserCollection(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      reward: json['reward'] ?? '',
      tokens: tokensList,
      userTokens: userTokensList,
    );
  }
}
