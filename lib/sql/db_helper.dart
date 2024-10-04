import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class DBHelper {
  DBHelper._();

  static final DBHelper getInstance = DBHelper._();

  static const String TABLE_USERS = 'users';
  static const String COLUMN_USERS_UNAME = 'uname';
  static const String COLUMN_USERS_PWD = 'pwd';

  static const String TABLE_INSURANCE = 'insurance';
  static const String COLUMN_INSURANCE_SNO = 'sno';
  static const String COLUMN_INSURANCE_INSURANCEPROVIDER = 'insurance_provider';
  static const String COLUMN_INSURANCE_POLICYNUMBER = 'policy_number';
  static const String COLUMN_INSURANCE_POLICYNAME = 'policy_name';
  static const String COLUMN_INSURANCE_POLICYHOLDER = 'policy_holder';
  static const String COLUMN_INSURANCE_LIFEINSURED = 'life_insured';
  static const String COLUMN_INSURANCE_SUMASSURED = 'sum_assured';
  static const String COLUMN_INSURANCE_NOMINEE = 'nominee';
  static const String COLUMN_INSURANCE_POLICYPAYMENTTERM = 'policy_payment_term';
  static const String COLUMN_INSURANCE_PREMIUMPAYMENTFREQUENCY = 'premium_payment_frequency';
  static const String COLUMN_INSURANCE_LASTPREMIUMPAID = 'last_premium_paid';
  static const String COLUMN_INSURANCE_NEXTPREMIUMDUE = 'next_premium_due';
  static const String COLUMN_INSURANCE_MATURITYDATE = 'maturity_date';
  static const String COLUMN_INSURANCE_MATURITYAMOUNT = 'maturity_amount';
  
  static const String TABLE_DEPOSITS = 'deposits';
  static const String COLUMN_DEPOSITS_SNO = 'sno';
  static const String COLUMN_DEPOSITS_FINANCIALORGANIZATION = 'financial_organization';
  static const String COLUMN_DEPOSITS_NAMEOFFINANCIALINSTITUTION = 'name_of_financial_institution';
  static const String COLUMN_DEPOSITS_BRANCHADDRESS = 'branch_address';
  static const String COLUMN_DEPOSITS_TYPEOFINVESTMENT = 'type_of_investment';
  static const String COLUMN_DEPOSITS_INVESTMENTNUMBER = 'investment_number';
  static const String COLUMN_DEPOSITS_INVESTMENTHOLDER = 'investment_holder';
  static const String COLUMN_DEPOSITS_NOMINEE = 'nominee';
  static const String COLUMN_DEPOSITS_NOMINEEGUARDIAN = 'nominee_guardian';
  static const String COLUMN_DEPOSITS_INVESTMENTAMOUNT = 'investment_amount';
  static const String COLUMN_DEPOSITS_RATEOFINTEREST = 'rate_of_interest';
  static const String COLUMN_DEPOSITS_INVESTMENTDATE = 'investment_date';
  static const String COLUMN_DEPOSITS_INVESTMENTDURATION = 'investment_duration';
  static const String COLUMN_DEPOSITS_MATURITYDATE = 'maturity_date';
  static const String COLUMN_DEPOSITS_MATURITYAMOUNT = 'maturity_amount';

  

  // database stuff
  Database? myDB;

  // opening database
  Future<Database> getDB() async {
    myDB ??= await openDB();
    return myDB!;
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();

    String dbPath = join(appDir.path, 'financedb.db');

    return await openDatabase(
      dbPath,
      onCreate: (db, version) {
        db.execute('''
          create table $TABLE_USERS(
            $COLUMN_USERS_UNAME   text,
            $COLUMN_USERS_PWD     text
          )
        ''');
        db.execute('''
          create table $TABLE_INSURANCE(
            $COLUMN_INSURANCE_SNO                     integer primary key autoincrement,
            $COLUMN_INSURANCE_INSURANCEPROVIDER       text,
            $COLUMN_INSURANCE_POLICYNUMBER            text,
            $COLUMN_INSURANCE_POLICYNAME              text,
            $COLUMN_INSURANCE_POLICYHOLDER            text,
            $COLUMN_INSURANCE_LIFEINSURED             text,
            $COLUMN_INSURANCE_SUMASSURED              text,
            $COLUMN_INSURANCE_NOMINEE                 text,
            $COLUMN_INSURANCE_POLICYPAYMENTTERM       int,
            $COLUMN_INSURANCE_PREMIUMPAYMENTFREQUENCY int,
            $COLUMN_INSURANCE_LASTPREMIUMPAID         text,
            $COLUMN_INSURANCE_NEXTPREMIUMDUE          text,
            $COLUMN_INSURANCE_MATURITYDATE            text,
            $COLUMN_INSURANCE_MATURITYAMOUNT          real
          )
        ''');
        db.execute('''
          create table $TABLE_DEPOSITS(
            $COLUMN_DEPOSITS_FINANCIALORGANIZATION      text,
            $COLUMN_DEPOSITS_NAMEOFFINANCIALINSTITUTION text,
            $COLUMN_DEPOSITS_BRANCHADDRESS              text,
            $COLUMN_DEPOSITS_TYPEOFINVESTMENT           text,
            $COLUMN_DEPOSITS_INVESTMENTNUMBER           text,
            $COLUMN_DEPOSITS_INVESTMENTHOLDER           text,
            $COLUMN_DEPOSITS_NOMINEE                    text,
            $COLUMN_DEPOSITS_NOMINEEGUARDIAN            text,
            $COLUMN_DEPOSITS_INVESTMENTAMOUNT           real,
            $COLUMN_DEPOSITS_RATEOFINTEREST             real,
            $COLUMN_DEPOSITS_INVESTMENTDATE             text,
            $COLUMN_DEPOSITS_INVESTMENTDURATION         text,
            $COLUMN_DEPOSITS_MATURITYDATE               text,
            $COLUMN_DEPOSITS_MATURITYAMOUNT             float
          )
        ''');
      },
      version: 1,
    );
  }

  Future<bool> addUser({
    required String uname,
    required String pwd
  }) async {
    var db = await getDB();

    int rowsAffected = await db.insert(TABLE_USERS, {COLUMN_USERS_UNAME: uname, COLUMN_USERS_PWD: pwd});

    return rowsAffected > 0;
  }

  Future<bool> addInsurance({
    required String insuranceProvider,
    required String policyNumber,
    required String policyName,
    required String policyHolder,
    required String lifeInsured,
    required String sumAssured,
    required String nominee,
    required int policyPaymentTerm,
    required int premiumPaymentFrequency,
    required String lastPremiumPaid,
    required String nextPremiumDue,
    required String maturityDate,
    required double maturityAmount
  }) async {
    var db = await getDB();

    int rowsAffected = await db.insert(
      TABLE_INSURANCE,
      {
        COLUMN_INSURANCE_INSURANCEPROVIDER: insuranceProvider,
        COLUMN_INSURANCE_POLICYNUMBER: policyNumber,
        COLUMN_INSURANCE_POLICYNAME: policyName,
        COLUMN_INSURANCE_POLICYHOLDER: policyHolder,
        COLUMN_INSURANCE_LIFEINSURED: lifeInsured,
        COLUMN_INSURANCE_SUMASSURED: sumAssured,
        COLUMN_INSURANCE_NOMINEE: nominee,
        COLUMN_INSURANCE_POLICYPAYMENTTERM: policyPaymentTerm,
        COLUMN_INSURANCE_PREMIUMPAYMENTFREQUENCY: premiumPaymentFrequency,
        COLUMN_INSURANCE_LASTPREMIUMPAID: lastPremiumPaid,
        COLUMN_INSURANCE_NEXTPREMIUMDUE: nextPremiumDue,
        COLUMN_INSURANCE_MATURITYDATE: maturityDate,
        COLUMN_INSURANCE_MATURITYAMOUNT: maturityAmount
      }
    );

    return rowsAffected > 0;
  }
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    var db = await getDB();

    List<Map<String, dynamic>> userData = await db.query(TABLE_USERS);

    return userData;
  }

  Future<List<Map<String, dynamic>>> getAllInsurance() async {
    var db = await getDB();

    List<Map<String, dynamic>> insuranceData = await db.query(TABLE_INSURANCE);

    return insuranceData;
  }

  Future<List<Map<String, dynamic>>> getAllDeposits() async {
    var db = await getDB();

    List<Map<String, dynamic>> depositsData = await db.query(TABLE_DEPOSITS);

    return depositsData;
  }
}