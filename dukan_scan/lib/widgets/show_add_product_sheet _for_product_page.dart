import 'package:dukan_scan/providers/product_page_provider.dart';
import 'package:dukan_scan/providers/product_provider.dart';
import 'package:dukan_scan/responsive/screen_responsive.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddProductBottomSheet extends StatefulWidget {
  final String? initialBarcode;

  const AddProductBottomSheet({super.key, this.initialBarcode});

  static void show(BuildContext context, {String? initialBarcode}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFF8F4EA),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (_) => AddProductBottomSheet(initialBarcode: initialBarcode),
    );
  }

  @override
  State<AddProductBottomSheet> createState() => _AddProductBottomSheetState();
}

class _AddProductBottomSheetState extends State<AddProductBottomSheet> {
  final _nameController = TextEditingController();
  late final TextEditingController _barcodeController;
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  String _selectedCategory = 'Kiryana';

  @override
  void initState() {
    super.initState();
    _barcodeController = TextEditingController(
      text: widget.initialBarcode ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _barcodeController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  Future<void> _saveProduct() async {
    final name = _nameController.text.trim();
    final price = double.tryParse(_priceController.text) ?? 0;
    final stock = int.tryParse(_stockController.text) ?? 0;

    if (name.isEmpty || price <= 0) return;

    final success = await context.read<ProductProvider>().addProduct(
      name: name,
      barcode: _barcodeController.text.trim(),
      price: price,
      stock: stock,
      category: _selectedCategory,
    );

    if (success && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = ScreenResponsive.isTablet(context);
    final isSaving = context.watch<ProductProvider>().isLoading;

    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      child: Center(
        heightFactor: 1.0,
        child: SizedBox(
          width: isTablet ? 480.w : double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Naya Product Add Karein',
                  style: TextStyle(
                    fontSize: ScreenResponsive.getValue(
                      context,
                      mobile: 20.sp,
                      tablet: 24.sp,
                    ),
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                SizedBox(height: 16.h),
                _buildField(
                  controller: _nameController,
                  hint: 'Product ka naam (e.g. Surf Excel 1kg)',
                ),
                SizedBox(height: 12.h),
                _buildField(
                  controller: _barcodeController,
                  hint: 'Barcode number (e.g. 8964000123456)',
                  keyboardType: TextInputType.number,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.qr_code_scanner_rounded,
                      color: Color(0xFF0C7A43),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildField(
                        controller: _priceController,
                        hint: 'Price (Rs)',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildField(
                        controller: _stockController,
                        hint: 'Stock (Qty)',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                Row(
                  children: ['Kiryana', 'General'].map((cat) {
                    final isSelected = _selectedCategory == cat;
                    return Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: ChoiceChip(
                        label: Text(cat),
                        selected: isSelected,
                        selectedColor: const Color(0xFF0C7A43),
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF1E293B),
                          fontWeight: FontWeight.w600,
                        ),
                        onSelected: (_) {
                          setState(() => _selectedCategory = cat);
                        },
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  height: ScreenResponsive.getValue(
                    context,
                    mobile: 50.h,
                    tablet: 56.h,
                  ),
                  child: ElevatedButton(
                    onPressed: isSaving ? null : _saveProduct,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0C7A43),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    child: isSaving
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Product Save Karein',
                            style: TextStyle(
                              fontSize: ScreenResponsive.getValue(
                                context,
                                mobile: 16.sp,
                                tablet: 18.sp,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: const Color(0xFF94A3B8), fontSize: 14.sp),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF0C7A43), width: 1.5),
        ),
      ),
    );
  }
}
