import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';

/// [JNMPasswordStrength] validation class.
class JNMPasswordStrengthValidation {
  /// The validation label.
  final String label;

  /// The validation logic given the password input.
  final bool Function(String password) validate;

  JNMPasswordStrengthValidation({
    required this.label,
    required this.validate,
  });

  /// Default validation for checking whether password input contains uppercase
  /// & lowercase characters.
  factory JNMPasswordStrengthValidation.defaultContainsUpperLowerCase() {
    return JNMPasswordStrengthValidation(
      label: 'Kombinasi huruf besar dan kecil',
      validate: (password) =>
          password.contains(RegExp(r'[A-Z]')) &&
          password.contains(RegExp(r'[a-z]')),
    );
  }

  /// Default validation for checking whether password input contains numbers.
  factory JNMPasswordStrengthValidation.defaultContainsNumeric() {
    return JNMPasswordStrengthValidation(
      label: 'Kombinasi angka',
      validate: (password) => password.contains(RegExp(r'[0-9]')),
    );
  }

  /// Default validation for checking whether password input contains symbols.
  factory JNMPasswordStrengthValidation.defaultContainsSymbol() {
    return JNMPasswordStrengthValidation(
      label: 'Simbol',
      validate: (password) => password.contains(RegExp(r'(?=.*?[#?!@$%^&*-])')),
    );
  }

  /// Default validation for checking password input's minimum characters.
  factory JNMPasswordStrengthValidation.defaultMinCharacters() {
    return JNMPasswordStrengthValidation(
      label: 'Minimal 8 karakter',
      validate: (password) => password.length >= 8,
    );
  }

  /// Default validations for password input.
  static List<JNMPasswordStrengthValidation> getDefaults() {
    return [
      JNMPasswordStrengthValidation.defaultMinCharacters(),
      JNMPasswordStrengthValidation.defaultContainsUpperLowerCase(),
      JNMPasswordStrengthValidation.defaultContainsNumeric(),
      // JNMPasswordStrengthValidation.defaultContainsSymbol(),
    ];
  }
}

/// JNM UI's password strength component.
class JNMPasswordStrength extends StatelessWidget {
  /// The password input validations.
  final List<JNMPasswordStrengthValidation> validations;

  /// The check icon asset name.
  final IconData iconAssetName;

  /// The password input.
  final String password;

  /// The title text shown above the validations.
  final String title;

  /// String builder for password strength label.
  /// Parameter [strengthProgress] ranges from 0 to 1.
  final String Function(double strengthProgress)? passwordStrengthLabelBuilder;

  final bool showStrengthLabel;
  final bool showTitle;

  const JNMPasswordStrength({
    required this.password,
    required this.validations,
    this.title = 'Password harus mengandung:',
    this.iconAssetName = JNMIcons.check_circle,
    this.passwordStrengthLabelBuilder,
    super.key,
    this.showStrengthLabel = false,
    this.showTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    double strengthProgress = _calculatePasswordStrength();
    String strengthLabel = passwordStrengthLabelBuilder != null
        ? passwordStrengthLabelBuilder!(strengthProgress)
        : _getPasswordStrengthLabel(strengthProgress);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showStrengthLabel) ...[
          Row(
            children: [
              Expanded(
                child: JNMLinearProgressIndicator(
                  value: strengthProgress,
                ),
              ),
              const SizedBox(width: 12.0),
              Text(
                strengthLabel,
                style: LibraryTextStyles.interSmMediumGrey700,
              ),
            ],
          ),
          const SizedBox(height: 16.0),
        ],
        if (showTitle) ...[
          Text(
            title,
            style: LibraryTextStyles.interSmRegularNeutral300,
          ),
          const SizedBox(height: 16.0),
        ],
        ...validations.asMap().entries.map((entry) {
          final key = entry.key;
          final validation = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              validation.validate(password)
                  ? _buildValidRow(validation)
                  : _buildInvalidRow(validation),
              key < validations.length - 1
                  ? const SizedBox(height: 2.0)
                  : const SizedBox(),
            ],
          );
        }),
      ],
    );
  }

  /// Calculate password strength.
  double _calculatePasswordStrength() {
    if (validations.isEmpty) {
      return 0.0;
    }
    int countValid =
        validations.where((validation) => validation.validate(password)).length;
    return countValid / validations.length;
  }

  /// Get password strength label.
  String _getPasswordStrengthLabel(double strengthProgress) {
    if (strengthProgress <= 0.0) {
      return 'Very Weak';
    } else if (strengthProgress <= 0.25) {
      return 'Weak';
    } else if (strengthProgress <= 0.5) {
      return 'Medium';
    } else if (strengthProgress <= 0.75) {
      return 'Strong';
    } else {
      return 'Very Strong';
    }
  }

  /// Builds validation row that is valid.
  Widget _buildValidRow(JNMPasswordStrengthValidation validation) {
    return _buildValidationRow(
      iconColor: JNMColors.success,
      labelColor: JNMColors.success,
      label: validation.label,
    );
  }

  /// Builds validation row that is invalid.
  Widget _buildInvalidRow(JNMPasswordStrengthValidation validation) {
    return _buildValidationRow(
      iconColor: JNMColors.neutral300,
      labelColor: JNMColors.neutral300,
      label: validation.label,
    );
  }

  /// Builds a single validation row.
  Widget _buildValidationRow({
    required Color iconColor,
    required Color labelColor,
    required String label,
  }) {
    return Row(
      children: [
        JNMIcon(
          iconAssetName,
          color: iconColor,
          size: 12.0,
        ),
        const SizedBox(width: 4.0),
        Text(
          label,
          style: JNMFontFamilies.inter(
            color: labelColor,
            fontWeight: JNMFontWeights.regular,
            fontSize: JNMFontSizes.xs,
          ),
        ),
      ],
    );
  }
}
