// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:xtable/xtable.dart';

// class Userdeytails extends StatefulWidget {
//   Userdeytails({Key? key}) : super(key: key);
//   @override
//   _UserdeytailsState createState() => _UserdeytailsState();
// }

// class _UserdeytailsState extends State<Userdeytails> {
//   late List<DatatableHeader> _headers;

//   List<int> _perPages = [10, 20, 50, 100];
//   int _total = 100;
//   int? _currentPerPage = 10;
//   List<bool>? _expanded;
//   String? _searchKey = "id";

//   int _currentPage = 1;
//   bool _isSearch = false;
//   List<Map<String, dynamic>> _sourceOriginal = [];
//   List<Map<String, dynamic>> _sourceFiltered = [];
//   List<Map<String, dynamic>> _source = [];
//   List<Map<String, dynamic>> _selecteds = [];
//   // ignore: unused_field
//   String _selectableKey = "id";

//   String? _sortColumn;
//   bool _sortAscending = true;
//   bool _isLoading = true;
//   bool _showSelect = true;
//   var random = new Random();

//   List<Map<String, dynamic>> _generateData({int n = 100}) {
//     final List source = List.filled(n, Random.secure());
//     List<Map<String, dynamic>> temps = [];
//     var i = 1;
//     print(i);
//     // ignore: unused_local_variable
//     for (var data in source) {
//       temps.add({
//         "id": i,
//         "sku": "$i\000$i",
//         "name": "Product $i",
//         "category": "Category-$i",
//         "price": i * 10.00,
//         "cost": "20.00",
//         "margin": "${i}0.20",
//         "in_stock": "${i}0",
//         "alert": "5",
//         "received": [i + 20, 150]
//       });
//       i++;
//     }
//     return temps;
//   }

//   _initializeData() async {
//     _mockPullData();
//   }

//   _mockPullData() async {
//     _expanded = List.generate(_currentPerPage!, (index) => false);

//     setState(() => _isLoading = true);
//     Future.delayed(Duration(seconds: 3)).then((value) {
//       _sourceOriginal.clear();
//       _sourceOriginal.addAll(_generateData(n: random.nextInt(10000)));
//       _sourceFiltered = _sourceOriginal;
//       _total = _sourceFiltered.length;
//       _source = _sourceFiltered.getRange(0, _currentPerPage!).toList();
//       setState(() => _isLoading = false);
//     });
//   }

//   _resetData({start= 0}) async {
//     setState(() => _isLoading = true);
//     var _expandedLen = _total - start < _currentPerPage! ? _total - start : _currentPerPage;
//     Future.delayed(Duration(seconds: 0)).then((value) {
//       _expanded = List.generate(_expandedLen as int, (index) => false);
//       _source.clear();
//       _source = _sourceFiltered.getRange(start, start + _expandedLen).toList();
//       setState(() => _isLoading = false);
//     });
//   }

//   _filterData(value) {
//     setState(() => _isLoading = true);

//     try {
//       if (value == "" || value == null) {
//         _sourceFiltered = _sourceOriginal;
//       } else {
//         _sourceFiltered = _sourceOriginal.where((data) => data[_searchKey!].toString().toLowerCase().contains(value.toString().toLowerCase())).toList();
//       }

//       _total = _sourceFiltered.length;
//       var _rangeTop = _total < _currentPerPage! ? _total : _currentPerPage!;
//       _expanded = List.generate(_rangeTop, (index) => false);
//       _source = _sourceFiltered.getRange(0, _rangeTop).toList();
//     } catch (e) {
//       print(e);
//     }
//     setState(() => _isLoading = false);
//   }

//   @override
//   void initState() {
//     super.initState();

//     /// set headers
//     _headers = [
//       DatatableHeader(
//         text: "ID",
//         value: "id",
//         show: true,
//         sortable: true,
//         textAlign: TextAlign.center,
//         format: DataTableFormat.list,
//         items: ['1dasdasdasdasdasdasdasdasdas asdasdasd adasdasd asdasdasdas', '2'],
//         editable: true,
//       ),
//       DatatableHeader(
//           text: "Name", value: "name", show: true, flex: 2, sortable: true, editable: true, textAlign: TextAlign.left, format: DataTableFormat.number, textInputFormatter: []),
//       DatatableHeader(
//         text: "SKU",
//         value: "sku",
//         show: true,
//         sortable: true,
//         textAlign: TextAlign.center,
//         editable: true,
//         format: DataTableFormat.number,
//       ),
//       DatatableHeader(text: "Category", value: "category", show: true, sortable: true, textAlign: TextAlign.left),
//       DatatableHeader(text: "Price", value: "price", show: true, sortable: true, textAlign: TextAlign.left),
//       DatatableHeader(text: "Margin", value: "margin", show: true, sortable: true, textAlign: TextAlign.left),
//       DatatableHeader(text: "In Stock", value: "in_stock", show: true, sortable: true, textAlign: TextAlign.left),
//       DatatableHeader(text: "Alert", value: "alert", show: true, sortable: true, textAlign: TextAlign.left),
//       DatatableHeader(
//           text: "Received",
//           value: "received",
//           show: true,
//           sortable: false,
//           sourceBuilder: (value, row) {
//             List list = List.from(value);
//             return Container(
//               child: Column(
//                 children: [
//                   Container(
//                     width: 85,
//                     child: LinearProgressIndicator(
//                       value: list.first / list.last,
//                     ),
//                   ),
//                   Text("${list.first} of ${list.last}")
//                 ],
//               ),
//             );
//           },
//           textAlign: TextAlign.center),
//     ];

//     _initializeData();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("RESPONSIVE DATA TABLE"),
//         actions: [
//           IconButton(
//             onPressed: _initializeData,
//             icon: Icon(Icons.refresh_sharp),
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             ListTile(
//               leading: Icon(Icons.home),
//               title: Text("home"),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: Icon(Icons.storage),
//               title: Text("data"),
//               onTap: () {},
//             )
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//           child: Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
//         Container(
//           margin: const EdgeInsets.all(10),
//           padding: const EdgeInsets.all(0),
//           constraints: const BoxConstraints(
//             maxHeight: 700,
//           ),
//           child: Card(
//             elevation: 1,
//             shadowColor: Colors.black,
//             clipBehavior: Clip.none,
//             child: XDataTable(
//               timeToSubtract: const Duration(days: 6),
//               title: TextButton.icon(
//                 onPressed: () => {},
//                 icon: const Icon(Icons.add),
//                 label: const Text("new item"),
//               ),
//               reponseScreenSizes: [ScreenSize.xs],
//               actions: [
//                 if (_isSearch)
//                   Expanded(
//                       child: TextField(
//                     decoration: InputDecoration(
//                         hintText: 'Enter search term based on ${_searchKey!.replaceAll(RegExp('[\\W_]+'), ' ').toUpperCase()}',
//                         prefixIcon: IconButton(
//                             icon: Icon(Icons.cancel),
//                             onPressed: () {
//                               setState(() {
//                                 _isSearch = false;
//                               });
//                               _initializeData();
//                             }),
//                         suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: () {})),
//                     onSubmitted: (value) {
//                       _filterData(value);
//                     },
//                   )),
//                 if (!_isSearch)
//                   IconButton(
//                       icon: Icon(Icons.search),
//                       onPressed: () {
//                         setState(() {
//                           _isSearch = true;
//                         });
//                       })
//               ],
//               headers: _headers,
//               source: _source,
//               selecteds: _selecteds,
//               showSelect: _showSelect,
//               autoHeight: false,
//               dropContainer: (data) {
//                 if (int.tryParse(data['id'].toString())!.isEven) {
//                   return Text("is Even");
//                 }
//                 return _DropDownContainer(data: data);
//               },
//               onChangedRow: (value, header) {
//                 /// print(value);
//                 /// print(header);
//               },
//               onSubmittedRow: (value, header) {
//                 /// print(value);
//                 /// print(header);
//               },
//               onTabRow: (data) {
//                 print(data);
//               },
//               onSort: (value) {
//                 setState(() => _isLoading = true);

//                 setState(() {
//                   _sortColumn = value;
//                   _sortAscending = !_sortAscending;
//                   if (_sortAscending) {
//                     _sourceFiltered.sort((a, b) => b["$_sortColumn"].compareTo(a["$_sortColumn"]));
//                   } else {
//                     _sourceFiltered.sort((a, b) => a["$_sortColumn"].compareTo(b["$_sortColumn"]));
//                   }
//                   var _rangeTop = _currentPerPage! < _sourceFiltered.length ? _currentPerPage! : _sourceFiltered.length;
//                   _source = _sourceFiltered.getRange(0, _rangeTop).toList();
//                   _searchKey = value;

//                   _isLoading = false;
//                 });
//               },
//               expanded: _expanded,
//               sortAscending: _sortAscending,
//               sortColumn: _sortColumn,
//               isLoading: _isLoading,
//               onSelect: (value, item) {
//                 print("$value  $item ");
//                 if (value!) {
//                   setState(() => _selecteds.add(item));
//                 } else {
//                   setState(() => _selecteds.removeAt(_selecteds.indexOf(item)));
//                 }
//               },
//               onSelectAll: (value) {
//                 if (value!) {
//                   setState(() => _selecteds = _source.map((entry) => entry).toList().cast());
//                 } else {
//                   setState(() => _selecteds.clear());
//                 }
//               },
//               footers: [
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 15),
//                   child: Text("Rows per page:"),
//                 ),
//                 if (_perPages.isNotEmpty)
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 15),
//                     child: DropdownButton<int>(
//                       value: _currentPerPage,
//                       items: _perPages
//                           .map((e) => DropdownMenuItem<int>(
//                                 child: Text("$e"),
//                                 value: e,
//                               ))
//                           .toList(),
//                       onChanged: (dynamic value) {
//                         setState(() {
//                           _currentPerPage = value;
//                           _currentPage = 1;
//                           _resetData();
//                         });
//                       },
//                       isExpanded: false,
//                     ),
//                   ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 15),
//                   child: Text("$_currentPage - $_currentPerPage of $_total"),
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     Icons.arrow_back_ios,
//                     size: 16,
//                   ),
//                   onPressed: _currentPage == 1
//                       ? null
//                       : () {
//                           var _nextSet = _currentPage - _currentPerPage!;
//                           setState(() {
//                             _currentPage = _nextSet > 1 ? _nextSet : 1;
//                             _resetData(start: _currentPage - 1);
//                           });
//                         },
//                   padding: EdgeInsets.symmetric(horizontal: 15),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.arrow_forward_ios, size: 16),
//                   onPressed: _currentPage + _currentPerPage! - 1 > _total
//                       ? null
//                       : () {
//                           var _nextSet = _currentPage + _currentPerPage!;

//                           setState(() {
//                             _currentPage = _nextSet < _total ? _nextSet : _total - _currentPerPage!;
//                             _resetData(start: _nextSet - 1);
//                           });
//                         },
//                   padding: EdgeInsets.symmetric(horizontal: 15),
//                 )
//               ],
//               headerDecoration: BoxDecoration(color: Colors.grey, border: Border(bottom: BorderSide(color: Colors.red, width: 1))),
//               selectedDecoration: BoxDecoration(
//                 border: Border(bottom: BorderSide(color: Colors.green[300]!, width: 1)),
//                 color: Colors.green,
//               ),
//               headerTextStyle: TextStyle(color: Colors.white),
//               rowTextStyle: TextStyle(color: Colors.green),
//               selectedTextStyle: TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//       ])),
//     );
//   }
// }

// class _DropDownContainer extends StatelessWidget {
//   final Map<String, dynamic> data;
//   const _DropDownContainer({Key? key, required this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> _children = data.entries.map<Widget>((entry) {
//       Widget w = Row(
//         children: [
//           Text(entry.key.toString()),
//           Spacer(),
//           Text(entry.value.toString()),
//         ],
//       );
//       return w;
//     }).toList();

//     return Container(
//       /// height: 100,
//       child: Column(
//         /// children: [
//         ///   Expanded(
//         ///       child: Container(
//         ///     color: Colors.red,
//         ///     height: 50,
//         ///   )),
//         /// ],
//         children: _children,
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Userdetails extends StatefulWidget {
  @override
  _UserdetailsState createState() => _UserdetailsState();
}

class _UserdetailsState extends State<Userdetails> {
  List<Employee> employees = <Employee>[];
  EmployeeDataSource? employeeDataSource;
  bool isLoading = true;
  int totalUsers = 0;
  @override
  void initState() {
    super.initState();
    fetchEmployeeData();
  }

  Future<void> fetchEmployeeData() async {
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection('firebase').get();
      if (snapshot.docs.isEmpty) {
        print("No documents found in 'employees' collection.");
      }
      int slno = 1;
      employees = snapshot.docs.map((doc) {
        var data = doc.data();
        print("Document data: $data");
        int age = 0;
        if (data['Age'] != null && data['Age'].toString().isNotEmpty) {
          try {
            age = int.parse(data['Age'].toString());
          } catch (e) {
            print("Error parsing age for document ${doc.id}: $e");
          }
        }
        return Employee(
          slno++,
          data['Image'] ?? '',
          data['User_Name'] ?? '',
          data['Place'] ?? '',
          age,
          data['Email'] ?? '',
          data['Mobile_No'] ?? '',
        );
      }).toList();
      totalUsers = employees.length;
      setState(() {
        employeeDataSource = EmployeeDataSource(employeeData: employees);
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffE72245),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: Colors.black,
              child: Text(
                "Total no of Users:$totalUsers    ",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
        title: const Text(
          'User Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : employeeDataSource == null || employees.isEmpty
              ? Center(child: Text('No data available'))
              : SfDataGrid(
                  allowFiltering: true,
                  allowSorting: true,
                  source: employeeDataSource!,
                  columnWidthMode: ColumnWidthMode.fill,
                  columns: <GridColumn>[
                    GridColumn(
                        columnName: 'id',
                        label: Container(
                            color: Colors.indigo,
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'ID',
                              style: TextStyle(color: Colors.white),
                            ))),
                    GridColumn(
                      columnName: 'img  ',
                      label: Container(
                        color: Colors.indigo,
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'image',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    GridColumn(
                        columnName: 'user_name',
                        label: Container(
                            color: Colors.indigo,
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Name',
                              style: TextStyle(color: Colors.white),
                            ))),
                    GridColumn(
                        columnName: 'place',
                        label: Container(
                            color: Colors.indigo,
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Place',
                              style: TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ))),
                    GridColumn(
                        columnName: 'age',
                        label: Container(
                            color: Colors.indigo,
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Age',
                              style: TextStyle(color: Colors.white),
                            ))),
                    GridColumn(
                        columnName: 'email',
                        label: Container(
                            color: Colors.indigo,
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'Email',
                              style: TextStyle(color: Colors.white),
                            ))),
                    GridColumn(
                      columnName: 'mobile_no',
                      label: Container(
                        color: Colors.indigo,
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Mobile No',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}

class Employee {
  Employee(this.id, this.img, this.user_name, this.place, this.age, this.email,
      this.mobile_no);

  final int id;
  final String img;

  final String user_name;

  final String place;
  final int age;
  final String email;
  final String mobile_no;
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'img', value: e.img),
              DataGridCell<String>(columnName: 'user_name', value: e.user_name),
              DataGridCell<String>(columnName: 'place', value: e.place),
              DataGridCell<String>(
                  columnName: 'age', value: e.age == 0 ? '' : e.age.toString()),
              DataGridCell<String>(columnName: 'email', value: e.email),
              DataGridCell<String>(columnName: 'mobile_no', value: e.mobile_no),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

 @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//       cells: row.getCells().map<Widget>((e) {
//         if (e.columnName == 'img') {
//           return Container(
//             color: Colors.pink[100],
//             alignment: Alignment.center,
//             padding: const EdgeInsets.all(8.0),
//             child: Image.network(
//               e.value.toString(),
//               fit: BoxFit.cover,
//               width: 50,
//               height: 50,
//               errorBuilder: (context, error, stackTrace) {
//                 return Icon(Icons.error, color: Colors.red);
//               },
//               loadingBuilder: (context, child, loadingProgress) {
//                 if (loadingProgress == null) return child;
//                 return Center(
//                   child: CircularProgressIndicator(
//                     value: loadingProgress.expectedTotalBytes != null
//                         ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
//                         : null,
//                   ),
//                 );
//               },
//             ),
//           );
//         } else {
//           return Container(
//             color: Colors.pink[100],
//             alignment: Alignment.center,
//             padding: const EdgeInsets.all(8.0),
//             child: Text(e.value.toString()),
//           );
//         }
//       }).toList(),
//     );
//   }
// }
 DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        if (e.columnName == 'img') {
          return Container(
            color: Colors.pink[100],
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: ClipOval(
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(e.value.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container(
            color: Colors.pink[100],
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }
      }).toList(),
    );
  }
}