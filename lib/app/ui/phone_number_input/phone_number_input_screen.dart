import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gongbab/app/router/app_routes.dart';
import 'package:gongbab/app/ui/phone_number_input/phone_number_input_view_model.dart';
import 'package:get_it/get_it.dart';

import '../select_name/fake_worker.dart';
import '../select_name/select_name_dialog.dart';

class PhoneNumberInputScreen extends StatefulWidget {
  const PhoneNumberInputScreen({super.key});

  @override
  State<PhoneNumberInputScreen> createState() => _PhoneNumberInputScreenState();
}

class _PhoneNumberInputScreenState extends State<PhoneNumberInputScreen> {
  String pin = '';
  final int pinLength = 4;
  late final PhoneNumberInputViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = GetIt.I<PhoneNumberInputViewModel>();
    _viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _viewModel.dispose();
    super.dispose();
  }

  void _onViewModelChanged() {
    final state = _viewModel.uiState;
    if (state is PhoneNumberInputLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fetching Kiosk Status...')),
      );
    } else if (state is PhoneNumberInputSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kiosk Status Success: ${state.kioskStatus.status}, ${state.kioskStatus.serverTime}')),
      );
    } else if (state is PhoneNumberInputError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kiosk Status Error: ${state.message}')),
      );
    }
  }

  void onNumberPressed(String number) {
    if (pin.length < pinLength) {
      setState(() {
        pin += number;
      });
    }
  }

  void onDeletePressed() {
    if (pin.isNotEmpty) {
      setState(() {
        pin = pin.substring(0, pin.length - 1);
      });
    }
  }

  void onOkPressed() {
    if (pin.length == pinLength) {
      // For testing: randomly show dialog or navigate to success
      final random = Random();
      if (random.nextBool()) {
        // Navigate to success screen
        context.push(AppRoutes.success);
      } else {
        // Show worker selection dialog
        _showWorkerSelectionDialog(context);
      }

      // Reset after action
      setState(() {
        pin = '';
      });
    }
  }

  void _showWorkerSelectionDialog(BuildContext context) {
    final workers = [
      Worker(
        name: '김철수',
        employeeId: '2023-1234',
        department: '조립1팀',
      ),
      Worker(
        name: '김철수',
        employeeId: '2021-5678',
        department: '품질관리',
      ),
      Worker(
        name: '김철수',
        employeeId: '2019-9012',
        department: '물류센터',
      ),
    ];

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => SelectNameDialog(
        workers: workers,
        onWorkerSelected: (worker) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '선택됨: ${worker.name} (${worker.employeeId})',
              ),
              backgroundColor: const Color(0xFF3b82f6),
            ),
          );
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title Section
                  const Spacer(),
                  Text(
                    '휴대폰 번호',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  // SizedBox(height: 4.h),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '뒤 ',
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF136bec),
                          ),
                        ),
                        TextSpan(
                          text: '4자리',
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF136bec),
                          ),
                        ),
                        TextSpan(
                          text: ' 입력',
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Text(
                  //   'INDUSTRIAL RESTAURANT SYSTEM V1.0',
                  //   style: TextStyle(
                  //     fontSize: 12.sp,
                  //     color: const Color(0xFF6b7280),
                  //     letterSpacing: 1.2,
                  //   ),
                  // ),
                  const Spacer(),
                  // PIN Display
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(pinLength, (index) {
                        return Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2d3548),
                                borderRadius: BorderRadius.circular(12),
                                border: Border(
                                  bottom: BorderSide(
                                    color: index < pin.length
                                        ? const Color(0xFF3b82f6)
                                        : const Color(0xFF2d3548),
                                    width: 4,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  index < pin.length ? pin[index] : '—',
                                  style: TextStyle(
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.bold,
                                    color: index < pin.length
                                        ? Colors.white
                                        : const Color(0xFF4b5563),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const Spacer(),
                  // Text(
                  //   'EMPLOYEE VERIFICATION REQUIRED',
                  //   style: TextStyle(
                  //     fontSize: 12.sp,
                  //     color: const Color(0xFF6b7280),
                  //     letterSpacing: 2,
                  //   ),
                  // ),
                  // const Spacer(),
                ],
              ),
            ),

            // Keypad
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Number rows
                    Expanded(child: _buildNumberRow(['1', '2', '3'])),
                    SizedBox(height: 12.h),
                    Expanded(child: _buildNumberRow(['4', '5', '6'])),
                    SizedBox(height: 12.h),
                    Expanded(child: _buildNumberRow(['7', '8', '9'])),
                    SizedBox(height: 12.h),

                    // Bottom row with delete, 0, and OK
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildKeypadButton(
                              icon: Icons.backspace,
                              onPressed: onDeletePressed,
                              backgroundColor: const Color(0xFF2d3548),
                              iconColor: const Color(0xFFef4444),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildKeypadButton(
                              text: '0',
                              onPressed: () => onNumberPressed('0'),
                              backgroundColor: const Color(0xFF2d3548),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildKeypadButton(
                              text: 'OK',
                              onPressed: onOkPressed,
                              backgroundColor: const Color(0xFF135bec),
                              isEnabled: pin.length == pinLength,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Status Bar
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatusItem(
                    Icons.circle,
                    'SERVER ONLINE',
                    const Color(0xFF10b981),
                  ),
                  Text(
                    'KIOSK ID: FCT-092',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFF6b7280),
                    ),
                  ),
                  _buildStatusItem(
                    Icons.wifi,
                    'CONNECTED',
                    const Color(0xFF6b7280),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _viewModel.onEvent(FetchKioskStatus());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildNumberRow(List<String> numbers) {
    List<Widget> children = [];
    for (int i = 0; i < numbers.length; i++) {
      children.add(
        Expanded(
          child: _buildKeypadButton(
            text: numbers[i],
            onPressed: () => onNumberPressed(numbers[i]),
            backgroundColor: const Color(0xFF2d3548),
          ),
        ),
      );
      if (i < numbers.length - 1) {
        children.add(const SizedBox(width: 12));
      }
    }
    return Row(children: children);
  }

  Widget _buildKeypadButton({
    String? text,
    IconData? icon,
    required VoidCallback onPressed,
    required Color backgroundColor,
    Color? iconColor,
    bool isEnabled = true,
  }) {
    return Material(
      color: isEnabled ? backgroundColor : backgroundColor.withOpacity(0.5),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(12),
        child: LayoutBuilder(builder: (context, constraints) {
          return Center(
            child: icon != null
                ? Icon(icon,
                    color: iconColor ?? Colors.white,
                    size: constraints.maxHeight * 0.4)
                : Text(
                    text!,
                    style: TextStyle(
                      fontSize: constraints.maxHeight * 0.4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          );
        }),
      ),
    );
  }

  Widget _buildStatusItem(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            color: color,
          ),
        ),
      ],
    );
  }
}