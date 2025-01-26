import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:startcomm/common/constants/app_texts.dart';
import 'package:startcomm/common/widgets/custom_circular_progress_indicator.dart';
import 'package:startcomm/features/home/home_controller.dart';
import 'package:startcomm/features/home/home_state.dart';
import 'package:startcomm/locator.dart';
import '../../common/constants/app_colors.dart';
import '../../common/extensions/sizes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double get textScaleFactor =>
      MediaQuery.of(context).size.width < 360 ? 0.7 : 1.0;
  double get iconSize => MediaQuery.of(context).size.width < 360 ? 16.0 : 24.0;

  final controller = locator.get<HomeController>();

  @override
  void initState() {
    super.initState();
    controller.getAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: AppColors.greenGradient,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(500, 30),
                  bottomRight: Radius.elliptical(500, 30),
                ),
              ),
              height: 287.h,
            ),
          ),
          Positioned(
              left: 24.0,
              right: 24.0,
              top: 74.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Olá',
                        style: AppTextsStyles.smallText.copyWith(
                          color: AppColors.white,
                          fontSize: AppTextsStyles.smallText.fontSize! *
                              textScaleFactor,
                        ),
                      ),
                      Text(
                        'Empresa',
                        style: AppTextsStyles.mediumText20.copyWith(
                          color: AppColors.white,
                          fontSize: AppTextsStyles.mediumText20.fontSize! *
                              textScaleFactor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 8.w,
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      color: AppColors.white.withAlpha((0.06 * 255).toInt()),
                    ),
                    child: Stack(
                      alignment: const AlignmentDirectional(0.5, -0.5),
                      children: [
                        const Icon(
                          Icons.person_outline_rounded,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          Positioned(
            left: 24.w,
            right: 24.w,
            top: 155.h,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 32.h,
              ),
              decoration: const BoxDecoration(
                color: AppColors.darkGreen,
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Saldo em conta',
                            style: AppTextsStyles.mediumText16w600.copyWith(
                              color: AppColors.white,
                              fontSize:
                                  AppTextsStyles.mediumText16w600.fontSize! *
                                      textScaleFactor,
                            ),
                          ),
                          Text(
                            'R\$ 1.000,00',
                            style: AppTextsStyles.mediumText30.copyWith(
                              color: AppColors.white,
                              fontSize: AppTextsStyles.mediumText30.fontSize! *
                                  textScaleFactor,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => log('options'),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 8.w,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                            color:
                                AppColors.white.withAlpha((0.06 * 255).toInt()),
                          ),
                          child: PopupMenuButton(
                            padding: EdgeInsets.zero,
                            child: const Icon(
                              Icons.bar_chart_outlined,
                              color: AppColors.white,
                            ),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                height: 24.0,
                                child: Text("Item 1"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 36.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: AppColors.white
                                  .withAlpha((0.1 * 255).toInt()),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                            ),
                            child: Icon(
                              Icons.info_outline,
                              color: AppColors.white,
                              size: iconSize,
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Receitas',
                                style: AppTextsStyles.mediumText16w500.copyWith(
                                  color: AppColors.white,
                                  fontSize: AppTextsStyles
                                          .mediumText16w500.fontSize! *
                                      textScaleFactor,
                                ),
                              ),
                              Text(
                                'R\$ 1.500,00',
                                style: AppTextsStyles.mediumText20.copyWith(
                                  color: AppColors.white,
                                  fontSize:
                                      AppTextsStyles.mediumText20.fontSize! *
                                          textScaleFactor,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: AppColors.white
                                  .withAlpha((0.1 * 255).toInt()),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                            ),
                            child: Icon(
                              Icons.settings,
                              color: AppColors.white,
                              size: iconSize,
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Despesas',
                                style: AppTextsStyles.mediumText16w500.copyWith(
                                  color: AppColors.white,
                                  fontSize: AppTextsStyles
                                          .mediumText16w500.fontSize! *
                                      textScaleFactor,
                                ),
                              ),
                              Text(
                                'R\$ 500,00',
                                style: AppTextsStyles.mediumText20.copyWith(
                                  color: AppColors.outcome,
                                  fontSize:
                                      AppTextsStyles.mediumText20.fontSize! *
                                          textScaleFactor,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 397.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Últimas transações',
                        style: AppTextsStyles.mediumText18,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AnimatedBuilder(
                      animation: controller,
                      builder: (context, _) {
                        if (controller.state is HomeStateLoading) {
                          return const CustomCircularProgressIndicator(
                            color: AppColors.green,
                          );
                        }
                        if (controller.state is HomeStateError) {
                          return const Center(
                            child: Text('Erro ao carregar transações.'),
                          );
                        }
                        if (controller.transactions.isEmpty) {
                          return const Center(
                            child: Text('Não há transações no momento.'),
                          );
                        }
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: controller.transactions.length,
                          itemBuilder: (context, index) {
                            final item = controller.transactions[index];

                            final color = item.value.isNegative
                                ? AppColors.outcome
                                : AppColors.income;
                            final value = "\$ ${item.value.toStringAsFixed(2)}";
                            return ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              leading: Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.antiFlashWhite,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: const Icon(
                                  Icons.monetization_on_outlined,
                                ),
                              ),
                              title: Text(
                                item.title,
                                style: AppTextsStyles.mediumText16w500,
                              ),
                              subtitle: Text(
                                DateTime.fromMillisecondsSinceEpoch(item.date)
                                    .toString(),
                                style: AppTextsStyles.smallText13,
                              ),
                              trailing: Text(
                                value,
                                style: AppTextsStyles.mediumText18
                                    .apply(color: color),
                              ),
                            );
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
