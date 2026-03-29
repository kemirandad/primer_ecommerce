import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CheckoutForm extends StatelessWidget {
  const CheckoutForm({super.key});

  FormGroup _buildForm() => FormGroup(
    {
      'nombre': FormControl<String>(
        validators: [Validators.required, Validators.minLength(5)],
      ),
      'email': FormControl<String>(
        validators: [Validators.required, Validators.email],
      ),
      'confirmarEmail': FormControl<String>(
        validators: [Validators.required, Validators.email],
      ),
      'telefono': FormControl<String>(
        validators: [Validators.minLength(10), Validators.maxLength(10)],
      ),
      'direccion': FormControl<String>(validators: [Validators.required]),
      'ciudad': FormControl<String>(validators: [Validators.required]),
      'codigoPostal': FormControl<String>(
        validators: [Validators.minLength(5), Validators.maxLength(5)],
      ),
      'numTarjeta': FormControl<String>(
        asyncValidators: [
          asyncValidatorTarjeta,
        ],
        validators: [
          Validators.required,
          Validators.minLength(16),
          Validators.maxLength(16),
        ],
      ),
      'fechaExp': FormControl<String>(
        validators: [Validators.pattern(r'^\d{2}\/\d{2}$')],
      ),
      'cvv': FormControl<String>(
        validators: [Validators.minLength(3), Validators.maxLength(3)],
      ),
    },
    validators: [Validators.mustMatch('email', 'confirmarEmail')],
  );

  DelegateAsyncValidator get asyncValidatorTarjeta =>
      DelegateAsyncValidator(_validarTarjeta);

  Future<Map<String, dynamic>?> _validarTarjeta(
    AbstractControl<dynamic> control,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    final numero = control.value as String?;
    if (numero == '1234567890123456') {
      return {'tarjetaInvalida': true}; // retorna error
    }
    return null; // válido
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Finalizar pedido')),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(16),
          child: ReactiveFormBuilder(
            form: _buildForm,
            builder: (context, form, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Datos personales
                  const Text(
                    'Datos personales',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  ReactiveTextField(
                    formControlName: 'nombre',
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      label: const Text('Nombre'),
                      hintText: 'Ramón Miranda',
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validationMessages: {
                      ValidationMessage.required: (_) =>
                          'El nombre es requerido',
                    },
                  ),

                  const SizedBox(height: 8),

                  ReactiveTextField(
                    formControlName: 'email',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      label: const Text('Email'),
                      hintText: 'tuemail@email.com',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validationMessages: {
                      ValidationMessage.required: (_) =>
                          'El correo es requerido',
                      ValidationMessage.email: (_) =>
                          'Debe ser un correo válido',
                    },
                  ),

                  const SizedBox(height: 8),

                  ReactiveTextField(
                    formControlName: 'confirmarEmail',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      label: const Text('Confirmar email'),
                      hintText: 'tuemail@email.com',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validationMessages: {
                      ValidationMessage.required: (_) =>
                          'El correo es requerido',
                      ValidationMessage.email: (_) =>
                          'Debe ser un correo válido',
                      ValidationMessage.mustMatch: (_) =>
                          'Los correos no coinciden',
                    },
                  ),

                  const SizedBox(height: 8),

                  ReactiveTextField(
                    formControlName: 'telefono',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: const Text('Teléfono'),
                      hintText: '3251478562',
                      prefixIcon: Icon(Icons.phone_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validationMessages: {
                      ValidationMessage.pattern: (_) => 'Debe tener 10 dígitos',
                    },
                  ),

                  const SizedBox(height: 16),

                  // Dirección de entrega
                  const Text(
                    'Dirección de entrega',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  ReactiveTextField(
                    formControlName: 'direccion',
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      label: const Text('Dirección'),
                      hintText: '5th avenue',
                      prefixIcon: Icon(Icons.location_on_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validationMessages: {
                      ValidationMessage.required: (_) =>
                          'La dirección es requerida',
                    },
                  ),

                  const SizedBox(height: 8),

                  ReactiveTextField(
                    formControlName: 'ciudad',
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      label: const Text('Ciudad'),
                      hintText: 'Miami',
                      prefixIcon: Icon(Icons.location_city_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validationMessages: {
                      ValidationMessage.required: (_) =>
                          'La ciudad es requerida',
                    },
                  ),

                  const SizedBox(height: 8),

                  ReactiveTextField(
                    formControlName: 'codigoPostal',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      label: const Text('Código postal'),
                      hintText: '470003',
                      prefixIcon: Icon(Icons.numbers_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validationMessages: {
                      ValidationMessage.minLength: (_) =>
                          'El codigo debe tener 5 dígitos',
                      ValidationMessage.maxLength: (_) =>
                          'El codigo debe tener 5 dígitos',
                    },
                  ),

                  const SizedBox(height: 16),

                  // Pago
                  const Text(
                    'Pago',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  ReactiveTextField(
                    formControlName: 'numTarjeta',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      label: const Text('Número de tarjeta'),
                      hintText: 'XXXX XXXX XXXX XXXX',
                      prefixIcon: Icon(Icons.credit_card),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validationMessages: {
                      ValidationMessage.required: (_) =>
                          'El número de tarjeta es requerida',
                      'tarjetaInvalida': (_) => 'Número de tarjeta invalido',
                      ValidationMessage.minLength: (_) =>
                          'La tarjeta debe tener 16 dígitos',
                      ValidationMessage.maxLength: (_) =>
                          'La tarjeta debe tener 16 dígitos',
                    },
                  ),

                  const SizedBox(height: 8),

                  ReactiveTextField(
                    formControlName: 'fechaExp',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                      CardExpirationFormatter(),
                    ],
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      label: const Text('Fecha de expedición'),
                      hintText: 'MM / YY',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validationMessages: {
                      ValidationMessage.pattern: (_) =>
                          'La fecha no tiene un formato valido',
                    },
                  ),

                  const SizedBox(height: 8),

                  ReactiveTextField(
                    formControlName: 'cvv',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      label: const Text('CVV'),
                      hintText: 'XXX',
                      prefixIcon: Icon(Icons.credit_score),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validationMessages: {
                      ValidationMessage.minLength: (_) =>
                          'Debe tener 3 dígitos',
                      ValidationMessage.maxLength: (_) =>
                          'Debe tener 3 dígitos',
                    },
                  ),

                  const SizedBox(height: 12),

                  ReactiveFormConsumer(
                    builder: (context, form, child) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: form.valid
                              ? () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${form.control('nombre').value} tu ciudad es ${form.control('ciudad').value}',
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          child: const Text('Confirmar pedido'),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class CardExpirationFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newValueString = newValue.text;
    String valueToReturn = '';

    for (int i = 0; i < newValueString.length; i++) {
      if (newValueString[i] != '/') valueToReturn += newValueString[i];
      var nonZeroIndex = i + 1;
      final contains = valueToReturn.contains(RegExp(r'\/'));
      if (nonZeroIndex % 2 == 0 &&
          nonZeroIndex != newValueString.length &&
          !(contains)) {
        valueToReturn += '/';
      }
    }
    return newValue.copyWith(
      text: valueToReturn,
      selection: TextSelection.fromPosition(
        TextPosition(offset: valueToReturn.length),
      ),
    );
  }
}
