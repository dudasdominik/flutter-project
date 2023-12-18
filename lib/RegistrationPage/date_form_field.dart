import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormField extends StatelessWidget {
  final ValueChanged<DateTime> onChanged;
  final DateTime? currentValue;
  final FormFieldValidator<DateTime>? validator;
  final String label;

  String get _label {
    if (currentValue == null) {
      return label;
    } else {
      return DateFormat.yMMMd().format(currentValue!);
    }
  }

  const DateFormField(
      {super.key,
      required this.onChanged,
      this.currentValue,
      this.validator,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: currentValue,
      validator: validator,
      builder: (formstate) {
        late InputBorder shape;

        if (formstate.hasError) {
          shape = Theme.of(context).inputDecorationTheme.errorBorder ??
              const OutlineInputBorder();
          ;
        } else {
          shape = Theme.of(context).inputDecorationTheme.enabledBorder ??
              const OutlineInputBorder();
          ;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                _buildDateSelectListTile(shape, context, formstate),
                if (currentValue != null) _buildFloatingLabel(context)
              ],
            ),
            if (formstate.hasError) _buildErrorText(formstate, context)
          ],
        );
      },
    );
  }

  Widget _buildErrorText(
      FormFieldState<DateTime> formState, BuildContext context) {
    if (formState.errorText == null) {
      return SizedBox
          .shrink(); // Return an empty widget if there's no error text.
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        formState.errorText!,
        style: Theme.of(context).inputDecorationTheme.errorStyle,
      ),
    );
  }

  Widget _buildDateSelectListTile(
    InputBorder shape,
    BuildContext context,
    FormFieldState<DateTime> formState,
  ) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: DatePickerWidget(
          formState: formState,
          label: _label,
          shape: shape,
          currentValue: currentValue,
          onChanged: onChanged,
        ));
  }

  Widget _buildFloatingLabel(BuildContext context) {
    return Positioned(
      left: 12.0,
      top: -2.0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Text(
          label,
          style: Theme.of(context).inputDecorationTheme.helperStyle,
        ),
      ),
    );
  }
}

class DatePickerWidget extends StatefulWidget {
  final InputBorder shape;
  final FormFieldState<DateTime> formState;
  final String label;
  final DateTime? currentValue;
  final ValueChanged<DateTime> onChanged;

  const DatePickerWidget(
      {super.key,
      required this.label,
      required this.shape,
      required this.formState,
      this.currentValue,
      required this.onChanged});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      shape: widget.shape,
      trailing: const Icon(
        Icons.date_range,
        color: Colors.blue,
      ),
      title: Text(widget.label),
      onTap: () async {
        final date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now());

        if (date != null) {
          widget.formState.didChange(date);
          widget.onChanged(date);
        }
      },
    );
  }
}
