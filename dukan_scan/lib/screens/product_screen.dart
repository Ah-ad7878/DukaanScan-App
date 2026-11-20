import 'package:dukan_scan/providers/product_page_provider.dart';
import 'package:dukan_scan/responsive/screen_responsive.dart';
import 'package:dukan_scan/widgets/product_page_filter_widget.dart';
import 'package:dukan_scan/widgets/show_add_product_sheet%20_for_product_page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = ScreenResponsive.isTablet(context);
    final provider = context.watch<ProductProvider>();
    final products = provider.filteredProducts;

    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20.w, 26.h, 20.w, 22.h),
              decoration: BoxDecoration(
                color: const Color(0xFF0C7A43),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24.r),
                  bottomRight: Radius.circular(24.r),
                ),
              ),
              child: Center(
                child: SizedBox(
                  width: isTablet ? 520.w : double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Products',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenResponsive.getValue(
                                    context,
                                    mobile: 24.sp,
                                    tablet: 28.sp,
                                  ),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                '${provider.totalCount} items',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.85),
                                  fontSize: ScreenResponsive.getValue(
                                    context,
                                    mobile: 13.sp,
                                    tablet: 16.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(20.r),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.16),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                'Barcode scan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenResponsive.getValue(
                                    context,
                                    mobile: 12.sp,
                                    tablet: 15.sp,
                                  ),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: _searchController,
                        onChanged: provider.updateSearch,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF1E293B),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Naam ya barcode se dhoondein',
                          hintStyle: TextStyle(
                            color: const Color(0xFF94A3B8),
                            fontSize: 14.sp,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.close, size: 18),
                                  onPressed: () {
                                    _searchController.clear();
                                    provider.updateSearch('');
                                  },
                                )
                              : null,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: isTablet ? 520.w : double.infinity,
                padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 8.h),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildFilterChip(
                        context,
                        label: 'Sab',
                        isSelected: provider.selectedFilter == 'Sab',
                        onTap: () => provider.changeFilter('Sab'),
                      ),
                      SizedBox(width: 10.w),
                      buildFilterChip(
                        context,
                        label: 'Kam stock (${provider.lowStockCount})',
                        isSelected: provider.selectedFilter == 'Kam stock',
                        isAlertChip: true,
                        onTap: () => provider.changeFilter('Kam stock'),
                      ),
                      SizedBox(width: 10.w),
                      buildFilterChip(
                        context,
                        label: 'Kiryana',
                        isSelected: provider.selectedFilter == 'Kiryana',
                        onTap: () => provider.changeFilter('Kiryana'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: isTablet ? 520.w : double.infinity,
                  child: products.isEmpty
                      ? Center(
                          child: Text(
                            'Koi product nahi mila',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: const Color(0xFF94A3B8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.fromLTRB(20.w, 6.h, 20.w, 90.h),
                          itemCount: products.length,
                          separatorBuilder: (_, _) => SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            final item = products[index];
                            final int stock = item['stock'] ?? 0;
                            final bool isLowStock = stock <= 5;
                            final double price = item['price'] ?? 0;

                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 14.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF1E293B)
                                        .withValues(alpha: 0.05),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['name'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: ScreenResponsive.getValue(
                                              context,
                                              mobile: 16.sp,
                                              tablet: 18.sp,
                                            ),
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF1E293B),
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          'Barcode: ${item['barcode'].toString().isEmpty ? 'N/A' : item['barcode']}',
                                          style: TextStyle(
                                            fontSize: ScreenResponsive.getValue(
                                              context,
                                              mobile: 12.sp,
                                              tablet: 14.sp,
                                            ),
                                            color: const Color(0xFF94A3B8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Rs ${price.toStringAsFixed(0)}',
                                        style: TextStyle(
                                          fontSize: ScreenResponsive.getValue(
                                            context,
                                            mobile: 16.sp,
                                            tablet: 18.sp,
                                          ),
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF1E293B),
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 4.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isLowStock
                                              ? const Color(0xFFFEE2E2)
                                              : const Color(0xFFDCFCE7),
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                        ),
                                        child: Text(
                                          'Stock: $stock',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                            color: isLowStock
                                                ? const Color(0xFFB91C1C)
                                                : const Color(0xFF0C7A43),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          right: 20.w,
          bottom: 16.h,
          child: ElevatedButton.icon(
            onPressed: () => AddProductBottomSheet.show(context),
            icon: Icon(Icons.add, size: 20.sp, color: const Color(0xFF1E293B)),
            label: Text(
              'Naya Product',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1E293B),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE5A922),
              elevation: 4,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
