# finaltest
A simple banking app built using Flutter, which allows users to:

View their accounts (Chequing & Savings)
Check their balances
View transaction history
Deposit & withdraw money dynamically
Navigate between screens easily

Requirements
Ensure you have:
Flutter SDK installed (flutter --version)
Dart installed

Future Enhancements
 Connect to Firebase for real-time transactions
 Store accounts & transactions in a database (SQLite or Firestore)
 Add authentication (Login & Sign-up functionality)
 Implement UI improvements (Animations & themes)

I used chat gpt, github copilot

Accounts Data (Embedded in main.dart
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

Transactions Data (Embedded in main.dart)
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

