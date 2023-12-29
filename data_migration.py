import sqlite3
import pandas as pd

# Create Tables
def create_tables(cursor, conn, DROP_ALL = False):
    if DROP_ALL:
        cursor.execute('''DROP TABLE IF EXISTS Deed''')
        cursor.execute('''DROP TABLE IF EXISTS SAM''')

    # Create Deed Table 
    cursor.execute('''CREATE TABLE IF NOT EXISTS Deed (
        FIPSCode TEXT NOT NULL,
        PropertyFullStreetAddress TEXT,
        PropertyCityName TEXT,
        PropertyState TEXT,
        PropertyZipCode TEXT,
        PropertyZip4 TEXT,
        PropertyUnitType TEXT,
        PropertyUnitNumber TEXT,
        PropertyHouseNumber TEXT,
        PropertyStreetDirectionLeft TEXT,
        PropertyStreetName TEXT,
        PropertyStreetSuffix TEXT,
        PropertyStreetDirectionRight TEXT,
        PropertyAddressCarrierRoute TEXT,
        RecordingDate TEXT,
        RecorderBookNumber TEXT,
        RecorderPageNumber TEXT,
        RecorderDocumentNumber TEXT,
        DocumentTypeCode TEXT,
        APN TEXT,
        MultiAPNFlag TEXT,
        PartialInterestTransferred TEXT,
        "Seller1FirstName&MiddleName" TEXT,
        Seller1LastNameOrCorporation TEXT,
        Seller1IDCode TEXT,
        "Seller2FirstName&MiddleName" TEXT,
        Seller2LastNameOrCorporation TEXT,
        Seller2IDCode TEXT,
        "Buyer1FirstName&MiddleName" TEXT,
        Buyer1LastNameOrCorporation TEXT,
        Buyer1IDCode TEXT,
        "Buyer2FirstName&MiddleName" TEXT,
        Buyer2LastNameOrCorporation TEXT,
        Buyer2IDCode TEXT,
        BuyerVestingCode TEXT,
        ConcurrentTDDocumentNumber TEXT,
        BuyerMailCity TEXT,
        BuyerMailState TEXT,
        BuyerMailZipCode TEXT,
        BuyerMailZip4 TEXT,
        LegalLotCode TEXT,
        LegalLotNumber TEXT,
        LegalBlock TEXT,
        LegalSection TEXT,
        LegalDistrict TEXT,
        "LegalLand Lot" TEXT,
        LegalUnit TEXT,
        LegalCity TEXT,
        LegalSubdivisionName TEXT,
        LegalPhaseNumber TEXT,
        LegalTractNumber TEXT,
        LegalBriefDescription TEXT,
        LegalSectTownRangeMeridian TEXT,
        RecorderMapReference TEXT,
        BuyerMailingAddressCode TEXT,
        PropertyUseCode TEXT,
        OriginalDateOfContract TEXT,
        SalesPrice INTEGER,
        SalesPriceCode TEXT,
        CityTransferTax TEXT,
        CountyTransferTax TEXT,
        TotalTransferTax TEXT,
        ConcurrentTDLenderName TEXT,
        ConcurrentTDLenderType TEXT,
        ConcurrentTDLoanAmount TEXT,
        ConcurrentTDLoanType TEXT,
        ConcurrentTDTypeFinancing TEXT,
        ConcurrentTDInterestRate TEXT,
        ConcurrentTDDueDate TEXT,
        Concurrent2ndTDLoanAmount INTEGER,
        BuyerMailFullStreetAddress TEXT,
        BuyerMailUnitType TEXT,
        BuyerMailUnitNumber TEXT,
        PID INTEGER NOT NULL,
        BuyerMailCareOfName TEXT,
        TitleCompanyName TEXT,
        CompleteLegalDescriptionCode TEXT,
        AdjustableRateRider TEXT,
        AdjustableRateIndex TEXT,
        ChangeIndex TEXT,
        RateChangeFrequency TEXT,
        InterestRateNotGreaterThan TEXT,
        InterestRateNotLessThan TEXT,
        MaximumInterestRate TEXT,
        InterestOnlyPeriod TEXT,
        FixedStepRateRider TEXT,
        FirstChangeDateYear TEXT,
        "FirstChangeDateMonth&Day" TEXT,
        PrepaymentRider TEXT,
        PrepaymentTerm TEXT,
        AssessorLandUse TEXT,
        ResidentialIndicator INTEGER,
        ConstructionLoan INTEGER,
        InterFamily INTEGER,
        CashPurchase INTEGER,
        StandAloneRefi INTEGER,
        EquityCreditLine INTEGER,
        REOFlag INTEGER,
        DistressedSaleFlag TEXT,
        SellerMailAddressFullStreet TEXT,
        SellerMailAddressUnitType TEXT,
        SellerMailAddressUnitNumber TEXT,
        SellerMailAddressCityName TEXT,
        SellerMailAddressStateCode TEXT,
        SellerMailAddressZipCode TEXT,
        SellerMailAddressZip4 TEXT,
        DeedTransactionType TEXT,
        LoanTransactionType TEXT,
        ShortSaleFlag TEXT,
        MainRecordIDCode TEXT,
        LoanOrganizationNMLS_ID TEXT,
        LoanOrganizationName TEXT,
        MortgageBrokerNMLS_ID TEXT,
        MortgageBroker TEXT,
        LoanOfficerNMLS_ID TEXT,
        LoanOfficerName TEXT,
        DPID TEXT,
        UpdateTimeStamp TEXT NOT NULL,
        borrower1_full_name TEXT,
        borrower2_full_name TEXT,
        id INTEGER PRIMARY KEY)''')

    # Create SAM Table
    cursor.execute('''CREATE TABLE IF NOT EXISTS SAM (
        FIPSCode TEXT NOT NULL,
        PropertyFullStreetAddress TEXT,
        PropertyCityName TEXT,
        PropertyState TEXT,
        PropertyZipCode TEXT,
        PropertyZip4 TEXT,
        PropertyUnitType TEXT,
        PropertyUnitNumber TEXT,
        PropertyHouseNumber TEXT,
        PropertyStreetDirectionLeft TEXT,
        PropertyStreetName TEXT,
        PropertyStreetSuffix TEXT,
        PropertyStreetDirectionRight TEXT,
        PropertyAddressCarrierRoute TEXT,
        RecordType TEXT,
        RecordingDate TEXT,
        RecorderBookNumber TEXT,
        RecorderPageNumber TEXT,
        RecorderDocumentNumber TEXT,
        APN TEXT,
        MultiAPNFlag TEXT,
        Borrower1FirstNameMiddleName TEXT,
        Borrower1LastNameOeCorporationName TEXT,
        Borrower1IDCode TEXT,
        Borrower2FirstNameMiddleName TEXT,
        Borrower2LastNameOrCorporationName TEXT,
        Borrower2IDCode TEXT,
        BorrowerVestingCode TEXT,
        LegalLotNumbers TEXT,
        LegalBlock TEXT,
        LegalSection TEXT,
        LegalDistrict TEXT,
        LegalLandLot TEXT,
        LegalUnit TEXT,
        LegalCityTownshipMunicipality TEXT,
        LegalSubdivisionName TEXT,
        LegalPhaseNumber TEXT,
        LegalTractNumber TEXT,
        LegalBriefDescription TEXT,
        LegalSectionTownshipRangeMeridian TEXT,
        LenderNameBeneficiary TEXT,
        LenderNameID TEXT,
        LenderType TEXT,
        LoanAmount INTEGER,
        LoanType TEXT,
        TypeFinancing TEXT,
        InterestRate TEXT,
        DueDate TEXT,
        AdjustableRateRider TEXT,
        AdjustableRateIndex TEXT,
        ChangeIndex TEXT,
        RateChangeFrequency TEXT,
        InterestRateNotGreaterThan TEXT,
        InterestRateNotLessThan TEXT,
        MaximumInterestRate TEXT,
        InterestOnlyPeriod TEXT,
        FixedStepConversionRateRider TEXT,
        FirstChangeDateYearConversionRider TEXT,
        FirstChangeDateMonthDayConversionRider TEXT,
        PrepaymentRider TEXT,
        PrepaymentTermPenaltyRider TEXT,
        BuyerMailFullStreetAddress TEXT,
        BorrowerMailUnitType TEXT,
        BorrowerMailUnitNumber TEXT,
        BorrowerMailCity TEXT,
        BorrowerMailState TEXT,
        BorrowerMailZipCode TEXT,
        BorrowerMailZip4 TEXT,
        OriginalDateOfContract TEXT,
        TitleCompanyName TEXT,
        LenderDBAName TEXT,
        LenderMailFullStreetAddress TEXT,
        LenderMailUnitType TEXT,
        LenderMailUnit TEXT,
        LenderMailCity TEXT,
        LenderMailState TEXT,
        LenderMailZipCode TEXT,
        LenderMailZip4 TEXT,
        LoanTermMonths TEXT,
        LoanTermYears TEXT,
        LoanNumber TEXT,
        PID INTEGER NOT NULL,
        AssessorLandUse TEXT,
        ResidentialIndicator BOOLEAN,
        ConstructionLoan BOOLEAN,
        CashPurchase BOOLEAN,
        StandAloneRefi BOOLEAN,
        EquityCreditLine BOOLEAN,
        PropertyUseCode TEXT,
        LoanTransactionType TEXT,
        MainRecordIDCode TEXT,
        LoanOrganizationNMLS_ID TEXT,
        LoanOrganizationName TEXT,
        MortgageBrokerNMLS_ID TEXT,
        MortgageBroker TEXT,
        LoanOfficerNMLS_ID TEXT,
        LoanOfficerName TEXT,
        DPID TEXT NOT NULL,
        borrower1_full_name TEXT,
        borrower2_full_name TEXT,
        UpdateTimeStamp TEXT NOT NULL,
        id INTEGER PRIMARY KEY)''')

    # Commit the changes
    conn.commit()

# CSV to VALUES
def csv_to_values(file_path):
    df = pd.read_csv(file_path)

    column_to_drop = '_id'

    if column_to_drop in df.columns:
        df = df.drop(column_to_drop, axis=1)

    # Rename the 'OldName' column to 'NewName'
    if '2ndAssesseeOwnerNameDBA' in df.columns:
        df.rename(columns={'2ndAssesseeOwnerNameDBA': '#2ndAssesseeOwnerNameDBA'}, inplace=True)
    
    if '2ndAssesseeOwnerNameIndicator' in df.columns:
        df.rename(columns={'2ndAssesseeOwnerNameIndicator': '#2ndAssesseeOwnerNameIndicator'}, inplace=True)
    
    if '2ndAssesseeOwnerNameType' in df.columns:
        df.rename(columns={'2ndAssesseeOwnerNameType': '#2ndAssesseeOwnerNameType'}, inplace=True)
    
    # Replace NaN with empty string
    df.fillna('', inplace=True)

    borrower1_full_name = (df["Buyer1FirstName&MiddleName"] if "Buyer1FirstName&MiddleName" in df.columns else df["Borrower1FirstNameMiddleName"]).astype(str) + " " + (df["Buyer1LastNameOrCorporation"] if "Buyer1LastNameOrCorporation" in df.columns else df["Borrower1LastNameOeCorporationName"]).astype(str)
    borrower2_full_name = (df["Buyer2FirstName&MiddleName"] if "Buyer2FirstName&MiddleName" in df.columns else df["Borrower2FirstNameMiddleName"]).astype(str) + " " + (df["Buyer2LastNameOrCorporation"] if "Buyer2LastNameOrCorporation" in df.columns else df["Borrower2LastNameOrCorporationName"]).astype(str)
    
    # Adding 
    df['borrower1_full_name'] = borrower1_full_name
    df['borrower2_full_name'] = borrower2_full_name

    # Assuming the CSV file has a header row
    return df.to_records(index=False)

# Get Columns
def get_joined_columns(list_of_columns_headers):
    return ', '.join([f'"{header}"' for header in list_of_columns_headers])

# Get Values
def get_joined_values(list_of_values):
    return ', '.join([str(tuple(row)) for row in list_of_values]).replace("\\'", "''")

def insert_data(cursor, conn, csv_file_path, table_name):
    print("Table Name: ", table_name)
    bulk_insert_values = csv_to_values(csv_file_path)

    # Constructing the SQL statement
    columns_str = get_joined_columns(bulk_insert_values.dtype.names)
    values_str = get_joined_values(bulk_insert_values)
    sql_statement = f"INSERT INTO {table_name} ({columns_str}) VALUES {values_str};"

    print("Inserting Values In Table: ", table_name)
    cursor.execute(sql_statement)
    conn.commit()

if __name__ == '__main__':
    # Establish connection
    conn = sqlite3.connect('black_night.db') # Will be create if not present

    # Initialize cursor obj
    cursor = conn.cursor()

    # Create tables
    create_tables(cursor, conn, True) # DROP_ALL = True/FALSE (Default: False)


    # Insert Deed Data
    insert_data(cursor, conn, './input/sample_data_complete_deed.csv', 'Deed')

    # Insert SAM Data
    insert_data(cursor, conn, './input/sample_data_complete_mortgage.csv', 'SAM')


    # Close connection
    conn.close()