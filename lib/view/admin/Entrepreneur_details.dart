import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Entrepreneurdetails extends StatefulWidget {
  @override
  _EntrepreneurdetailsState createState() => _EntrepreneurdetailsState();
}

class _EntrepreneurdetailsState extends State<Entrepreneurdetails> {
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
          await FirebaseFirestore.instance.collection('enterprenur').get();
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
          data['profileimage'] ?? '',
          data['EnterprenurName'] ?? '',
          data['location'] ?? '',
          age,
          data['EnterprenurEmail'] ?? '',
          data['EnterprenurNumber'] ?? '',
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
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                "Total no of Users: $totalUsers    ",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
        title: const Text(
          'Entrepreneur Details',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
        ),
        // backgroundColor: Colors.transparent,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            thickness: 2,
            color: Colors.black,
            height: 1,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
          color: Colors.black,
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
                              'Image',
                              style: TextStyle(color: Colors.white),
                            ))),
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
                            ))),
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
              DataGridCell<String>(columnName: 'profileimage', value: e.img),
              DataGridCell<String>(columnName: 'user_name', value: e.user_name),
              // DataGridCell<String>(columnName: 'user_name', value: e.user_name),

              DataGridCell<String>(columnName: 'location', value: e.place),

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
//     return  DataGridRowAdapter(
//       cells: row.getCells().map<Widget>((e) {
//         if (e.columnName == 'profileimage') {
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
        if (e.columnName == 'profileimage') {
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
