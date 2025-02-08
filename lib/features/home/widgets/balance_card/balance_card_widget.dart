// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:startcomm/common/constants/app_texts.dart';
// import 'package:startcomm/features/home/widgets/balance_card/balance_card_widget_controllers.dart';
// import '../../../../common/constants/app_colors.dart';
// import '../../../../common/extensions/sizes.dart';
// import 'balance_card_widget_state.dart';

// class BalanceCard extends StatelessWidget {
//   const BalanceCard({
//     super.key,
//     required this.controller,
//   });

//   final BalanceCardWidgetController controller;

//   @override
//   Widget build(BuildContext context) {

//     return Positioned(
//       left: 24.w,
//       right: 24.w,
//       top: 155.h,
//       child: Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: 24.w,
//           vertical: 32.h,
//         ),
//         decoration: const BoxDecoration(
//           color: AppColors.darkGreen,
//           borderRadius: BorderRadius.all(
//             Radius.circular(16.0),
//           ),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Valor Total',
//                       style: AppTextStyles.mediumText16w600
//                           .apply(color: AppColors.white),
//                     ),
//                     AnimatedBuilder(
//                         animation: controller,
//                         builder: (context, _) {
//                           if (controller.state
//                               is BalanceCardWidgetStateLoading) {
//                             return Container(
//                               color: AppColors.greenTwo,
//                               constraints:
//                                   BoxConstraints.tightFor(width: 128.0.w),
//                               height: 48.0.h,
//                             );
//                           }
//                           return ConstrainedBox(
//                             constraints:
//                                 BoxConstraints.tightFor(width: 250.0.w),
//                             child: Text(
//                               'R\$ ${controller.balances.totalBalance.toStringAsFixed(2)}',
//                               style: AppTextStyles.mediumText30
//                                   .apply(color: AppColors.white),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           );
//                         })
//                   ],
//                 ),
//                 GestureDetector(
//                   onTap: () => log('options'),
//                   child: PopupMenuButton(
//                     padding: EdgeInsets.zero,
//                     child: const Icon(
//                       Icons.more_horiz,
//                       color: AppColors.white,
//                     ),
//                     itemBuilder: (context) => [
//                       const PopupMenuItem(
//                         height: 24.0,
//                         child: Text("Item 1"),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 36.h),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 AnimatedBuilder(
//                   animation: controller,
//                   builder: (context, _) {
//                     return TransactionValueWidget(
//                       amount: controller.balances.totalIncome,
//                       controller: controller,
//                     );
//                   },
//                 ),
//                 AnimatedBuilder(
//                   animation: controller,
//                   builder: (context, _) {
//                     return TransactionValueWidget(
//                       amount: controller.balances.totalOutcome,
//                       controller: controller,
//                       type: TransactionType.outcome,
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// enum TransactionType { income, outcome }

// class TransactionValueWidget extends StatelessWidget {
//   const TransactionValueWidget({
//     super.key,
//     required this.amount,
//     required this.controller,
//     this.type = TransactionType.income,
//   });
//   final BalanceCardWidgetController controller;
//   final double amount;
//   final TransactionType type;

//   @override
//   Widget build(BuildContext context) {

//     double iconSize = MediaQuery.of(context).size.width <= 360 ? 16.0 : 24.0;

//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(4.0),
//           decoration: BoxDecoration(
//             color: AppColors.white.withAlpha((0.06 * 255).toInt()),
//             borderRadius: const BorderRadius.all(
//               Radius.circular(16.0),
//             ),
//           ),
//           child: Icon(
//             type == TransactionType.income
//                 ? Icons.arrow_upward
//                 : Icons.arrow_downward,
//             color: AppColors.white,
//             size: iconSize,
//           ),
//         ),
//         const SizedBox(width: 4.0),
//         Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               type == TransactionType.income ? 'Receita' : 'Despesa',
//               style:
//                   AppTextStyles.mediumText16w500.apply(color: AppColors.white),
//             ),
//             AnimatedBuilder(
//                 animation: controller,
//                 builder: (context, _) {
//                   if (controller.state is BalanceCardWidgetStateLoading) {
//                     return Container(
//                       color: AppColors.greenTwo,
//                       constraints: BoxConstraints.tightFor(width: 80.0.w),
//                       height: 36.0.h,
//                     );
//                   }
//                   return ConstrainedBox(
//                     constraints: BoxConstraints.tightFor(width: 120.0.w),
//                     child: Text(
//                       'R\$ ${amount.toStringAsFixed(2)}',
//                       style: AppTextStyles.mediumText20
//                           .apply(color: AppColors.white),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   );
//                 }),
//           ],
//         )
//       ],
//     );
//   }
// }