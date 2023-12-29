/* 
    Database Description (SQLITE): This database is a powerful tool for lenders, storing detailed information on property transactions. 
    It enables targeted lead generation by providing insights into prior transactions, 
    empowering lenders to make informed decisions and optimize their lending strategies.
*/

/* 
Table Description: "A Mortgage/SAM secures real property for the payment of a promissory note (debt) 
Purchase Money Mortgage, FHA (Federal Housing Admin.), Adjustable Rate Mortgage, 2nd Mortgage, Commercial, VA Loan."
*/

/* SAM Table Schema: */
CREATE TABLE IF NOT EXISTS SAM (
    FIPSCode TEXT NOT NULL, -- Numeric code which identifies every County/State in the United States.  First 2 bytes = State; last 3 = County | SAMPLE: 6037
    PropertyFullStreetAddress TEXT, -- For Address components, see Property Address fields on Assessment Tab (Fields #6-18). | SAMPLE: "6829 HANNA AVE"
    PropertyCityName TEXT, -- Not necessarily the same as Legal: City, Municipality, Township (Field #34). | SAMPLE: "CANOGA PARK"
    PropertyState TEXT, -- SAMPLE: "CA"
    PropertyZipCode TEXT, -- SAMPLE: "91303.0"
    PropertyZip4 TEXT, -- SAMPLE: "2321.0"
    PropertyUnitType TEXT, -- The data for the “unit type” data element is populated through the address standardization process and reflects USPS standard abbreviations and characters. Please refer to the USPS Postal Explorer pages for current C2 Secondary Unit Designators for a list of current descriptions. | SAMPLE: UNIT
    PropertyUnitNumber TEXT, -- May be different from Legal: Unit (Field #33). | SAMPLE: D
    PropertyHouseNumber TEXT, -- SAMPLE: 5728
    PropertyStreetDirectionLeft TEXT, -- SAMPLE: "N"
    PropertyStreetName TEXT, -- SAMPLE: "WILLOW GLEN"
    PropertyStreetSuffix TEXT, -- SAMPLE: "DR"
    PropertyStreetDirectionRight TEXT, -- SAMPLE: "N"
    PropertyAddressCarrierRoute TEXT, -- Format: C999
    RecordType TEXT, -- SAMPLE: "S"
    RecordingDate TEXT, -- The official date of the document recordation. YYYYMMDD -- SAMPLE: "20060824"
    RecorderBookNumber TEXT, -- Some counties only use Book & Page reference without the Document Number, others may use only the Document number. 
    RecorderPageNumber TEXT, -- See explanation for Book Number (Field #17). | SAMPLE: "22"
    RecorderDocumentNumber TEXT, -- Sequential number assigned to documents at the time of recording for identification and to establish the order of recordation. | SAMPLE: "08-0445902"
    APN TEXT, -- Assessor's Parcel Number or Parcel Identification Number.  When available on the document. | SAMPLE: "2144-002-001"
    MultiAPNFlag TEXT, -- Indicates the number of APNs (2-9) appearing on the conveying instrument.  Left blank if only one parcel.  See Code Description table. | SAMPLE: "6"
    Borrower1FirstNameMiddleName TEXT, -- The first name and middle name (when present) without abbreviations, or first name and middle initial (if that is how it appears on the document). | SAMPLE: "JOSE L"
    Borrower1LastNameOeCorporationName TEXT, /* If the last name is composed of two names, both are entered in the sequence they appear separated with a space, e.g. Mary B. Ashley Taylor, entered as:  ASHLEY TAYLOR
                                                Last names such as Mc Neil, O'Brien, etc. are entered with no space, apostrophe or any other punctuation e.g. OBRIEN, MCNEIL.
                                                Names followed by 2nd, 3rd, or 4th are entered in the last name field after the name as roman numerals:  2nd = SMITH II, 3rd = SMITH III, 4th = SMITH IV.
                                                All other title designations are entered after the last name, such as:  JR, SR, ESQ, PHD
                                                If Borrower Name is blurred or missing from document, this field will show:  
                                                NOT PROVIDED | SAMPLE: "RUBIO"
                                                */
    Borrower1IDCode TEXT, -- Used to identify the nature of each grantee keyed from the recorded document.  See "Code Desc" Tab.| SAMPLE: "HW"
    Borrower2FirstNameMiddleName TEXT, -- If a particular loan is taken by a group of two borrowers, then name of the second borrower will come here. there names will be mentioned here.
    Borrower2LastNameOrCorporationName TEXT, -- See definition for #1 - Borrower Last Name or Corporation (Field #22). | SAMPLE: "RUBIO"
    Borrower2IDCode TEXT, -- SAMPLE: "HW"
    BorrowerVestingCode TEXT, /* The vesting code, when present, indicates how the borrowers took title to the subject property.  See "Code Desc" Tab.  
                                Note:  The vesting codes EA and EU should not appear on records being keyed by IDM since we will be picking up all Buyer names involved in the transaction. However, these codes may still apply for transfer data purchased from a 3rd party vendor.*/
    LegalLotNumbers TEXT, -- The individual lot(s) which comprise the property.  The actual lot number(s) such as in a tract or subdivision.  If more than one, as many multiple lot numbers as allowed by the field length are entered, separated with a comma (,) or ampersand (&).  A hyphen is used to indicate a range (-).
    LegalBlock TEXT, -- The block of the subdivision or city in which the property is located.
    LegalSection TEXT, -- The section of the city in which the property is located.  Not the same as the “Section” of a Township-Range.  See Legal: Sec/Twn/Rng/Mer (Field #39).
    LegalDistrict TEXT, -- The district in which the property is located.  Usually a numeric code corresponding to the literal name in Legal: City, Municipality, Township (Field #34).
    LegalLandLot TEXT, -- A large portion or tract of land (which may also encompass many individual blocks or lots) in which the property is located.
    LegalUnit TEXT, -- The subdivision unit number.  Common for condominiums, townhomes, etc.  Not necessarily the same as the Property Unit Number (Field #8).
    LegalCityTownshipMunicipality TEXT, -- The jurisdiction in which the property is located.  May be “Unincorporated”, if applicable.  Often a description of the code provided in Legal: District (Field #31).  Not necessarily the same as the Property City (Field #3).
    LegalSubdivisionName TEXT, -- The name of the subdivision, plat, or tract in which the property is located.
    LegalPhaseNumber TEXT, -- Generally, the phase of a subdivision or tract development.
    LegalTractNumber TEXT, -- The number of the tract in which the property is located.   Followed by "POR" (portion of) when applicable. | SAMPLE: "19048"
    LegalBriefDescription TEXT, -- Lists exceptions, when only a portion of Block, Lot, Tract or Subdivision is entered in the specific field.   Or, when legal description components are not fielded, this field will be populated.
    LegalSectionTownshipRangeMeridian TEXT, -- Format: SEC 99 TWN 99A RNG 99A Where "A" = Directional (N/S for TWN and E/W for RNG)
    LenderNameBeneficiary TEXT, /* Name of the beneficiary.  When more that one Lender is reported, only the first Lender appearing on the document is entered.  If a Trust, along with Trustees appear as Lender, then only the Trust Name is entered.
                                    Note:  Whenever we encounter a mortgage/trust deed document that also references an Assignment of Mortgage, our practice is to capture the name of the Lender that ORIGINATED the loan, rather than the name of the Assignee Lender.
                                    | SAMPLE: "WELLS FARGO BANK NA"*/
    LenderNameID TEXT, -- An internal unique numeric code assigned to each identified lender.
    LenderType TEXT, /*
        B: Bank
        D: Lender/Agent role undisclosed - Used for encumbrance documents which fail to distinctly disclose the Lender/Beneficiary (like “Trust Deed 7 Individual” in Illinois counties), or in cases where the “Return to” party has been keyed as the Lender, because the body of the document omits the Lender/Beneficiary name and the “Return to” party not only appears to be an agent for the lender or is the actual lender, but also is not the Trustee or Borrower.
        E: Et al (and others)
        F: Finance Company
        G: Government (FHA, VA, etc.) - Used when the actual Lender servicing the loan on behalf of the government agency cannot be determined. If the lending institution can be determined then the Lender Code will reflect the institution.
        I: Insurance
        L: Lending institution
        M: Mortgage company
        N: Not Known
        O: Other (company or corporation)
        P: Private Party (individual)
        Q: MERS (Mortgage Electronic Registration System)
        R: REO/Foreclosure Company (appears as Seller Name on REOs)
        S: Seller
        U: Credit Union
        W: Internet Storefront
        X: Subprime Lender
        Z: Reverse Mortgage Lender
    */
    LoanAmount INTEGER, /*Whole dollars only. Not calculated when loan made in installments distributed on a monthly or annual basis.
                            Note: On Assumed Loans (Field #44 = "A"), the loan amount being assumed is entered here, if available.
                            | SAMPLE: 130000*/
    LoanType TEXT, /* Indicates the type of loan, if able to determine from the recorded document
                    1: Stand Alone First
                    2: Stand Alone Second
                    3: ARM (Adjustable Rate Mortgage)
                    4: Amount keyed is an Aggregate amount
                    5: USDA
                    6: Closed-end Mortgage
                    7: Non-Purchase Money Mortgage
                    8: SBA Participation Trust Deed
                    #: BKFS Internal use code only. Not for Vendor use. Code used for legacy clean up (2nd HECM).
                    A: Assumption
                    B: Building or Construction Loan
                    C: Cash (code phased out)
                    D: 2nd Mortgage made to cover Down Payment
                    E: Credit Line (Revolving)
                    F: FHA
                    G: Fannie Mae/Freddie Mac (Phased out keying in 2008 because Fannie Mae does not originate loans directly to borrowers or investors. Most "new conventional" loans meet their general underwriting guidelines.)
                    H: Balloon
                    I: Farmers Home Administration
                    J: Negative Amortization
                    K: Loan Amount $1-9 billion - only first 9-digits of Loan Amount entered due to field length limitations.  Need to multiply Loan Amount Field by 10 for the actual amount.
                    L: Land Contract (Argmt. Of Sale)
                    M: Modification - Originally designated to capture Hula Mae loans in Hawaii.  As with Fannie Mae/Freddie Mac, Hula Mae does not originate loans directly to borrowers.  This code now designates Mortgage Modifications which make a change to the Interest Rate, Loan Balance (except credit lines), Type Financing, or other Rate Rider terms.
                    N: New Conventional
                    O: Commercial
                    P: Purchase Money Mortgage
                    Q: Undefined / Multiple Amounts
                    R: Stand Alone Refi (Refinance of Original Loan)
                    S: Seller take-back
                    T: Loan Amount $10-99 billion - Only first nine digits of Loan Amount entered due to field length limitations.  Need to multiply Loan Amount field by 100 for the actual loan amount.
                    U: Unknown
                    V: VA
                    W: Future Advance Clause / Open End Mortgage
                    X: Trade
                    Y: State Veterans (code phased out)
                    Z: Reverse Mortgage (Home Equity Conversion Mortgage)*/
    TypeFinancing TEXT, /*When available will indicate the type of interest rate terms AND/OR see Loan Type (Field #44).  Left blank if unknown.  See "Code Desc" Tab.
                            Note:
                            1. When document indicates the loan is initiated at an Adjustable Rate, Type Financing will be "ADJ".
                            2. When document indicates the loan is initiated with a Fixed Rate, Type Financing will be "FIX".*/
    InterestRate TEXT, -- When available, initial rate as given on the trust deed or rider.  Input Format: 99v99 (implied decimal).
    DueDate TEXT, -- When available, the date the trust deed will be paid in full.  YYYYMMDD | SAMPLE: "20360801"
    AdjustableRateRider TEXT, -- (Y)es = an Adjustable Rate Rider recorded with the trust deed, else blank.
    AdjustableRateIndex TEXT, -- Identifies the type of index the adjustable loan is tied to.  See "Code Desc" Tab.
    ChangeIndex TEXT, -- Identifies the margin (expressed as a percentage) that is added by the Lender to the interest rate derived from the index.  If that is not available, then the value represents the maximum change in the interest rate at any one time. Input Format: 99v99 (implied decimal)
    RateChangeFrequency TEXT, -- Indicates the frequency the interest rates may change.  See "Code Desc" Tab.
    InterestRateNotGreaterThan TEXT, -- The maximum interest rate allowed on the first change date (date when loan switched from a fixed to an adjustable interest rate). Format: 99v99 (implied decimal)
    InterestRateNotLessThan TEXT, -- The minimum interest rate allowed on the first change date (date when loan switched from a fixed to an adjustable interest rate).Format: 99v99 (implied decimal)
    MaximumInterestRate TEXT, -- The maximum interest rate allowed for the loan. Format: 99v99 (implied decimal)
    InterestOnlyPeriod TEXT, -- If available, the actual interest only period (expressed in years) OR (Y)es = the loan has an interest-only period.
    FixedStepConversionRateRider TEXT, -- Indicates initial state of the interest rate (fixed, variable, etc) for the concurrent loan, if available.  See "Code Desc" Tab.
    FirstChangeDateYearConversionRider TEXT, -- The year that the loan converts from a FIXED to ADJUSTABLE interest rate.Format: YY (Two digit year; 2005 = "05")
    FirstChangeDateMonthDayConversionRider TEXT, -- The Month and Day that the loan converts from a FIXED to ADJUSTABLE interest rate.Format: MMDD
    PrepaymentRider TEXT, -- (Y)es = a Prepayment Rate Rider recorded with the trust deed.  Refer to Prepayment Term
    PrepaymentTermPenaltyRider TEXT, -- The number of months that the originated loan must remain active.  If the loan is paid off early, the borrower will pay a prepayment penalty.  Always expressed in months:  12, 18, 24, 36 are the most common.
    BuyerMailFullStreetAddress TEXT, -- For Street Address components, see Property Full Street Address on Assessment Tab.
    BorrowerMailUnitType TEXT, -- The data for the “unit type” data element is populated through the address standardization process and reflects USPS standard abbreviations and characters. Please refer to the USPS Postal Explorer pages for current C2 Secondary Unit Designators for a list of current descriptions.
    BorrowerMailUnitNumber TEXT, 
    BorrowerMailCity TEXT, -- See Assessment Tab - Assessee Mail: City Name.
    BorrowerMailState TEXT, -- "Two-letter standard postal abbreviation.XX = Foreign Mail Address"
    BorrowerMailZipCode TEXT, 
    BorrowerMailZip4 TEXT, -- Four-digit extension to postal zip code for the mailing address.  Not always available.
    OriginalDateOfContract TEXT, -- The date that the document was executed by the parties.  Pre-dates the recording date.  In some cases, may be the Notary Date.   YYYYMMDD | SAMPLE: "20080219.0"
    TitleCompanyName TEXT, -- Name of Title Company which issues the certificate of title insurance.  Not coded or abbreviated.If more than one Title Company Name is reported on the document, this field will report "Multiple" versus an actual Title Company Name. | SAMPLE: "FIRST AMERICAN TITLE INS"
    LenderDBAName TEXT, -- Lender DBA/AKA Name.  Not preceded with letters "DBA" or "AKA".  If present, Lender Care of Name is preceded by "C/O".  "DBA" takes priority over "C/O" if both are present on the same document.
    LenderMailFullStreetAddress TEXT, -- Lender Address keyed for Private Party Lenders only (LenderType = "P" or "S").  For Street Address components, see Property Full Street Address on Assessment Tab.Note:  Lender Zip keyed for all Lenders.
    LenderMailUnitType TEXT, -- The data for the “unit type” data element is populated through the address standardization process and reflects USPS standard abbreviations and characters. Please refer to the USPS Postal Explorer pages for current C2 Secondary Unit Designators for a list of current descriptions.
    LenderMailUnit TEXT, 
    LenderMailCity TEXT,
    LenderMailState TEXT,
    LenderMailZipCode TEXT, -- SAMPLE: "57104.0"
    LenderMailZip4 TEXT,
    LoanTermMonths TEXT, -- Term of the Loan expressed in Months (i.e. 360 months).   NOT calculated to populate field.Value will appear in this field OR Due Date or both will be blank.
    LoanTermYears TEXT, -- Term of the Loan expressed in Year (i.e. 30 years).   NOT calculated to populate field. Value will appear in this field OR Due Date or both will be blank.
    LoanNumber TEXT, -- When available on the document, the unique number assigned to the Loan.  Format varies. | SAMPLE: "651-651-2368611-1XXX"
    PID INTEGER NOT NULL, -- Auto-assigned internal ID for reference only. | SAMPLE: 4518954
    AssessorLandUse TEXT, -- Standardized Land Use derived from Assessment Record.  See Separate Land-Use Table. | SAMPLE: "1001"
    ResidentialIndicator BOOLEAN, -- Indicates Residential Use based on Assessor's Land Use.
    ConstructionLoan BOOLEAN, -- Indicates the concurrent mortgage is a building/ construction loan.  Loan Type = "B" 
    CashPurchase BOOLEAN, -- Indicates the concurrent mortgage is for cash.  Loan Type = "C" :
    StandAloneRefi BOOLEAN, -- Indicates the concurrent mortgage is a stand-alone second.  Loan Type = "2"
    EquityCreditLine BOOLEAN, -- Indicates the concurrent mortgage is a home equity credit line.  Loan Type = "E"
    PropertyUseCode TEXT, -- Property use as indicated on the trust deed (mortgage) and/or attached Rider.  See "Code Desc" Tab.
    LoanTransactionType TEXT, /* Current Valid Codes are:
        4=HELOCS (Purchase and Non-Purchase)
        5=REFI and 2nd Trust Deed (Purchase and Non-Purchase)
        7=Residential Resale Purchase Money Loan
        8=Construction Loan (Purchase Money and Non-Purchase)
        10=New Construction Purchase Money Loan
        11=Non-Residential Mortgages (Purchase and Non-Purchase)
    */
    MainRecordIDCode TEXT, -- Code that indicates the main/master record as well as additional APNs in a multi-parcel transaction record: M=Main Parcel, A=APN Addendum
    LoanOrganizationNMLS_ID TEXT, -- Loan Originator Company/Organization ID Number. Sometimes Referenced as NMLSR ID or Originator Company ID. 
    LoanOrganizationName TEXT, -- Name or Loan Originator Organization/Company as referenced on signature page of Mortgage Document - Also referenced as Creditor. 
    MortgageBrokerNMLS_ID TEXT, -- NMLS ID Recorded on the document for the originating Broker
    MortgageBroker TEXT, -- NMLS Broker Name Recorded on the document.
    LoanOfficerNMLS_ID TEXT, -- Loan Originator ID Number assigned to Individual Originating Loan. Sometimes  referenced as NMLSR ID or Originator ID
    LoanOfficerName TEXT, -- Full Name of Individual Loan Originator/Agent as referenced on signature page of Mortgage document
    DPID TEXT NOT NULL, -- Unique persistent ID of each property record | SAMPLE: "60370009291"
    UpdateTimeStamp TEXT NOT NULL, -- Timestamp applied to transaction records when the record is extracted. | SAMPLE: "20231122"
    borrower1_full_name TEXT, -- Full Name for Borrower 1
    borrower2_full_name TEXT -- Full Name for Borrower 2
    id INTEGER PRIMARY KEY
);

/* 
Table Description: A Deed transfers title to real estate property from the one person to another person and loan information on trust deeds tied to that recording. 
A Mortgage/SAM filed concurrently with the deed is also captured in the record.
Grant Deed, Quitclaim Deed, Trustee’s Deeds.
*/

/* Deed Table Schema: */
CREATE TABLE IF NOT EXISTS Deed (
    FIPSCode TEXT NOT NULL, /*Numeric code which identifies every County/State in the United States.  First 2 bytes = State; last 3 = County. */ -- SAMPLE: "6037" 
    PropertyFullStreetAddress TEXT, /*For Address components, see Property Address fields on Assessment Tab (Fields #6-18). */ -- SAMPLE: "6829 HANNA AVE"
    PropertyCityName TEXT, /*Not necessarily the same as Legal: City, Municipality, Township (Field #46).*/ -- SAMPLE: "CANOGA PARK"
    PropertyState TEXT, /*Property State*/ -- SAMPLE: "CA"
    PropertyZipCode TEXT, /*Property Zip Code*/ -- SAMPLE: "91303.0"
    PropertyZip4 TEXT, /*Property Zip + 4*/ -- SAMPLE: "2321.0"
    PropertyUnitType TEXT, /*The data for the “unit type” data element is populated through the address standardization process and reflects USPS standard abbreviations and characters. Please refer to the USPS Postal Explorer pages for current C2 Secondary Unit Designators for a list of current descriptions.*/
    PropertyUnitNumber TEXT, /*May be different from Legal: Unit (Field #45). */ -- SAMPLE: "D"
    PropertyHouseNumber TEXT, /*Property House Number from address standardization*/ -- SAMPLE: "6829"
    PropertyStreetDirectionLeft TEXT, /*Property Street Direction Left from address standardization*/ -- SAMPLE: "N"
    PropertyStreetName TEXT, /*Property Street Name from address standardization*/ -- SAMPLE: "HANNA"
    PropertyStreetSuffix TEXT, /*Property Street Suffix, USPS standards from address standardization*/ -- SAMPLE: "AVE"
    PropertyStreetDirectionRight TEXT, /*Property Street Direction Right from address standardization*/ -- SAMPLE: "N"
    PropertyAddressCarrierRoute TEXT, /*Format: C999*/ -- SAMPLE: "C014"
    RecordingDate TEXT, /*The official date of the document recordation. YYYYMMDD*/ -- SAMPLE: "19940701"
    RecorderBookNumber TEXT, /*Some counties only use Book & Page reference without the Document Number, others may use only the Document number.*/
    RecorderPageNumber TEXT, /*See explanation for Book Number (Field #16).*/ -- SAMPLE: "22"
    RecorderDocumentNumber TEXT, /*Sequential number assigned to documents at the time of recording for identification and to establish the order of recordation.*/ -- SAMPLE: "94-1262235"
    DocumentTypeCode TEXT, 
    APN TEXT, /*Assessor's Parcel Number or Parcel Identification Number.  When available on the document.*/ -- SAMPLE: "2024-006-022"
    MultiAPNFlag TEXT, /*Indicates the number of APNs (2-9) appearing on the conveying instrument.  Left blank if only one parcel.  See Code Description table.*/ -- SAMPLE: "6"
    PartialInterestTransferred TEXT, /*Whenever LESS than 100% ownership interest is transferred by the recorded instrument.  For example, a partner sells only his 50% interest.  This also applies to transfers where the Grantors entire ownership interest is LESS than 100%.  For example, the Grantor conveys all of his interest in the property, which is a 25% interest.  When the percentage is a single digit (1-9), it is preceded with a zero:  5% = 05.  When interest shown is a whole number plus a value after the decimal or fraction, it is rounded to nearest whole number only:  75.5% = 76;  33 1/3% = 33, etc. -- SAMPLE: "50"
    See Code Description table for other possible field values.
    Note:  If there are two or more parties each conveying a partial interest, where the total interest conveyed equals 100% - NOT a partial interest.*/
    "Seller1FirstName&MiddleName" TEXT, /*The first name and middle name (when present) without abbreviations, or first name and middle initial (if that is how it appears on the document).*/ -- SAMPLE: "DANIEL F"
    Seller1LastNameOrCorporation TEXT, /*If the last name is composed of two names, both are entered in the sequence they appear separated with a space, e.g. Mary B. Ashley Taylor, entered as:  -- SAMPLE: "RUBINSTEIN"
    Last names such as Mc Neil, O'Brien, etc. are entered with no space, apostrophe or any other punctuation e.g. OBRIEN, MCNEIL.
    Names followed by 2nd, 3rd, or 4th are entered in the last name field after the name as roman numerals:  2nd = SMITH II, 3rd = SMITH III, 4th = SMITH IV.
    All other title designations are entered after the last name, such as:  JR, SR, ESQ, PHD
    If Seller Name is blurred or missing from document, this field will show:  
    NOT PROVIDED*/
    Seller1IDCode TEXT, /*Used to identify the nature of each grantor keyed from the recorded document.  See Code Description table.  */ -- SAMPLE: "TR"
    "Seller2FirstName&MiddleName" TEXT, /*See definition for #1 - Seller First Name & Middle Name (Field #25).*/ -- SAMPLE: "ELAINE"
    Seller2LastNameOrCorporation TEXT, /*See definition for #1 - Seller Last Name or Corporation (Field #26).*/ -- SAMPLE: "RUBINSTEIN"
    Seller2IDCode TEXT, /*Used to identify the nature of each grantor keyed from the recorded document.  See Code Description table.  */ -- SAMPLE: "TR"
    "Buyer1FirstName&MiddleName" TEXT, /*The first name and middle name (when present) without abbreviations, or first name and middle initial (if that is how it appears on the document).*/ -- SAMPLE: "EDIK"
    "Buyer1LastNameOrCorporation" TEXT, /*If the last name is composed of two names, both are entered in the sequence they appear separated with a space, e.g. Mary B. Ashley Taylor, entered as:  ASHLEY TAYLOR
    Last names such as Mc Neil, O'Brien, etc. are entered with no space, apostrophe or any other punctuation e.g. OBRIEN, MCNEIL.
    Names followed by 2nd, 3rd, or 4th are entered in the last name field after the name as roman numerals:  2nd = SMITH II, 3rd = SMITH III, 4th = SMITH IV.
    All other title designations are entered after the last name, such as:  JR, SR, ESQ, PHD
    If Buyer Name is blurred or missing from document, this field will show:  
    NOT PROVIDED*/
    Buyer1IDCode TEXT, /*Used to identify the nature of each grantee keyed from the recorded document.  See Code Description table.  */ -- SAMPLE: "MM"
    "Buyer2FirstName&MiddleName" TEXT, /*See definition for #1 - Buyer First Name & Middle Name (Field #28).*/
    Buyer2LastNameOrCorporation TEXT, /*See definition for #1 - Buyer Last Name or Corporation (Field #29).*/
    Buyer2IDCode TEXT, /*Used to identify the nature of each grantee keyed from the recorded document.  See Code Description table.  */
    BuyerVestingCode TEXT, /*The vesting code, when present, indicates how the buyers took title to the subject property.  See Code Description table.  
    Note:  The vesting codes EA and EU should not appear on records being keyed by IDM since we will be picking up all Buyer names involved in the transaction. However, these codes may still apply for transfer data purchased from a 3rd party vendor.*/ -- SAMPLE: "MM"
    ConcurrentTDDocumentNumber TEXT, /*The sequential Document number or the Book/Page number assigned to the Concurrent Mortgage at the time of recording for identification and to establish the order of recordation.
    Note1:  The Document number takes priority if both Document number and Book and Page are recorded on the document.
    Note2:  If Book and Page values are keyed, separate the values with a slash ('/') Example: ""4778/456"" = Book 4778, Page 456*/
    BuyerMailCity TEXT, /*See Assessment Tab - Assessee Mail: City Name (Field #28).*/
    BuyerMailState TEXT, /*Two-letter standard postal abbreviation.
    XX = Foreign Mail Address*/
    BuyerMailZipCode TEXT, /*Buyer Mail: Zip Code*/
    BuyerMailZip4 TEXT, /*Four-digit extension to postal zip code for the mailing address.  Not always available.*/
    LegalLotCode TEXT, /*Identifies properties which include more than one lot or partial lots.  See Code Description table.*/
    LegalLotNumber TEXT, /*The individual lot(s) which comprise the property.  The actual lot number(s) such as in a tract or subdivision.  If more than one, as many multiple lot numbers as allowed by the field length are entered, separated with a comma (,) or ampersand (&).  A hyphen is used to indicate a range (-).  Refer to Lot Code (Field #39).*/
    LegalBlock TEXT, /*The block of the subdivision or city in which the property is located.*/
    LegalSection TEXT, /*The section of the city in which the property is located.  Not the same as the “Section” of a Township-Range.  See Legal: Sec/Twn/Rng/Mer (Field #51).*/
    LegalDistrict TEXT, /*The district in which the property is located.  Usually a numeric code corresponding to the literal name in Legal: City, Municipality, Township (Field #46).*/
    "LegalLand Lot" TEXT, /*A large portion or tract of land (which may also encompass many individual blocks or lots) in which the property is located.*/
    LegalUnit TEXT, /*The subdivision unit number.  Common for condominiums, townhomes, etc.  Not necessarily the same as the Property Unit Number (Field #8).*/
    LegalCity TEXT, /*The jurisdiction in which the property is located.  May be “Unincorporated”, if applicable.  Often a description of the code provided in Legal: District (Field #43).  Not necessarily the same as the Property City (Field #3).*/ -- SAMPLE: "LOS ANGELES"
    LegalSubdivisionName TEXT, /*The name of the subdivision, plat, or tract in which the property is located.*/
    LegalPhaseNumber TEXT, /*Generally, the phase of a subdivision or tract development.*/
    LegalTractNumber TEXT, /*The number of the tract in which the property is located.   Followed by "POR" (portion of) when applicable.*/
    LegalBriefDescription TEXT, /*Lists exceptions, when only a portion of Block, Lot, Tract or Subdivision is entered in the specific field.   Or, when legal description components are not fielded, this field will be populated.  Refer to Complete Legal Description Code (Field #75)*/
    LegalSectTownRangeMeridian TEXT, /*Format: SEC 99 TWN 99A RNG 99A
    Where ""A"" = Directional (N/S for TWN and E/W for RNG)*/
    RecorderMapReference TEXT, /*Standardized to identify each portion. Multiples indicated with the ampersand (&), and ranges separated with a hyphen (-). Depending on the length of the Map Reference, spaces may be omitted.*/
    BuyerMailingAddressCode TEXT, /*See Code Description table.  */
    PropertyUseCode TEXT, /*Property use as indicated on the trust deed (mortgage) and/or attached Rider.  See Code Description table.*/
    OriginalDateOfContract TEXT, /*The date that the document was executed by the parties.  Pre-dates the recording date.  In some cases, may be the Notary Date.  YYYYMMDD*/ -- SAMPLE: "19940630.0"
    SalesPrice INTEGER, /*Total Sales Price relating to all properties conveyed by the corresponding instrument.  If more than one parcel was included on the conveying instrument there is no way to allot the price to each parcel.  Whenever the recorded document (deed) indicates the actual sales price, it will be entered here in whole dollars - see Sales Price Code = "D" (Field #57).*/
    SalesPriceCode TEXT, /*See Code Description table.*/
    CityTransferTax TEXT, /*Applies in only designated cities where they levy a city tax on all purchase money real estate transfers within their jurisdiction.  Input Format: 99999v99 (implied decimal)*/
    CountyTransferTax TEXT, /*Generally appears in the form of a transfer tax stamp on the deed. The stamp amount represents a rate levied by the state per $1,000 of consideration paid in the transaction. Depending on the individual state, the stamp amount when converted to the actual transaction amount, using the corresponding rate, may represent the full sales price or only the amount of equity transferred. i.e. cash down plus any new financing.  Input Format: 99999v99 (implied decimal)*/
    TotalTransferTax TEXT, /*Unique to certain regions where you add the city and county transfer tax amounts to compute the full sales price.  Input Format: 999999v99 (implied decimal)*/
    ConcurrentTDLenderName TEXT, /*Name of the beneficiary to the first trust deed (mortgage).
    When more that one Lender is reported, only the first Lender appearing on the document is entered.  If a Trust, along with Trustees appear as Lender, then only the Trust Name is entered.
    Note:  Whenever we encounter a mortgage/trust deed document that also references an Assignment of Mortgage, our practice is to capture the name of the Lender that ORIGINATED the loan, rather than the name of the Assignee Lender.*/
    ConcurrentTDLenderType TEXT, /*See Code Description table.*/
    ConcurrentTDLoanAmount TEXT, /*Mortgage (purchase money) recorded concurrently with the conveying instrument. Reported in dollars only, no commas (,). Not calculated when loan made in installments distributed on a monthly or annual basis.
    Note: On Assumed Loans (Field #64 = ""A""), the loan amount being assumed is entered here, if available.*/
    ConcurrentTDLoanType TEXT, /*Indicates the type of loan, if able to determine from the recorded document.  See Code Description table.  */
    ConcurrentTDTypeFinancing TEXT, /*When available will indicate the type of interest rate terms for the concurrent TD AND/OR see Loan Type (Field #64).  Left blank if unknown.  See Code Description table.
    Note:
    1. When document indicates the loan is initiated at an Adjustable Rate, Type Financing will be ""ADJ"".
    2. When document indicates the loan is initiated with a Fixed Rate, Type Financing will be ""FIX"".*/
    ConcurrentTDInterestRate TEXT, /*When available, initial rate as given on the trust deed or rider.  Input Format: 99v99 (implied decimal)*/
    ConcurrentTDDueDate TEXT, /*When available, the date the concurrent trust deed will be paid in full.  Format:  YYYYMMDD*/
    Concurrent2ndTDLoanAmount INTEGER, /*Loan amount of second trust deed concurrent (subject to) to the original (1st) loan.*/
    BuyerMailFullStreetAddress TEXT, /*For Street Address components, see Property Full Street Address on Assessment Tab (Field #6).*/ -- SAMPLE: "7940 MELITA AVE"
    BuyerMailUnitType TEXT, /*The data for the “unit type” data element is populated through the address standardization process and reflects USPS standard abbreviations and characters. Please refer to the USPS Postal Explorer pages for current C2 Secondary Unit Designators for a list of current descriptions.*/
    BuyerMailUnitNumber TEXT, /*Buyer Mail: Unit Number*/
    PID INTEGER NOT NULL, /*Auto-assigned internal ID for reference only.*/ -- SAMPLE: 4518954
    BuyerMailCareOfName TEXT, /*If a C/O Name (%, C/O, Attn, etc.) is present, may not want to consider the address in Fields #35-38 & 69-71 as the actual Buyer Mail Address.*/
    TitleCompanyName TEXT, /*Name of Title Company which issues the certificate of title insurance.  
    Taken from the Deed and/or concurrent Trust Deed.  Not coded or abbreviated.
    If more than one Title Company Name is reported on the document, this field will report ""Multiple"" versus an actual Title Company Name.*/ -- SAMPLE: "FIRST AMERICAN TITLE INS"
    CompleteLegalDescriptionCode TEXT, /*See Code Description table.  */
    AdjustableRateRider TEXT, /*(Y)es = an Adjustable Rate Rider recorded with the trust deed, else blank.*/
    AdjustableRateIndex TEXT, /*Identifies the type of index the adjustable loan is tied to.  See Code Description table.*/
    ChangeIndex TEXT, /*Identifies the margin (expressed as a percentage) that is added by the Lender to the interest rate derived from the index.  If that is not available, then the value represents the maximum change in the interest rate at any one time.
    Input Format: 99v99 (implied decimal)*/
    RateChangeFrequency TEXT, /*Indicates the frequency the interest rates may change.  See Code Description table.*/
    InterestRateNotGreaterThan TEXT, /*The maximum interest rate allowed on the first change date (date when loan switched from a fixed to an adjustable interest rate).
    Format: 99v99 (implied decimal)*/
    InterestRateNotLessThan TEXT, /*The minimum interest rate allowed on the first change date (date when loan switched from a fixed to an adjustable interest rate).
    Format: 99v99 (implied decimal)*/
    MaximumInterestRate TEXT, /*The maximum interest rate allowed for the loan.
    Format: 99v99 (implied decimal)*/
    InterestOnlyPeriod TEXT, /*If available, the actual interest only period (expressed in years) OR 
    (Y)es = the loan has an interest-only period.*/
    FixedStepRateRider TEXT, /*Indicates initial state of the interest rate (fixed, variable, etc) for the concurrent loan, if available.  See Code Description table.*/
    FirstChangeDateYear TEXT, /*The year that the loan converts from a FIXED to ADJUSTABLE interest rate.  
    Format: YY (Two digit year; 2005 = ""05"")*/
    "FirstChangeDateMonth&Day" TEXT, /*The Month and Day that the loan converts from a FIXED to ADJUSTABLE interest rate.  
    Format: MMDD*/
    PrepaymentRider TEXT, /*(Y)es = a Prepayment Rate Rider recorded with the trust deed.  Refer to Prepayment Term (Field #88).*/
    PrepaymentTerm TEXT, /*The number of months that the originated loan must remain active.  If the loan is paid off early, the borrower will pay a prepayment penalty.  Always expressed in months:  12, 18, 24, 36 are the most common.*/
    AssessorLandUse TEXT, /*Standardized Land Use derived from Assessment Record.  See Separate Land-Use Table.*/
    ResidentialIndicator INTEGER, /*Indicates Residential Use based on Assessor's Land Use (Field #89).*/
    ConstructionLoan INTEGER, /*Indicates the concurrent mortgage is a building/ construction loan.  Loan Type (Field #64) = "B"*/
    InterFamily INTEGER, /*Indicates the document is an inter-family transfer.  Document Type (Field #19) = "IT"*/
    CashPurchase INTEGER, /*Indicates the concurrent mortgage is for cash.  Loan Type (Field #64) = "C"*/
    StandAloneRefi INTEGER, /*Indicates the concurrent mortgage is a stand-alone second.  Loan Type (Field #64) = "2"*/
    EquityCreditLine INTEGER, /*Indicates the concurrent mortgage is a home equity credit line.  Loan Type (Field #64) = "E"*/
    REOFlag INTEGER, /*0=NOT REO; 1=REO-IN; 2=REO-OUT*/
    DistressedSaleFlag TEXT, /*1 indicates transaction deemed to be a Distressed; 0 = No*/
    SellerMailAddressFullStreet TEXT, /*Seller Mail Address:  Full Street */
    SellerMailAddressUnitType TEXT, /*Seller Mail Address:  Unit Type*/
    SellerMailAddressUnitNumber TEXT, /*Seller Mail Address:  Unit Number*/
    SellerMailAddressCityName TEXT, /*Seller Mail Address:  City Name*/
    SellerMailAddressStateCode TEXT, /*Seller Mail Address:  State Code*/
    SellerMailAddressZipCode TEXT, /*Seller Mail Address:  Zip Code*/
    SellerMailAddressZip4 TEXT, /*Seller Mail Address:  Zip + 4*/
    DeedTransactionType TEXT, /*Current Valid Deed Codes are:
    1=Non-Arms length transfer
    2=Residential Resale
    3=Residential New Construction Sale
    6=Foreclosure or Distress Sale
    9=Insured Non-residential Grant Deeds*/
    LoanTransactionType TEXT, /*Current Valid Codes are:
    4=HELOCS (Purchase and Non-Purchase)
    5=REFI and 2nd Trust Deed (Purchase and Non-Purchase)
    7=Residential Resale Purchase Money Loan
    8=Construction Loan (Purchase Money and Non-Purchase)
    10=New Construction Purchase Money Loan
    11=Non-Residential Mortgages (Purchase and Non-Purchase)*/
    ShortSaleFlag TEXT, /*1=Yes, where arms' length sales have Sales Price / Previous Owner Active Loans <= 93%*/
    MainRecordIDCode TEXT, /*Code that indicates the main/master record as well as additional APNs in a multi-parcel transaction record: M=Main Parcel, A=APN Addendum*/ -- SAMPLE: "M"
    LoanOrganizationNMLS_ID TEXT, /*Loan Originator Company/Organization ID Number. Sometimes Referenced as NMLSR ID or Originator Company ID. */ -- SAMPLE: "1202262.0"
    LoanOrganizationName TEXT, /*Name or Loan Originator Organization/Company as referenced on signature page of Mortgage Document - Also referenced as Creditor. */ -- SAMPLE: "FUNDLOANS CAPITAL"
    MortgageBrokerNMLS_ID TEXT, /*NMLS ID Recorded on the document for the originating Broker*/ -- SAMPLE: "358345.0"
    MortgageBroker TEXT, /*NMLS Broker Name Recorded on the document.*/ -- SAMPLE: "FIRST AMERICAN TITLE INS" -- SAMPLE: "NATIONWIDE LENDING"
    LoanOfficerNMLS_ID TEXT, /*Loan Originator ID Number assigned to Individual Originating Loan. Sometimes  referenced as NMLSR ID or Originator ID*/ -- SAMPLE: "250639.0"
    LoanOfficerName TEXT, /*Full Name of Individual Loan Originator/Agent as referenced on signature page of Mortgage document*/ -- SAMPLE: "PRASLIN, SERGIO"
    DPID TEXT, /*Unique persistent ID of each property record*/ -- SAMPLE: "60370009291"
    UpdateTimeStamp TEXT NOT NULL, /*Timestamp applied to transaction records when the record is extracted.*/ -- SAMPLE: "20231122"
    borrower1_full_name TEXT, -- Full Name for Borrower 1
    borrower2_full_name TEXT -- Full Name for Borrower 2
);

/* Queries */
-- Query 1: Find ten random properties from SAM Table and return the all the deeds associated with those properties using join.
SELECT * FROM SAM
JOIN Deed
ON SAM.DPID = Deed.DPID
ORDER BY RANDOM()
LIMIT 10;