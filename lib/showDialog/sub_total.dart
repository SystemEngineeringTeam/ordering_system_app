
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../provider/amount_per_item.dart';
import '../provider/countprovider.dart';




class SubTotalWidget extends HookConsumerWidget {
  const SubTotalWidget({super.key});



  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final amountPer = ref.watch(amountPerItemProvider);
    final counter = ref.watch(counterProvider);
    final subTotal = amountPer * counter;

    print('amount222:$amountPer');
    // CounterProviderを取得
    // final counterProvider = Provider.of<CounterProvider>(context);

    return
    Container(
      child: Text('${NumberFormat("#,###").format(subTotal)}円', style: TextStyle(fontSize: 25.sp, height: 1.sp),),
    );
  }
}