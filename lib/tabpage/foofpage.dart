import 'package:cash_register_app/pages/confirm_ordering_page.dart';
import 'package:cash_register_app/showDialog/showDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../database/item_infos.dart';
import '../image/image_asset.dart';



class Food_page extends HookConsumerWidget {
  const Food_page({super.key});

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
          itemCount: itemInfos.getList().where((iteminfo) => iteminfo.category == "food").length, //要素数
          //指定した要素の数分を生成
          itemBuilder: (context, index) {
            final List<ItemInfo> foodinfolist = itemInfos.getList().where((iteminfo) => iteminfo.category == "food").toList() ;
            final ItemInfo foodinfo = foodinfolist[index];

            return Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3, //影の大きさ
                    foregroundColor: Colors.grey.withAlpha(10), //ボタンを押下時のエフェクト色と文字色(子要素で上書き可能)
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)) //角ばったボタン、数値を上げると丸くなる
                    ),
                  ),
                  onPressed: () {
                    showCustomDialog(context,ref,foodinfo);
                  }, //押下時
                child: Column(
                  children:[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: Text(
                        foodinfo.itemName,
                        style: TextStyle(
                          color: Colors.black,fontSize: 12.sp, //テキストの色
                        ),
                      ),
                    ),

                    Expanded(child: ItemImg(itemName: foodinfo.itemName, size: 120)),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: Text(
                        '${NumberFormat("#,###").format(foodinfo.itemPrice)}円〜',
                        style: TextStyle(
                          color: Colors.black,fontSize: 15.sp, ),
                      ),
                    ),

                  ],
                ),
                  // ポップアップ
                  // child: const Text( //buttonの中身、商品名や画像、値段など
                  //   "button",
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontSize: 20,
                  //   ),
                  // )
              ),
            );
          },
        ),

      ),
    );

    //**邪魔だったり必要なかったらコメントアウト(コードの先頭に//をつける)してね**//
    floatingActionButton: FloatingActionButton(
      onPressed: () { moveConfirmOrderingPage(context); },
      tooltip: "デバッグ用遷移ボタン\n邪魔だったら消してね",
      child: const Icon(Icons.arrow_right_alt),
    );
    //********************************************************************/
  }
}