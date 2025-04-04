import 'dart:async';

import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';
// Use o entry point público do flutter_typeahead.
import 'package:flutter_typeahead/flutter_typeahead.dart';

/// Se o typedef SuggestionsCallback não estiver exportado, defina-o:
typedef SuggestionsCallback<T> = FutureOr<List<T>?> Function(String search);

/// Um campo de entrada com sugestões do tipo "typeahead", customizado conforme a JNM UI.
/// Essa implementação utiliza a API pública do TypeAheadField, que requer o parâmetro [builder]
/// para construir o campo de texto.
class JNMTypeAheadInputField<T> extends StatefulWidget {
  /// Se o campo é obrigatório.
  final bool isRequired;

  /// O rótulo acima do campo.
  final String label;

  /// O texto de dica.
  final String hintText;

  /// O texto de erro, se houver.
  final String? errorText;

  /// Texto auxiliar.
  final String? helperText;

  /// Se o campo está habilitado.
  final bool enabled;

  /// O FocusNode para controle do foco.
  final FocusNode? focusNode;

  /// Tamanho do campo.
  final JNMTextInputFieldSize size;

  /// Valor inicial para o tipo T.
  final T initialData;

  /// Controlador do campo de texto.
  final TextEditingController? controller;

  /// Callback que recebe o padrão digitado e retorna as sugestões.
  final SuggestionsCallback<T> suggestionsCallback;

  /// Constrói o widget para cada sugestão.
  final Widget Function(BuildContext context, T item) itemBuilder;

  /// Callback chamado quando uma sugestão é selecionada.
  final void Function(T suggestion) onSuggestionSelected;

  /// (Opcional) Callback para construir um widget de erro.
  final Widget Function(BuildContext, Object?)? errorBuilder;

  const JNMTypeAheadInputField({
    required this.label,
    required this.initialData,
    required this.focusNode,
    required this.controller,
    required this.suggestionsCallback,
    required this.itemBuilder,
    required this.onSuggestionSelected,
    required this.hintText,
    this.isRequired = false,
    this.errorText,
    this.helperText,
    this.size = JNMTextInputFieldSize.md,
    this.enabled = true,
    this.errorBuilder,
    super.key,
  });

  @override
  State<JNMTypeAheadInputField<T>> createState() => _JNMTypeAheadInputFieldState<T>();
}

class _JNMTypeAheadInputFieldState<T> extends State<JNMTypeAheadInputField<T>> {
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    // Usa o focusNode fornecido ou cria um novo.
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define o content padding conforme o tamanho.
    final EdgeInsetsGeometry contentPadding = widget.size == JNMTextInputFieldSize.sm
        ? const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0)
        : const EdgeInsets.symmetric(vertical: 16.0, horizontal: 14.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JNMInputFieldLabel(
          label: widget.label,
          isRequired: widget.isRequired,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: !_isFocused
                ? JNMBoxShadow.xs
                : [
              const BoxShadow(
                color: Color.fromRGBO(16, 24, 40, 0.05),
                offset: Offset(1.0, 0.0),
                blurRadius: 2.0,
                spreadRadius: 0.0,
              ),
              const BoxShadow(
                color: Color(0xFFEBF1FF),
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 4.0,
              ),
            ],
          ),
          child: TypeAheadField<T>(
            builder: (BuildContext context, TextEditingController controller, FocusNode focusNode) {
              return TextField(
                controller: controller,
                focusNode: focusNode,
                enabled: widget.enabled,
                style: LibraryTextStyles.interMdRegularNeutral,
                cursorColor:
                widget.errorText == null ? JNMColors.primary : JNMColors.danger,
                decoration: InputDecoration(
                  errorText: widget.errorText,
                  isDense: true,
                  counterText: '',
                  contentPadding: contentPadding,
                  fillColor: JNMColors.white,
                  filled: true,
                  hintText: widget.hintText,
                  hintStyle: LibraryTextStyles.interMdRegularNeutral300,
                  border: widget.errorText == null
                      ? OutlineInputBorder(
                    borderSide: const BorderSide(color: JNMColors.neutral100),
                    borderRadius: BorderRadius.circular(8.0),
                  )
                      : OutlineInputBorder(
                    borderSide: const BorderSide(color: JNMColors.danger300),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: widget.errorText == null
                      ? OutlineInputBorder(
                    borderSide: const BorderSide(color: JNMColors.neutral100),
                    borderRadius: BorderRadius.circular(8.0),
                  )
                      : OutlineInputBorder(
                    borderSide: const BorderSide(color: JNMColors.danger300),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: JNMColors.neutral100),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: widget.errorText == null
                      ? OutlineInputBorder(
                    borderSide: const BorderSide(color: JNMColors.primary200),
                    borderRadius: BorderRadius.circular(8.0),
                  )
                      : OutlineInputBorder(
                    borderSide: const BorderSide(color: JNMColors.danger300),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              );
            },
            suggestionsCallback: widget.suggestionsCallback,
            itemBuilder: (context, itemData) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: widget.itemBuilder(context, itemData),
              );
            },
            onSelected: widget.onSuggestionSelected,
            errorBuilder: widget.errorBuilder,
            focusNode: _focusNode,
          ),
        ),
      ],
    );
  }
}