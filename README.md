# JNM UI - Sistema de Design Flutter para a JNMoura

Pacote exclusivo da JNMoura com todos os componentes UI necessários para desenvolvimento de aplicativos Flutter seguindo os padrões de design da empresa.

## Primeiros Passos

1. **Inicialização das fontes** no método main:

```dart
import 'package:jnm_ui/jnm_ui.dart';

void main() {
  JNMFontFamilies.init(
    allowRuntimeFetching: true,  // Permite carregamento dinâmico de fontes
  );

  runApp(const MyApp());
}

```

1. **Configuração do tema** no MaterialApp:

```dart
MaterialApp(
  theme: JNMThemeData.light(),  // Tema claro padrão JNM
  // darkTheme: JNMThemeData.dark(),  // Em desenvolvimento
  home: const HomeScreen(),
);

```

## Design Tokens

### Cores

A paleta de cores JNM inclui:

```dart
// Cores primárias
JNMColors.primary50   // #EAECF9
JNMColors.primary500  // #283EBF (cor principal)

// Cores de status
JNMColors.success500  // #24AC0C (verde)
JNMColors.warning500  // #FCAA07 (amarelo)
JNMColors.danger500   // #CD353C (vermelho)

// Tons neutros
JNMColors.neutral50   // #F3F4F5
JNMColors.neutral500  // #101828

```

### Tipografia

```dart
// Famílias de fonte
JNMFontFamilies.poppins()  // Fonte principal
JNMFontFamilies.inter()    // Fonte secundária

// Tamanhos
JNMFontSizes.xs   // 12.0
JNMFontSizes.lg   // 18.0
JNMFontSizes.xl5  // 48.0

// Pesos
JNMFontWeights.regular   // 400
JNMFontWeights.semibold  // 600

```

## Componentes Principais

### Botões

### Tipos Disponíveis:

```dart
// Botão primário
JNMPrimaryButton.text(
  text: 'Salvar',
  onPressed: () {},
  leadingIconAssetName: JNMIconsOutline.save,
)

// Botão outline
JNMOutlineButton.text(
  text: 'Cancelar',
  onPressed: () {},
)

// Botão link
JNMLinkPrimaryButton.text(
  text: 'Ver detalhes',
  onPressed: () {},
)

```

### Formulários

### Campos de Entrada:

```dart
// Campo de texto padrão
JNMTextInputField(
  label: 'Nome completo',
  hintText: 'Digite seu nome',
  errorText: _nomeError,
  onChanged: (value) => _validateNome(value),
)

// Dropdown
JNMDropdownInputField<String>(
  label: 'Estado',
  hintText: 'Selecione seu estado',
  options: estados.map((e) =>
    JNMDropdownInputFieldOption(
      title: e.nome,
      value: e.sigla,
    )).toList(),
  onChanged: (sigla) => _setEstado(sigla),
)

// Autocomplete
JNMAutocompleteInputField<Cliente>(
  label: 'Cliente',
  options: clientes.map((c) =>
    JNMAutocompleteInputFieldOption(
      title: c.nome,
      subtitle: c.cidade,
      value: c,
    )).toList(),
  onChanged: (cliente) => _selectCliente(cliente),
)

```

### Componentes de Layout

### Cards:

```dart
// Card elevado
JNMElevatedCard(
  padding: const EdgeInsets.all(16),
  child: Column(
    children: [
      _buildHeader(),
      const JNMDivider(),
      _buildContent(),
      _buildFooter(),
    ],
  ),
)

// Card de menu
JNMMenuCard(
  title: 'Meus Pedidos',
  subtitle: 'Histórico completo',
  icon: JNMIconsOutline.shoppingBag,
  onTap: () => _navigateToOrders(),
)

```

## Componentes Complexos

### Tabelas Paginadas

```dart
// Para mobile
JNMMobilePaginationFooter(
  currentPage: _currentPage,
  numPages: totalPages,
  onPressedNext: _loadNextPage,
  onPressedPrevious: _loadPreviousPage,
)

// Para desktop
JNMDesktopPaginationFooter(
  currentPage: _currentPage,
  numPages: totalPages,
  onPressedNext: _loadNextPage,
  onPressedPrevious: _loadPreviousPage,
  onPressedPage: (page) => _goToPage(page),
)

```

### Fluxo OTP

```dart
JNMOtpField(
  length: 6,
  onChanged: (code) => _verifyCode(code),
  onResendOtpCode: _resendCode,
  resendTimeout: 60,  // segundos
)

```

## Personalização Avançada

### Temas Customizados

```dart
final temaJnmPersonalizado = JNMThemeData.light().copyWith(
  primaryColor: const Color(0xFF1A5F2A),  // Verde JNM
  buttonTheme: JNMButtonThemeData(
    primaryColor: const Color(0xFF1A5F2A),
    hoverColor: const Color(0xFF2D8E42),
    disabledColor: Colors.grey[400],
  ),
  cardTheme: JNMCardThemeData(
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: JNMBorderRadius.xl,
    ),
  ),
);

```

### Componentes Customizados

```dart
class MeuBotaoCustomizado extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MeuBotaoCustomizado({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return JNMPrimaryButton.text(
      text: text,
      onPressed: onPressed,
      buttonThemeData: JNMButtonThemeData(
        primaryColor: Colors.deepPurple,
        hoverColor: Colors.deepPurple[700],
      ),
    );
  }
}

```

## Boas Práticas

1. **Hierarquia de Importação**:

```dart
// 1. Pacotes Flutter
import 'package:flutter/material.dart';

// 2. Pacotes externos
import 'package:provider/provider.dart';

// 3. Pacotes JNM
import 'package:jnm_ui/jnm_ui.dart';

// 4. Arquivos locais
import 'package:meu_app/models/user.dart';

```

1. **Organização de Componentes**:
- Crie pastas separadas para:
    - `/components/buttons`
    - `/components/cards`
    - `/components/inputs`
1. **Testes**:

```dart
testWidgets('MeuBotaoCustomizado test', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MeuBotaoCustomizado(
        text: 'Teste',
        onPressed: () {},
      ),
    ),
  );

  expect(find.text('Teste'), findsOneWidget);
});

```

---

Este pacote foi desenvolvido exclusivamente para uso nos projetos da JNMoura, garantindo padronização e agilidade no desenvolvimento de interfaces.