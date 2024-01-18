// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:personalexpenses/Widgets/chart.dart';
import 'package:personalexpenses/Widgets/new_transaction.dart';
import 'package:personalexpenses/Widgets/transaction_list.dart';

import 'Models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  return runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Personal Expenses',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
          appBarTheme: AppBarTheme(
            toolbarTextStyle: ThemeData.light()
                .textTheme
                .copyWith(
                  titleLarge: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
                .bodyText2,
            titleTextStyle: ThemeData.light()
                .textTheme
                .copyWith(
                  titleLarge: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
                .headline6,
          ),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.amber),
        ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget  {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();




  
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
@override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: '1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    // Transaction(
    //     id: '2',
    //     title: 'Weekly Groceries',
    //     amount: 16.53,
    //     date: DateTime.now()),
  ];
  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where((trs) =>
            trs.date!.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: chosenDate);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData myMediaQuery, AppBar appBar, final txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Show Chart"),
          Switch(
            focusColor: Colors.yellow,
            value: _showChart,
            onChanged: (value) {
              setState(() {
                _showChart = value;
              });
            },
          ),
        ],
      ),
      _showChart
          ? SizedBox(
              height: (myMediaQuery.size.height -
                      appBar.preferredSize.height -
                      myMediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions))
          : txListWidget
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData myMediaQuery, AppBar appBar, final txListWidget) {
    return [
      SizedBox(
          height: (myMediaQuery.size.height -
                  appBar.preferredSize.height -
                  myMediaQuery.padding.top) *
              0.3,
          child: Chart(_recentTransactions)),
      txListWidget
    ];
  }

  bool _showChart = false;
  
  @override
  Widget build(BuildContext context) {
    print('MyHomePage build() state');
    //final List<Transaction> transactions = [];
    // String? titleInput;
    // String? amountInput;
    final myMediaQuery = MediaQuery.of(context);
    final isLandscape = myMediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: const Text(
        "Personal Expenses",
        // style: TextStyle(fontFamily: 'OpenSans'),
      ),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add))
      ],
    );
    final txListWidget = SizedBox(
        height: (myMediaQuery.size.height -
                appBar.preferredSize.height -
                myMediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              ..._buildLandscapeContent(myMediaQuery, appBar, txListWidget),
            if (!isLandscape)
              ..._buildPortraitContent(myMediaQuery, appBar, txListWidget),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
