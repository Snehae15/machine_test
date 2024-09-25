import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice/services/api_service.dart';
import 'package:practice/viewmodel/ImageList_ViewModel%20.dart';

class JewelleryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final JewelleryListViewModel viewModel = Get.put(JewelleryListViewModel(ApiService()));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[350],
        title: const Text('Jewellery List'),
      ),
      body: Obx(() {
        if (viewModel.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (viewModel.errorMessage.value.isNotEmpty) {
          return Center(child: Text(viewModel.errorMessage.value));
        }
        return Container(
          color: Colors.grey[100],
          child: SingleChildScrollView(
            child: GestureDetector(
              onScaleUpdate: (details) {

              },
              child: Column(
                children: [
                  
                  Scrollbar(
                    thumbVisibility: true, 
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('UID')),
                          DataColumn(label: Text('DocType')),
                          DataColumn(label: Text('Image')),
                        ],
                        rows: viewModel.images.map((image) {
                          return DataRow(cells: [
                            DataCell(Text(image.name)),
                            DataCell(Text('${image.uid}')),
                            DataCell(Text('${image.docType}')),
                            DataCell(Image.network(image.url, width: 50, height: 50)),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
