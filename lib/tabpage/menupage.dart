import 'package:cash_register_app/database/item_infos.dart';
import 'package:cash_register_app/pages/confirm_ordering_page.dart';
import 'package:cash_register_app/showDialog/showDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../image/image_asset.dart';


class Menu_page extends HookConsumerWidget {
  const Menu_page({super.key});

  ///注文内容確認ページへの遷移メソッド
  void moveConfirmOrderingPage(BuildContext context) => {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const ConfirmOrderingPage()
    ))
  };

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(

      body:
      Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0), //外周の余白
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,     //ボックス左右間のスペース
            mainAxisSpacing: 10,      //ボックス上下間のスペース
            crossAxisCount: 2,        //ボックスを横に並べる数
          ),
          itemCount: itemInfos.getList().where((iteminfo) => iteminfo.category == "drink").length, //要素数
          //指定した要素の数分を生成
          itemBuilder: (context, index) {
            final List<ItemInfo> drinkinfolist = itemInfos.getList().where((iteminfo) => iteminfo.category == "drink").toList() ;
            final ItemInfo drinkinfo = drinkinfolist[index];

            return Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3, //影の大きさ
                    foregroundColor: Colors.grey.withAlpha(100), //ボタンを押下時のエフェクト色と文字色(子要素で上書き可能)
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)) //角ばったボタン、数値を上げると丸くなる
                    ),
                  ),
                  onPressed: () {
                  showCustomDialog(context,ref,drinkinfo);
                  }, //押下時ポップアップ
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: Text(
                        drinkinfo.itemName,
                        style: TextStyle(
                          color: Colors.black,fontSize: 12.sp, //テキストの色

                        ),
                      ),
                    ),
                    Expanded(child: ItemImg(itemName: drinkinfo.itemName, size: 120)),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: Text(
                        '${NumberFormat("#,###").format(drinkinfo.itemPrice)}円',
                        style: TextStyle(
                          color: Colors.black,fontSize: 15.sp, ),
                      ),
                    ),
                  ],
                ),

              ),


            );
          },
        ),

      ),
    );
  }
}