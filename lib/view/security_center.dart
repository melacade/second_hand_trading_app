import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/base/consts.dart';
import 'package:second_hand_trading_app/base/provider_wedget.dart';
import 'package:second_hand_trading_app/common/routes.dart';
import 'package:second_hand_trading_app/model/security_problems.dart';
import 'package:second_hand_trading_app/viewmodel/security_problem_view_model.dart';

class SecurityCenter extends StatefulWidget {
  @override
  _SecurityCenterState createState() => _SecurityCenterState();
}

class _SecurityCenterState extends State<SecurityCenter> {
  Widget _myListTitle(String title, {SecurityProblems problems}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: ListTile(
        leading: Icon(Icons.blur_on),
        title: Text(title),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          switch (title) {
            case "Add security problems":
              Navigator.pushNamed(context, Routes.addNewSecurityProblem);
              break;
            case "Revision of security problems":
              Navigator.pushNamed(context, Routes.resetAccount, arguments: {
                'action': Consts.changeSecurityProblem,
                'problems': problems
              });
              break;
            case "Change Password":
              if (problems == null) {
                Navigator.pushNamed(context, Routes.resetPassword);
              } else {
                Navigator.pushNamed(context, Routes.resetAccount, arguments: {
                  'action': Consts.changePassword,
                  'problems': problems
                });
              }

              break;
            case "Change payment password":
              Navigator.pushNamed(context, Routes.resetAccount, arguments: {
                'action': Consts.resetPayment,
                'problems': problems
              });
              break;
            case "Add payment password":
              Navigator.pushNamed(context, Routes.resetAccount, arguments: {
                'action': Consts.addPayment,
                'problems': problems
              });
              break;
            default:
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security Center"),
      ),
      body: Column(
        children: [
        
          Image.asset("assets/images/shield.jpeg"),
          ProviderWidget<SecurityProblemViewModel>(
            model: SecurityProblemViewModel(),
            onReady: (model) {
              model.general();
            },
            builder: (context, model, child) {
              if (model.securityProblems.code == 200) {
                return Column(
                  children: [
                    _myListTitle("Revision of security problems",
                        problems: model.securityProblems),
                    model.has
                        ? _myListTitle("Change payment password",
                            problems: model.securityProblems)
                        : _myListTitle("Add payment password",
                            problems: model.securityProblems),
                    _myListTitle("Change Password",
                        problems: model.securityProblems),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _myListTitle("Add security problems"),
                    _myListTitle("Change Password")
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
