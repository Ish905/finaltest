import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(BankingApp());
}

class BankingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Enhanced Banking App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Banking App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to Your Bank!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountsScreen()),
                );
              },
              child: Text("View Accounts"),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountsScreen extends StatefulWidget {
  @override
  _AccountsScreenState createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  List accounts = json.decode('''
  {
    "accounts": [
      {
        "type": "Chequing",
        "account_number": "CHQ123456789",
        "balance": 2500.00
      },
      {
        "type": "Savings",
        "account_number": "SAV987654321",
        "balance": 5000.00
      }
    ]
  }
  ''')['accounts'];

  void updateBalance(String accountType, double amount) {
    setState(() {
      for (var account in accounts) {
        if (account['type'] == accountType) {
          account['balance'] += amount;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Accounts")),
      body: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text("${accounts[index]['type']} Account"),
              subtitle: Text("Account No: ${accounts[index]['account_number']}"),
              trailing: Text(
                "\$${accounts[index]['balance'].toStringAsFixed(2)}",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransactionsScreen(
                      accountType: accounts[index]['type'],
                      balance: accounts[index]['balance'],
                      updateBalance: updateBalance,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class TransactionsScreen extends StatefulWidget {
  final String accountType;
  final double balance;
  final Function(String, double) updateBalance;

  TransactionsScreen({required this.accountType, required this.balance, required this.updateBalance});

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  List transactions = [];

  final String transactionsData = '''
  {
    "transactions": {
      "Chequing": [
        {"date": "2024-04-14", "description": "Utility Bill Payment", "amount": -120.00},
        {"date": "2024-04-16", "description": "ATM Withdrawal", "amount": -75.00},
        {"date": "2024-04-17", "description": "Deposit", "amount": 100.00}
      ],
      "Savings": [
        {"date": "2024-04-12", "description": "Withdrawal", "amount": -300.00},
        {"date": "2024-04-15", "description": "Interest", "amount": 10.00},
        {"date": "2024-04-16", "description": "Deposit", "amount": 200.00}
      ]
    }
  }
  ''';

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> data = json.decode(transactionsData);
    transactions = data['transactions'][widget.accountType] ?? [];
  }

  void addTransaction(String description, double amount) {
    setState(() {
      transactions.add({
        "date": DateTime.now().toString().split(' ')[0],
        "description": description,
        "amount": amount,
      });
    });

    widget.updateBalance(widget.accountType, amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.accountType} Transactions")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Balance: \$${widget.balance.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(transactions[index]['description']),
                    subtitle: Text(transactions[index]['date']),
                    trailing: Text(
                      "\$${transactions[index]['amount'].toStringAsFixed(2)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: transactions[index]['amount'] < 0 ? Colors.red : Colors.green,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    addTransaction("Deposit", 100);
                  },
                  child: Text("Deposit \$100"),
                ),
                ElevatedButton(
                  onPressed: () {
                    addTransaction("Withdrawal", -50);
                  },
                  child: Text("Withdraw \$50"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
