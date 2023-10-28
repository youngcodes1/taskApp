import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmasta/Provider/utils_provider.dart';

class CustomDropdown extends StatelessWidget {
  final Function(String) onCategorySelected;
  // const CustomDropdown({super.key});
  const CustomDropdown({super.key, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    final utilsprovider = Provider.of<UtilsProvider>(context);
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        hintText: 'Select a category',
      ),
      value: utilsprovider.selectedOption,
      onChanged: (String? newValue) {
        utilsprovider.setSelectedOption(newValue);
        onCategorySelected(newValue ?? '');
      },
      items: <String?>[
        'Option 1',
        'Option 2',
        'Option 3',
      ].map((String? value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value ?? ''),
        );
      }).toList(),
    );
  }
}
