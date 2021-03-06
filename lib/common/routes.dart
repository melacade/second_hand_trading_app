import 'package:flutter/material.dart';
import 'package:second_hand_trading_app/view/DetailPage.dart';
import 'package:second_hand_trading_app/view/add_new_goods.dart';
import 'package:second_hand_trading_app/view/add_new_security_problem.dart';
import 'package:second_hand_trading_app/view/add_payment.dart';
import 'package:second_hand_trading_app/view/address_list.dart';
import 'package:second_hand_trading_app/view/comments_list.dart';
import 'package:second_hand_trading_app/view/goods_detail_page.dart';
import 'package:second_hand_trading_app/view/login_page.dart';
import 'package:second_hand_trading_app/view/lost_and_found.dart';
import 'package:second_hand_trading_app/view/main_page.dart';
import 'package:second_hand_trading_app/view/order_detail.dart';
import 'package:second_hand_trading_app/view/order_list.dart';
import 'package:second_hand_trading_app/view/register_page.dart';
import 'package:second_hand_trading_app/view/reset_account.dart';
import 'package:second_hand_trading_app/view/reset_password.dart';
import 'package:second_hand_trading_app/view/reset_payment.dart';
import 'package:second_hand_trading_app/view/reset_security_problems.dart';
import 'package:second_hand_trading_app/view/search_page.dart';
import 'package:second_hand_trading_app/view/security_center.dart';
import 'package:second_hand_trading_app/view/show_images.dart';
import 'package:second_hand_trading_app/view/splash_page.dart';
import 'package:second_hand_trading_app/view/user_info_page.dart';

class Routes {
  static const String splashPage = "/";
  static const String mainPage = "/main/mainPage";
  static const String searchPage = "/searchPage";
  static const String loginPage = "/loginPage";
  static const String detailPage = "/detailPage";
  static const String userInofPage = "/userInfoPage";
  static const String registerPage = "/registerPage";

  static const String resetPassword = "";

  static const String addNewSecurityProblem = "/addNewSecurityProblem";

  static const String resetAccount = "/resetAccount";

  static const String securityCenter = "/securityCenter";

  static const String resetSecurityProblems = "/resetSecurityProblems";

  static const String addPayment = "/addPayment";

  static const String resetPayment = "/resetPayment";

  static const String lostAndFound = "/lostAndFound";

  static const String addNewGoods = "/addNewGoods";

  static const String showImages = "/showImages";

  static const String goodsDetail = "/goodsDetail";

  static const String addressList = "/addressList";

  static const String orderDetail = "/orderDetail";

  static const String orderList = "/orderList";
  static const String commentsList = "/commentsList";

  static Route findRoutes(RouteSettings settings) {
    final String name = settings.name;
    return MaterialPageRoute(builder: (_) {
      return _findPage(name, settings.arguments);
    });
  }

  static Widget _findPage(String name, dynamic arguments) {
    Widget page;
    switch (name) {
      case splashPage:
        page = SplashPage();
        break;
      case mainPage:
        page = MainPage();
        break;
      case searchPage:
        page = SearchPage(
          searchText: arguments,
        );
        break;
      case loginPage:
        page = LoginPage();
        break;
      case detailPage:
        page = DetailPage(arguments);
        break;

      case userInofPage:
        page = UserInfoPage();
        break;
      case registerPage:
        page = RegisterPage();
        break;
      case addNewSecurityProblem:
        page = AddNewSecurityProblem();
        break;
      case resetAccount:
        page = ResetAccount(
          args: arguments,
        );
        break;
      case securityCenter:
        page = SecurityCenter();
        break;
      case resetPassword:
        page = ResetPassword(
          args: arguments,
        );
        break;
      case resetSecurityProblems:
        page = ResetSecurityProblems();
        break;
      case addPayment:
        page = AddPayment();
        break;
      case resetPayment:
        page = ResetPayment();
        break;
      case lostAndFound:
        page = LostAndFound();
        break;
      case addNewGoods:
        page = AddNewGoods();
        break;
      case showImages:
        page = ShowImages(
          arguments['model'],
          index: arguments['index'],
        );
        break;
      case goodsDetail:
        page = GoodsDetailPage(
          goodsId: arguments,
        );
        break;
      case addressList:
        page = AddressList(select: arguments);
        break;
      case orderDetail:
        page = OrderDetail(arguments);
        break;
      case orderList:
        page = OrderList(status: arguments);
        break;

      case commentsList:
        page = CommentsList(args: arguments,);
        break;
        
      default:
        page = MainPage();
    }
    return page;
  }
}
