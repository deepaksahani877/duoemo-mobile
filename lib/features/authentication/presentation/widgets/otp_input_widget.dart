import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

/// Modular 6-digit OTP input widget with auto-focus and highlight active state.
class OtpInputWidget extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const OtpInputWidget({
    super.key,
    required this.onChanged,
  });

  @override
  State<OtpInputWidget> createState() => _OtpInputWidgetState();
}

class _OtpInputWidgetState extends State<OtpInputWidget> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (value.length > 1) {
        _controllers[index].text = value.substring(value.length - 1);
      }
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    }
    _notifyParent();
  }

  void _notifyParent() {
    final code = _controllers.map((c) => c.text).join();
    widget.onChanged(code);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        final isFocused = _focusNodes[index].hasFocus;
        final hasText = _controllers[index].text.isNotEmpty;

        return Container(
          width: 48.0,
          height: 58.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.small),
            border: Border.all(
              color: isFocused || hasText
                  ? AppColors.copperAccent
                  : AppColors.inputBorder,
              width: isFocused || hasText ? 1.8 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(4),
                blurRadius: 8.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: AppTypography.screenTitleStyle().copyWith(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(1),
            ],
            onChanged: (value) => _onDigitChanged(index, value),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              isDense: true,
            ),
          ),
        );
      }),
    );
  }
}
