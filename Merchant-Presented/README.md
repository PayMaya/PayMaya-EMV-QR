# PayMaya EMV Merchant Presented QR Code Specification for Payment Systems

* Author: Edge Dalmacio <edge.dalmacio@paymaya.com>
* Created: 2018-02-15
* Last modified: 2019-05-22
* Status: Version 1.1

# Introduction

## Purpose
This document provides:

*   A brief description of merchant presented EMV QR Code payment and the entities involved.
*   The requirements on the QR Code displayed by the merchant, including format and content.

The processing of the QR Code by the mobile application and the network messages as a result of this processing are out of scope of this document.

## Normative References

| Reference | Publication Name |
|-----------|------------------|
| [ISO/IEC 18004] | Information technology - Automatic identification and data capture techniques - QR Code barcode symbology specification |
| [ISO 18245] | Retail financial services - Merchant category codes |
| [ISO/IEC 13239] | Information technology - Telecommunications and information exchange between systems - High-level data link control (HDLC) procedures |
| [ISO 3166-1 alpha 2] | Codes for the representation of names of countries and their subdivisions - Part 1: Country code, using two-letter country codes |
| [ISO 4217] | Codes for the representation of currencies and funds |
| [ISO 7816-4] | Identification cards - Integrated circuit cards - Part 4: Organization, security and commands for interchange |
| [ISO 639] | Codes for the representation of names of languages - Part 1: Alpha - 2 Code |
| [ISO 9362] | The elements and structure of a universal identifier code, the business identifier code (BIC), for financial and non-financial institutions |
| [EMV Book 4] | Codes for the representation of names of languages - Part 1: Alpha - 2 Code |
| [Unicode] | Unicode Standard, specifically the UTF-8 encoding form. For more information, please check: http://www.unicode.org/versions/latest |
| [UUID] | A universally unique identifier (UUID) as defined in the Internet Engineering Task Force (IETF) RFC 4122:https://tools.ietf.org/html/rfc4122 |

## Notational Conventions

### Abbreviations

| Abbreviation | Description |
|--------------|-------------|
| ans | Alphanumeric Special |
| BIC | Business Identifier Code | 
| BSP | Bangko Sentral ng Pilipinas | 
| BSFI | BSP Supervised Financial Institution | 
| C | Conditional | 
| CDCVM | Consumer Device Cardholder Verification Method |
| CRC | Cyclic Redundancy Check |
| ECI | Extended Channel Interpretation |
| ID | Identifier of the data object |
| ISO | International Standards Organization |
| M | Mandatory |
| N | Numeric |
| O | Optional |
| P2P | Person to Person |
| PPMI | Philippine Payments Management, Inc. |
| QR Code | Quick Response Code |
| RFU | Reserved for Future Use |
| S | String |
| SDK | Software Development Kit |
| var. | Variable |

### Terminology and Conventions

The following words are used often in this specification and have specific meaning:

*   **Shall**
Defines a product or system capability which is a mandatory.
*   **May**
Defines a product or system capability which is optional or a statement which is informative only and is out of scope for this specification
*   **Should**
Defines a product or system capability which is recommended.

### Presence of Data Objects

For the presence of data objects, the following notation is used:

*   M: Mandatory - shall always be present
*   C: Conditional - shall be present under certain conditions
*   O: Optional - may be present

## Data Objects

### Format Conventions

| Format | Meaning |
|--------|---------|
| Numeric (N) | Values that can be represented by all digits, from "0" to "9". |
| Alphanumeric Special (ans) | Values that can be represented by the Common Character Set as defined in [EMV Book 4]. The Alphanumeric Special alphabet includes ninety-six (96) characters in total and includes the numeric alphabet and punctuation. |
| String (S) | Values represented by any precomposed character(s) defined in [Unicode] |

### Representation

When referencing characters to include in the EMV Merchant-Presented QR Code, this specification encloses the characters in double quotes, for instance `"Test@123"`.

A character can be represented by its hexadecimal value. Single quotes are used to indicate the hexadecimal value for instance `'42'` to represent the character `"B"`.

### Encoding

For conversion of a character to its binary representation, this specification uses UTF-8 encoding as defined by [Unicode]. A character in UTF-8 can be up to 4 bytes long. Precomposed characters are recommended to maintain consistent character length for cross-platform compatibility reasons. For more information, please see:

*   [http://unicode.org/faq/char_combmark.html](http://unicode.org/faq/char_combmark.html)
*   [https://en.wikipedia.org/wiki/Precomposed_character](https://en.wikipedia.org/wiki/Precomposed_character)

Characters from the numeric (N) and the Alphanumeric Special alphabet (ans), are always 1 byte long. For instance, `"3"` and `"c"` are encoded as '33' and '63' respectively. Unicode characters outside this range are encoded in multiple bytes, for example, `"ĉ"` is encoded as '0109' and `"的"` is encoded as 'E79A84'.

# Overview to EMV QR Code Payment

An EMV Merchant-Presented QR code payment transaction enables consumers to make purchases using a merchant generated and displayed QR Code based on the merchant's details. For example, it can be used for a transfer of funds to a Merchant account designated by the Merchant Account Information over a payment network in exchange for goods and services provided by the Merchant.

Consumers are issued a mobile application that has the capability to scan an EMV Merchant-Presented QR Code and initiate a payment transaction. This mobile application may be an existing mobile banking app offered by the Issuer or a third party. In both cases, the request to process the payment transaction is ultimately directed to the Issuer managing the account from which the funds will be withdrawn.

The issuer receives the initial payment transaction, and secures or withdraws the transaction amount from the consumer's account.

Upon receiving the payment transaction, the Acquirer checks the validity of the Merchant Account Information and other merchant credentials and, when valid, credits the payment transaction amount to the account associated with the Merchant Account Information.

The Merchant awaits the notification of a successful transaction response before delivering the goods and services to the Consumer.

The Issuer also provides a notification to the Consumer (typically to their mobile application).

## Merchant-Presented Mode Transaction Flow

![Image of Merchant-Presented Mode Transaction Flow](https://i.imgur.com/jMaHg9L.jpg)

[1] Merchant generates and displays QR Code based on merchant details.
[2] Consumer scans QR Code using a mobile application to initiate the transaction, with CDCVM if required.
[3] Mobile application sends the transaction initiation request to the Network.
[4] The Network processes the transaction and informs the Merchant and the Consumer of the transaction outcome.

# Data Organization

The data contained within a QR Code is organized as follows. Each data object is made up of three individual fields. The first field is an identifier (ID) by which the data object can be reference. The next field is a length field that explicitly indicates the number of characters included in the third field: the value field. A data object is then represented as an ID / Length / Value combination, where:

*   The ID is coded as a two-digit numeric value, when a value ranging from `"00"` to `"99"`,
*   The length is coded as a two-digit numeric value, with a value ranging from "01" to "99",
*   The value field has a minimum length of one character and maximum length of 99 characters.

In the QR Code, the data objects are organized in a tree-like structure, under the root. A data object may be a primitive data object or a template. A template may include other templates and primitive data objects.

*   Root
    *   Primitive data object
    *   Template
        *   Primitive data object
        *   Template

A data object that is not encapsulated within a template is said to be under the root of the QR Code.

The value of an ID is not unique and the data object to which it refers is context specific. If the ID is not under the root, the context of an ID defined by the encapsulating template.

As an example: ID `"01"` that is under the root of the QR Code refers to the Point of Initiation Method, while ID `"01"` refers to the Bill Number when it is under the Additional Data Field Template (that is, within ID `"62"`)

*   Root
    *   Payload Format Indicator (ID `"00"`)
    *   Point of Initiation Method (ID `"01"`)
    *   Merchant Account Information (ID `"27"`)
        *   Global Unique Identifier (ID `"00"`)
        *   Acquirer ID (ID `"01"`)
        *   Payment Type (ID `"02"`)
        *   Merchant Credit Account (ID `"04"`)
        *   Mobile Number (ID `"05"`)
    *   Merchant Category Code (ID `"52"`)
    *   Transaction Currency (ID `"53"`)
    *   Country Code (ID `"58"`)
    *   Merchant Name (ID `"59"`)
    *   Merchant City (ID `"60"`)
    *   Additional Data Field Template (ID `"62"`)
        *   Reference Label (ID `"05"`)
        *   Terminal Label (ID `"07"`)
        *   Purpose of Transasction (ID `"08"`)
    *   CRC (ID `"63"`)

The Payload Format Indicator (ID `"00"`) is the first data object under the root and allows the mobile application to determine the data representation of the remaining data included in the QR Code and how to parse the data. The CRC ID (ID `"63"`) is the last object under the root and allows the mobile application to check the integrity of the data scanned without having to parse all of the data objects. The position of all other data objects under the root or within templates is arbitrary and may appear in any order.

The format of a value field in a data object is either Numeric (N), Alphanumeric Special (ans), or String (S). Note that Numeric is a subset of Alphanumeric Special and that Alphanumeric Special is a subset of String.

## Data Objects Under the Root of a QR Code

| Name | ID | Format | Length | Presence | Comment |
|------|----|--------|--------|----------|---------|
| Payload Format Indicator | `"00"` | N | "02" | M | See section Requirements > Payload Format Indicator (ID `"00"`) |
| Point of Initiation Method | `"01"` | N | "02" | O | See section Requirements > Point of Initiation Method (ID `"01"`) |
| Visa Merchant Account Information | `"02"`-`"03"` | ans | var. up to "99" | O | Data Objects reserved for Visa |
| MasterCard Merchant Account Information | `"04"`-`"05"` | ans | var. up to "99" | O | Data Objects reserved for Mastercard |
| RFU for EMVCo | `"06"`-`"08"` | ans | var. up to "99" | O | Data Objects reserved for EMVCo |
| Discover Merchant Account Information | `"09"`-`"10"` | ans | var. up to "99" | O | Data Objects reserved for Discover |
| Amex Merchant Account Information | `"11"`-`"12"` | ans | var. up to "99" | O | Data Objects reserved for Amex |
| JCB Merchant Account Information | `"13"`-`"14"` | ans | var. up to "99" | O | Data Objects reserved for JCB |
| UnionPay Merchant Account Information | `"15"`-`"16"` | ans | var. up to "99" | O | Data Objects reserved for UnionPay |
| RFU for EMVCo | `"17"`-`"25"` | ans | var. up to "99" | O | Data Objects reserved for EMVCo |
| RFU for PPMI | `"26"` | ans | var. up to "99" | O | Data Objects reserved for PPMI |
| P2P Merchant Account Information | `"27"` | ans | var. up to "99" | O | See section Data Objects for P2P Merchant Account Information |
| RFU for PPMI | `"28"`-`"51"` | ans | var. up to "99" | O | Data Objects reserved for PPMI |
| Merchant Category Code | `"52"` | N | "04" | M | As defined by [ISO 18245] and assigned by the Acquirer. |
| Transaction Currency | `"53"` | N | "03" | M | See section Requirements > Transaction Currency (ID `"53"`) |
| Transaction Amount | `"54"` | ans | var. up to "13" | C | Absent if the mobile application is to prompt the consumer to enter the transaction amount. Present otherwise. See section Requirements > Transaction Amount (ID `"54"`) |
| Tip or Convenience Indicator | `"55"` | N | "02" | O | See section Requirements > Tip or Convenience Fee Indicator (ID `"55"`) |
| Value of Convenience Fee Fixed | `"56"` | ans | var. up to "13" | C | See section Requirements > Value of Convenience Fee Fixed (ID `"56"`) |
| Value of Convenience Fee Percentage | `"57"` | ans | var. up to "05" | C | See section Requirements > Value of Convenience Fee Percentage (ID `"57"`) |
| Country Code | `"58"` | ans | "02" | M | Indicates the country of the merchant acceptance device. A 2-character alpha value, as defined by [ISO 3166-1 alpha 2] and assigned by the Acquirer. The country may be displayed to the consumer by the mobile application when processing the transaction. |
| Merchant Name | `"59"` | ans | var. up to "25" | M | The "doing business as" name for the merchant, recognizable to the consumer. This name may be displayed to the consumer by the mobile application when processing the transaction. |
| Merchant City | `"60"` | ans | var. up to "15" | M | City of operations for the merchant. This name may be displayed to the consumer by the mobile application when processing the transaction. |
| Postal Code | `"61"` | ans | var. up to "10" | O | Zip code or Pin code or Postal code of the merchant. If present, this value may be displayed to the consumer by the mobile application when processing the transaction. |
| Additional Data Field Template | `"62"` | S | var. up to "99" | O | See section Data Objects for Additional Data Field Template (ID `"62"`) |
| Merchant Information - Language Template | `"64"` | S | var. up to "99" | O | See section Data Objects for Merchant Information - Language Template (ID `"64"`) |
| RFU for EMVCo | `"65"`-`"79"` | S | var. up to "99" | O | Data objects reserved for EMVCo |
| BayadCenter Template | `"80"` | S | var. up to "99" | O | See section Data Objects for BayadCenter Template (ID `"80"`) |
| Unreserved Templates | `"81"`-`"99"` | S | var. up to "99" | O | RFU |
| CRC | `"63"` | ans | "04" | M | See section Requirements > CRC (ID `"63"`) |

## Data Objects for P2P Merchant Account Information (ID `"27"`)

| Name | ID | Format | Length | Presence | Comment |
|------|----|--------|--------|----------|---------|
| Globally Unique Identifier | `"00"` | ans | "12" | M | `"com.p2pqrpay"` |
| Acquirer ID | `"01"` | ans | "11" | M | As defined by [ISO 9362] and assigned by the Acquirer. `"PAPHPHM1XXX"` - PayMaya |
| Payment Type | `"02"` | ans | "8" | M | `"99964403"` – InstaPay Transfer |
| Merchant ID | `"03"` | ans | "15" | O | Receiver-assigned, if applicable, to authenticate the QR transaction. For P2P, this may be omitted. |
| Merchant Credit Account | `"04"` | ans | "19" | M | Creditor Account Number. _Note: This may be any Receiver-provided information that would enable it to identify the merchant account where payment shall be credited. Receiver may use actual account detail, a token, an alias or a masked/encrypted information to represent the actual account number_ |
| Mobile Number | `"05"` | ans | "15" | O | Mobile Number of Merchant; May be used for notification. The E.164 recommended format shall be used as a standard (+<country code><mobile network code><subscriber number>, i.e. +639188450195 |

## Data Objects for Additional Data Field Template (ID `"62"`)

| Name | ID | Format | Length | Presence | Comment |
|------|----|--------|--------|----------|---------|
| Bill Number | `"01"` | ans | var. up to "25" | O | The invoice number or bill number. This number could be provided by the merchant or could `"***"` to indicate to the mobile application to prompt the consumer to input a Bill Number. For example, the Bill Number may be present when the QR Code is used for a bill payment. |
| Mobile Number | `"02"` | ans | var. up to "25" | O | The mobile number could be provided by the merchant or could `"***"` to indicate to the mobile application to prompt the consumer to input a Mobile Number. For example, the Mobile Number to be used for multiple use cases, such as mobile top-up and bill payment. |
| Store Label | `"03"` | ans | var. up to "25" | O | A distinctive value associated to a store. This value could be provided by the merchant or could `"***"` to indicate to the mobile application to prompt the consumer to input a Store Label. For example, the Store Label may be displayed to the consumer on the mobile application identifying a specific store. |
| Loyalty Number | `"04"` | ans | var. up to "25" | O | Typically, a loyalty card number. This number could be provided by the merchant, if known, or could `"***"` to indicate to the mobile application to prompt the consumer to input their Loyalty Number. |
| Reference Label | `"05"` | ans | var. up to "25" | C | Any value as defined by the merchant or acquirer in order to identify the transaction. This value could be provided by the merchant or could `"***"` to indicate to the mobile app to prompt the consumer to input a transaction Reference Label. For example, the Reference Label may be used by the consumer mobile application for transaction logging or receipt display. This field is mandatory for P2P transactions with a value of `"211000"`.|
| Customer Label | `"06"` | ans | var. up to "25" | O | Any value identifying a specific consumer. This value could be provided by the merchant (if known), or could `"***"` to indicate to the mobile application to prompt the consumer to input their Customer Label. For example, the Customer Label may be a subscriber ID for subscription services, a student enrollment number, etc. |
| Terminal Label | `"07"` | ans | var. up to "25" | C | A distinctive value associated to a terminal in the store. This value could be provided by the merchant or could `"***"` to indicate to the mobile application to prompt the consumer to input a Terminal Label. For example, the Terminal Label may be displayed to the consumer on the mobile application identifying a specific terminal. This field is mandatory for P2P transactions. |
| Purpose of Transaction | `"08"` | ans | var. up to "25" | C | Any value defining the purpose of the transaction. This value could be provided by the merchant or could `"***"` to indicate to the mobile application to prompt the consumer to input a value describing the purpose of the transaction. For example, the Purpose of Transaction may have the value "International Data Package" for display on the mobile application. This field is mandatory for P2P transactions. |
| Additional Customer Data Request | `"09"` | ans | var. up to "25" | O | Contains indications that the mobile application is to provide the requested information in order to complete the transaction. The information requested should be provided by the mobile application in the authorization without unnecessarily prompting the consumer. For example, the Additional Consumer Data Request may indicate that the consumer mobile number is required to complete the transaction, in which case the mobile application should be able to provide this number (that that mobile application has previously stored) without unnecessarily prompting the consumer. One or more of the following characters may appear to indicate that the corresponding data should be provided in the transaction initiation to complete the transaction: `"A"`: Address of the consumer, `"M"`: Mobile number of the consumer, `"E"`: Email address of the consumer. If more than one character is included, it means that each data object corresponding to the character is required to complete the transaction. Note that each unique character should appear only one. |
| RFU for EMVCo | `"10"`-`"49"` | S | var. up to "99" | O | Data objects reserved for EMVCo |
| Bill Details Template | `"50"` | S | var. up to "99" | O | See section Data Objects for Bill Details Template (ID `"62"` Sub-ID `"50"`) |
| RFU for PayMaya | `"51"`-`"99"` | S | var. up to "99" | O | Data objects reserved for PayMaya |

### Data Objects for Bill Details Template (ID `"62"` Sub-ID `"50"`)

| Name | ID | Format | Length | Presence | Comment |
|------|----|--------|--------|----------|---------|
| Globally Unique Identifier | `"00"` | ans | "20" | M | `"com.paymaya.billspay"` |
| Biller Slug | `"01"` | ans | var. up to "13" | M | PayMaya biller & service identifier. |

## Data Objects for Merchant Information - Language Template (ID `"64"`)

| Name | ID | Format | Length | Presence | Comment |
|------|----|--------|--------|----------|---------|
| Language Preference | `"00"` | ans | "02" | M | |
| Merchant Name - Alternate Language | `"01"` | S | var. up to "25" | M | May be used by a mobile application to present the Merchant Name in an alternate language |
| Merchant City - Alternate Language | `"02"` | S | var. up to "15" | O | May be used by a mobile application to present the Merchant Name in an alternate language | 
| RFU for EMVCo | `"03"`-`"99"` | S | var. up to "99" | O | Data objects reserved for EMVCo |

## Data Objects for BayadCenter Template (ID `"80"`)

| Name | ID | Format | Length | Presence | Comment |
|------|----|--------|--------|----------|---------|
| Globally Unique Identifier | `"00"` | ans | "15" | M | `"com.bayadcenter"` |
| Biller Code | `"01"` | N | "05" | M | BayadCenter biller identifier | 
| Service Code | `"02"` | ans | "05" | M | BayadCenter biller service identifier |
| ATM / Phone Reference No. | `"03"` | N | `"16"` | O | Meralco |
| Meralco Reference No. | `"04"` | N | `"26"` | O | Meralco |
| Phone Number | `"05"` | N | var. up to "15" | O | PLDT, Sun, BayanTel, ABS-CBN Mobile, Finaswide, Home Credit |
| Service | `"06"` | ans | "02" | O | `"PL"`": PLDT Landline, `"PD"`: PLDT DSL, `"PU"`: PLDT Ultera |
| Product | `"07"` | ans | "01" | O | `"b"`: Ultera, `"c"`: Smart Cellular, `"b"`: Smart Bro |
| Telephone Number | `"08"` | N | var. up to "11" | O | Ultera, Smart Cellular, Smart Bro, Globe, Innove, Maxicare, Global Dominion, Tanay Rural Bank |
| Service Reference Number | `"09"` | N | var. up to "10" | O | Ultera, Smart Bro | 
| Due Date | `"10"` | ans | var. up to "10" | O | Sun, Laguna Water, Innove, Sky Cable, Destiny Cable, Sky Affiliates, Manila Memorial Park, Maxicare, PhilamLife, Manulife, Sony Life, Fortune Medicare, Equicom, Pru Life U.K., Pag-Ibig Membership Savings, Philhealth, Eternal Plans, Cocolife, Extraordinary, PANELCO III, BENECO, INEC, PANELCO I, MARWADIS, Meycauayan Water, Norzagaray Water District, PELCO 2 |
| Account Name | `"11"` | ans | var. up to "52" | O | Globe, Innove, Sun Life Plans, Sun Life Canada, Sky Affiliates, Manila Memorial Park, Manulife ChinaBank, Aeon, Pilipinas Teleserv (NSO), RCBC Bankard, Pru Life U.K., Prime Water, Eternal Plans, Cocolife, Extraordinary, Sta. Lucia Waterworks, CableLink, Liberty Broadcasting Network, Asian Vision |
| RAP | `"12"` | ans | "4" | O | Maynilad |
| External Entity Name | `"13"` | ans | "5" | O | Cignal |
| Last Name | `"14"` | ans | var. up to "26" | O | Cignal, Maxicare, Fortune, Medicare, Finaswide, Caritas Financial, Caritas Health, Equicom, Sterling Bank, Philippine Prudential, VECO, DVOLT, CLPC, SEZ, MEZ, BEZ, Philhealth, SSS, NBI, POEA, PRC, PAL EXPRESS, HomeMark, ChinaTrust, Asia Link, Global Dominion, Tanay Rural Bank, PANELCO III, BENECO, PANELCO I, MARWADIS, Meycauayan Water, Norzagaray Water District |
| First Name | `"15"` | ans | var. up to "26" | O | Cignal, Maxicare, Fortune, Medicare, Finaswide, Caritas Financial, Caritas Health, Equicom, Sterling Bank, Philippine Prudential, VECO, DVOLT, CLPC, SEZ, MEZ, BEZ, Philhealth, SSS, NBI, POEA, PRC, PAL EXPRESS, HomeMark, ChinaTrust, Asia Link, Global Dominion, Tanay Rural Bank, PANELCO III, BENECO, PANELCO I, MARWADIS, Meycauayan Water, Norzagaray Water District |
| Middle Initial/Middle Name | `"16"` | ans | var. up to "2" | O | Cignal, Maxicare, Fortune, Medicare, Finaswide, Caritas Financial, Caritas Health, Equicom, Sterling Bank, Philippine Prudential, Philhealth, SSS, HomeMark, ChinaTrust, Asia Link, Global Dominion, Tanay Rural Bank, PANELCO III, PANELCO I, MARWADIS, Meycauayan Water, Norzagaray Water District |
| Payment Type | `"17"` | ans | var. up to "2" | O | Pag-Ibig, PhilHealth, SSS |
| Bill Date | `"18"` | ans | var. up to "10" | O | Sky Cable, Destiny Cable, RCBC Bankard, Pag-Ibig, Philhealth, PANELCO III |
| Contact Number | `"19"` | N | var. up to "12" | O | Caritas Financial, Caritas Health, Equicom, Pag-Ibig, NBI, POEA, PRC, HomeMark, CableLink |
| Payment Option | `"20"` | ans | "01" | O | Pag-Ibig | 
| Period From | `"21"` | ans | var. up to "7" | O | Pag-Ibig, Philhealth |
| Period To | `"22"` | ans | var. up to "7" | O | Pag-Ibig, Philhealth |
| Region | `"23"` | ans | "01" | O | Pag-Ibig |
| Member Type | `"24"` | ans | var. up to "3" | O | Philhealth
| Company Name | `"25"` | ans | var. up to "52" | O | Philhealth, SSS |
| SPA Number | `"26"` | N | var. up to "15" | O | Philhealth |
| Contribution Date Range (From) | `"27"` | ans | var. up to "7" | O | SSS |
| Contribution Date Range (To) | `"28"` | ans | var. up to "7" | O | SSS |
| SSS Amount | `"29"` | ans | var. up to "13" | O | SSS |
| EC Amount | `"30"` | ans | var. up to "13" | O | SSS |
| Loan Type | `"31"` | ans | var. up to "02" | O | SSS |
| Payor Type | `"32"` | ans | "01" | O | SSS |
| Loan Account No | `"33"` | N | var. up to "10" | O | SSS |
| Rel Type | `"34"` | ans | var. up to "02" | O | SSS |
| Payor Name | `"35"` | ans | var. up to "52" | O | NHMFC, Cebu Pacific |
| Booking No | `"36"` | ans | var. up to "6" | O | Air Asia |
| Serial Number | `"37"` | N | var. up to "12" | O | Easy Trip |
| Service Type | `"38"` | N | "01" | O | Sky Cable, Destiny Cable, Cablelink |
| Plan Type | `"39"` | ans | "01" | O | Sun Life Plans |
| Product Type | `"40"` | ans | var. up to "04" | O | Sun Life Canada |
| Payment Entry | `"41"` | ans | var. up to "03" | O | NHMFC |
| Borrower Name | `"42"` | ans | var. up to "52" | O | NHMFC |
| Customer Name | `"43"` | ans | var. up to "52" | O | Bayantel |
| Affiliate | `"44"` | ans | var. up to "07" | O | Sky Affiliates |
| Bill Number / Bill Invoice Number | `"45"` | N | var. up to "15" | O | Prime Water, Sta. Lucia Waterworks, Meycauayan Water, Norzagaray Water District |
| SOACL Number | `"46"` | ans | var. up to "10" | O | Fortune Medicare |
| Account Type | `"47"` | ans | "01" | O | Fortune Medicare |
| Premium Amount | `"48"` | ans | var. up to "13" | O | Cocolife |
| Loan Amount | `"49"` | ans | var. up to "13" | O | Cocolife |
| Name | `"50"` | ans | var. up to "52" | O | Home Credit, INEC |
| Particular | `"51"` | ans | var. up to "8" | O | HomeMark |
| Reference Type | `"52"` | ans | var. up to "6" | O | ChinaTrust |
| Cons Name | `"53"` | ans | var. up to "52" | O | BPI |
| Power Company | `"54"` | ans | var. up to "04" | O | CLPC, SEZ, BEZ |
| Bill Amount | `"55"` | ans | var. up to "13" | O | PANELCO III |
| Share Capital | `"56"` | ans | var. up to "13" | O | PANELCO III |
| Affiliate Branch | `"57"` | ans | var. up to "07" | O | Asian Vision |
| Meter Number | `"58"` | ans | var. up to "15" | O | PANELCO I |
| Expiration Date | `"59"` | ans | var. up to "10" | O | PANELCO I |
| RFU for BayadCenter | `"60"`-`"99"` | ans | var. up to "70" | O | Data Objects reserved for BayadCenter |

# Data Object ID Allocation

An ID of a primitive data object or a template is either allocated by EMVCo, Reserved for Future Use (RFU) by EMVCo, RFU by PPMI, RFU by PayMaya, RFU by BayadCenter, or Unreserved.

IDs allocated by EMVCo have a meaning, representation, and format as defined by EMVCo in this, and related, specifications.

Unreserved IDs can be allocated and used by other parties, such as (domestic) payment systems and value-added service providers for their own products. These entities can then define the meaning and representation of the values within these data objects in one of the formats defined by this specification. Other constraints defined in this specification (for example, length of data objects) also apply.

These parties are encouraged though to use the EMVCo allocated data objects whenever the meaning of a data object corresponds to what is needed for their own solution, even if the representation or format is different from their existing or desired solution. The conversion from the representation and format as defined for the QR Code to the desired representation and format for the mobile application, user display, and subsequent transaction processing can be done by the mobile application. Avoiding duplication of information due to differences in representation and format reduces the payload data and therefore the size of the QR Code and improves the consumer experience when reading and processing the QR Code.

An example is given below:

> The QR Code presents the Transaction Amount (ID `"54"`) as a series of digits, where the `"."` character is used as a decimal mark to separate the decimals from the integer value. It also includes the Transaction Currency (ID `"53"`) using 3-digit numeric representation.

> The mobile application can easily represent the amount and the currency as defined for Amount, Authorized (Numeric) and Transaction Currency Code in [EMV Book 4].

> For example, if the values of the Transaction Amount and Transaction Currency in the QR Code are `"98.73"` and `"608"`, respectively, then the mobile application can convert these values to '000000009873' and '0608' to put them in the representation and format as used for the Amount, Authorized (Numeric) and Transaction Currency Code.

# Requirements

## Payload Length

> The length of the payload should not exceed 512 alphanumeric characters, and the number of characters should be reduced proportionally when multi-byte [Unicode] characters are used.

> Note that, as data object values with a format of S may contain characters coded as UTF-8 and depending on the alphabet being used there may not be a one-to-one mapping of characters to bytes, special consideration would be needed to determine the number of bytes in the payload.

## Position of Data Objects

*   The Payload Format Indicator (ID `"00"`) shall be the first data object in the QR Code.
*   The CRC (ID `"63"`) shall be the last data object in the QR Code.

    _All other data objects under the root may be placed at any position._

    _Data objects within a template, such as the Additional Data Field Template (ID `"62"`) or the Merchant Information—Language Template (ID `"64"`), may be placed in any position under their respective templates._

## Payload Format Indicator (ID `"00"`)

*   The Payload Format Indicator shall contain a value of "01". All other values are RFU.

## Point of Initiation Method (ID `"01"`)

*   If present, the Point of Initiation Method shall contain a value of `"11"` or `"12"`. All other values are RFU.

    _The value of `"11"` should be used when the same QR Code is shown for more than one transaction and the value of `"12"` should be used when a new QR Code is shown for each transaction._

## Transaction Currency (ID `"53"`)

*   The Transaction Currency shall conform to [ISO 4217] and shall contain the numeric representation of the currency. For example, PHP is represented by the value of `"608"`.

    _The value should indicate the transaction currency in which the merchant transacts._

## Transaction Amount (ID `"54"`)

*   If present, the Transaction Amount shall be different from zero, shall only include (numeric) digits `"0"` to `"9"` and may contain a single `"."` character as the decimal mark. When the amount includes decimals, the `"."` character shall be used to separate the decimals from the integer value and the `"."` character may be present even if there are no decimals.

    _The number of digits after the decimal mark should align with the currency exponent associated to the currency code defined in [ISO 4217]._

    _The above describes the only acceptable format for the Transaction Amount. It cannot contain any other characters (for instance, no space character can be used to separate thousands)._

    _The following are examples of valid Transaction Amounts: `"98.73"`, `"98"` and `"98."`._

    _The following are **NOT** valid Transaction Amounts: "98,73" and "3 705"._

*   The Transaction Amount shall not be included if the mobile application should prompt the consumer to enter the amount to be to the Merchant.

## Tip or Convenience Fee Indicator (ID `"55"`)

*   If present, the Tip or Convenience Indicator shall contain a value of `"01"`, `"02"`, or `"03"`. All other values are RFU.
    *   A value of `"01"` shall be used if the mobile application should prompt the consumer to enter a tip to be paid to the merchant.
    *   A value of `"02"` shall be used to indicate inclusion of the data object Value of Convenience Fee Fixed (ID `"56"`).
    *   A value of `"03"` shall be used to indicate inclusion of the data object Value of Convenience Fee Percentage (ID `"57"`).

## Value of Convenience Fee Fixed (ID `"56"`)

*   The Value of Convenience Fee Fixed shall be present and different from zero if the data object Tip or Convenience Indicator (ID `"55"`) is present with a value of `"02"`. Otherwise this data object shall be absent.

*   If present, the Value of Convenience Fee Fixed shall only include (numeric) digits `"0"` to `"9"` and may contain a single `"."` character as the decimal mark.

*   When the Value of the Convenience Fee Fixed includes decimals, the `"."` character shall be used to separate the decimals from the integer value.

    _The `"."` character may be present even if there are no decimals._

    _The number of digits after the decimal mark should align with the currency exponent associated to the currency code defined in [ISO 4217]._

    _The above describes the only acceptable format for the Value of Convenience Fee Fixed. It cannot contain any other characters (for instance, no space character can be used to separate thousands)._

## Value of Convenience Fee Percentage (ID `"57"`)

*   The Value of Convenience Fee Percentage shall be present if the data object Tip or Convenience Indicator (ID `"55"`) is present with a value of `"03"` and only values between `"00.01"` and `"99.99"` shall be used. Otherwise this data object shall be absent.

*   If present, the Value of Convenience Fee Percentage shall only include (numeric) digits `"0"` to `"9"` and may contain a single `"."` character as the decimal mark.

*   When the Value of the Convenience Fee Percentage includes decimals, the `"."` character shall be used to separate the decimals from the integer value and the `"."` character may be present even if there are no decimals.

    _The Value of Convenience Fee Percentage shall not contain any other characters._

    _For example, the "%" character must not be included._

    _The above describes the only acceptable format for the Value of Convenience Fee Percentage._

## CRC (ID "63")

*   The checksum shall be calculated according to [ISO/IEC 13239] using the polynomial '1021' (hex) and initial value 'FFFF' (hex). The data over which the checksum is calculated shall cover all data objects, including their ID, Length and Value, to be included in the QR Code, in their respective order, as well as the ID and Length of the CRC itself (but excluding its Value).

*   Following the calculation of the checksum, the resulting 2-byte hexadecimal value shall be encoded as a 4-character Alphanumeric Special value by converting each nibble to an Alphanumeric Special character.

*   _Example: a CRC with a two-byte hexadecimal value of '007B' is included in the QR Code as "6304007B"._

# Appendix A - Examples

## P2P

### EMV Merchant QR Code Data

```
00020101021127750012com.p2pqrpay0111PAPHPHM1XXX0208999644030411099859039430513+6399859039435204601653036085802PH5912PayMaya User6011Mandaluyong622805062110000707PAYMAYA0803***6304F09D
```

![Image of P2P QR](https://api.qrserver.com/v1/create-qr-code/?size=400x400&data=00020101021127750012com.p2pqrpay0111PAPHPHM1XXX0208999644030411099859039430513%2B6399859039435204601653036085802PH5912PayMaya%20User6011Mandaluyong622805062110000707PAYMAYA0803***6304F09D)

### Binary Data (shown as hex bytes)

```
00 02 30 31
01 02 31 31
27 75
  00 12 63 6F 6D 2E 70 32 70 71 72 70 61 79
  01 11 50 41 50 48 50 48 4D 31 58 58 58
  02 08 39 39 39 36 34 34 30 33
  04 11 30 39 39 38 35 39 30 33 39 34 33
  05 13 20 36 33 39 39 38 35 39 30 33 39 34 33
52 04 36 30 31 36
53 03 36 30 38
58 02 50 48
59 12 50 61 79 4D 61 79 61 20 55 73 65 72
60 11 4D 61 6E 64 61 6C 75 79 6F 6E 67
62 28
  05 06 32 31 31 30 30 30
  07 07 50 41 59 4D 41 59 41
  08 03 2A 2A 2A
63 04 46 30 39 44
```

### EMV Interpreted Data

*   Root
    *   Payload Format Indicator (ID `"00"`) = `01`
    *   Point of Initiation Method (ID `"01"`) = `11`
    *   Merchant Account Information (ID `"27"`)
        *   Global Unique Identifier (ID `"00"`) = `com.p2pqrpay`
        *   Acquirer ID (ID `"01"`) = `PAPHPHM1XXX`
        *   Payment Type (ID `"02"`) = `99964403`
        *   Merchant Credit Account (ID `"04"`) = `09985903943`
        *   Mobile Number (ID `"05"`) = `+639985903943`
    *   Merchant Category Code (ID `"52"`) = `6016`
    *   Transaction Currency (ID `"53"`) = `608`
    *   Country Code (ID `"58"`) = `PH`
    *   Merchant Name (ID `"59"`) = `PayMaya User`
    *   Merchant City (ID `"60"`) = `Mandaluyong`
    *   Additional Data Field Template (ID `"62"`)
        *   Reference Label (ID `"05"`) = `211000`
        *   Terminal Label (ID `"07"`) = `PAYMAYA`
        *   Purpose of Transaction (ID `"08"`) = `***`
    *   CRC (ID `"63"`) = `F09D`

## Meralco

### EMV Merchant QR Code Data

```
00020101021226150011com.paymaya5204490053036085405390.85802PH5907Meralco6005Pasig62530110046649980150350020com.paymaya.billspay0107meralco80870015com.bayadcenter0105000010205MECOA0316046649980181013604260466499801812101361210260363041DB5
```

![Image of Meralco QR](https://api.qrserver.com/v1/create-qr-code/?size=400x400&data=00020101021226150011com.paymaya5204490053036085405390.85802PH5907Meralco6005Pasig62530110046649980150350020com.paymaya.billspay0107meralco80870015com.bayadcenter0105000010205MECOA0316046649980181013604260466499801812101361210260363041DB5)

### Binary Data (shown as hex bytes)

```
00 02 30 31
01 02 31 32
26 15
  00 11 63 6F 6D 2E 70 61 79 6D 61 79 61
52 04 34 39 30 30
53 03 36 30 38
54 05 33 39 30 2E 38
58 02 50 48
59 07 4D 65 72 61 6C 63 6F
60 05 50 61 73 69 67
62 53
  01 10 30 34 36 36 34 39 39 38 30 31
  50 35
    00 20 63 6F 6D 2E 70 61 79 6D 61 79 61 2E 62 69 6C 6C 73 70 61 79
    01 07 6D 65 72 61 6C 63 6F
80 87
  00 15 63 6F 6D 2E 62 61 79 61 64 63 65 6E 74 65 72
  01 05 30 30 30 30 31
  02 05 4D 45 43 4F 41
  03 16 30 34 36 36 34 39 39 38 30 31 38 31 30 31 33 36
  04 26 30 34 36 36 34 39 39 38 30 31 38 31 32 31 30 31 33 36 31 32 31 30 32 36 30 33 
63 04 31 44 42 35
```

### EMV Interpreted Data

*   Root
    *   Payload Format Indicator (ID `"00"`) = `01`
    *   Point of Initiation Method (ID `"01"`) = `12`
    *   Merchant Account Information (ID `"26"`)
        *   Global Unique Identifier (ID `"00"`) = `com.paymaya`
    *   Merchant Category Code (ID `"52"`) = `4900`
    *   Transaction Currency (ID `"53"`) = `608`
    *   Transaction Amount (ID `"54"`) = `390.8`
    *   Country Code (ID `"58"`) = `PH`
    *   Merchant Name (ID `"59"`) = `Meralco`
    *   Merchant City (ID `"60"`) = `Pasig`
    *   Additional Data Field Template (ID `"62"`)
        *   Bill Number (ID `"01"`) = `0466499801`
        *   Bill Details Template (ID `"50"`)
            *   Global Unique Identifier (ID `"00"`) = `com.paymaya.billspay`
            *   Biller Slug (ID `"01"`) = `meralco`
    *   BayadCenter Template (ID `"80"`)
        *   Global Unique Identifier (ID `"00"`) = `com.bayadcenter`
        *   Biller Code (ID `"01"`) = `00001`
        *   Service Code (ID `"02"`) = `MECOA`
        *   ATM / Phone Reference No (ID `"03"`) = `0466499801810136`
        *   Meralco Reference No (ID `"04"`) = `04664998018121013612102603`
    *   CRC (ID `"63"`) = `1DB5`

## PLDT Home

### EMV Merchant QR Code Data

```
00020101021226150011com.paymaya52044111530360854061000.05802PH5920CIS BAYAD CENTER INC6005Pasig62500110022394211350320020com.paymaya.billspay0104pldt80570015com.bayadcenter0105002140205PLDT6041012345678900702PD6304955F
```
![Image of PLDT Home QR](https://api.qrserver.com/v1/create-qr-code/?size=400x400&data=00020101021226150011com.paymaya52044111530360854061000.05802PH5920CIS+BAYAD+CENTER+INC6005Pasig62500110022394211350320020com.paymaya.billspay0104pldt80570015com.bayadcenter0105002140205PLDT6041012345678900702PD6304955F)

### Binary Data (shown as hex bytes)

```
00 02 30 31
01 02 31 32
26 15
  00 11 63 6F 6D 2E 70 61 79 6D 61 79 61
52 04 34 31 31 31
53 03 36 30 38
54 06 31 30 30 30 2E 30
58 02 50 48
59 20 43 49 53 20 42 41 59 41 44 20 43 45 4E 54 45 52 20 49 4E 43
60 05 50 61 73 69 67
62 50
  01 10 30 32 32 33 39 34 32 31 31 33
  50 32
    00 20 63 6F 6D 2E 70 61 79 6D 61 79 61 2E 62 69 6C 6C 73 70 61 79
    01 04 70 6C 64 74
80 57
  00 15 63 6F 6D 2E 62 61 79 61 64 63 65 6E 74 65 72
  01 05 30 30 32 31 34
  02 05 50 4C 44 54 36
  04 10 31 32 33 34 35 36 37 38 39 30
  07 02 50 44
63 04 39 35 35 46
```

### EMV Interpreted Data

*   Root
    *   Payload Format Indicator (ID `"00"`) = `01`
    *   Point of Initiation Method (ID `"01"`) = `12`
    *   Merchant Account Information (ID `"26"`)
        *   Global Unique Identifier (ID `"00"`) = `com.paymaya`
    *   Merchant Category Code (ID `"52"`) = `4111`
    *   Transaction Currency (ID `"53"`) = `608`
    *   Transaction Amount (ID `"54"`) = `1000`
    *   Country Code (ID `"58"`) = `PH`
    *   Merchant Name (ID `"59"`) = `CIS BAYAD CENTER INC`
    *   Merchant City (ID `"60"`) = `Pasig`
    *   Additional Data Field Template (ID `"62"`)
        *   Bill Number (ID `"01"`) = `0223942113`
        *   Bill Details Template (ID `"50"`)
            *   Global Unique Identifier (ID `"00"`) = `com.paymaya.billspay`
            *   Biller Slug (ID `"01"`) = `pldt`
    *   BayadCenter Template (ID `"80"`)
        *   Global Unique Identifier (ID `"00"`) = `com.bayadcenter`
        *   Biller Code (ID `"01"`) = `00214`
        *   Service Code (ID `"02"`) = `PLDT6`
        *   Phone Number (ID `"04"`) = `1234567890`
        *   Service (ID `"07"`) = `PD`
    *   CRC (ID `"63"`) = `955F`

# Appendix B - QR Generator

## QR Generation API

https://api.qrserver.com/v1/create-qr-code/?size=400x400&data=**<insert qrCodeData here>**

### Sample qrCodeData

```
00020101021226150011com.paymaya5204411153036085405390.85802PH5920CIS BAYAD CENTER INC6005Pasig626950650020com.paymaya.billspay0107meralco02260466499801812101361210260380370015com.bayadcenter0105000010205MECOA630448E7
```

### QR Code Link

[https://api.qrserver.com/v1/create-qr-code/?size=400x400&data=00020101021226150011com.paymaya5204411153036085405390.85802PH5920CIS+BAYAD+CENTER+INC6005Pasig626950650020com.paymaya.billspay0107meralco02260466499801812101361210260380370015com.bayadcenter0105000010205MECOA630448E7](https://api.qrserver.com/v1/create-qr-code/?size=400x400&data=00020101021226150011com.paymaya5204411153036085405390.85802PH5920CIS+BAYAD+CENTER+INC6005Pasig626950650020com.paymaya.billspay0107meralco02260466499801812101361210260380370015com.bayadcenter0105000010205MECOA630448E7)

## QR Generation SDK 

[https://developers.mastercard.com/documentation/masterpass-qr](https://developers.mastercard.com/documentation/masterpass-qr)

## QR Generation Portal

[https://www.mastercardlabs.com/masterpass-qr](https://www.mastercardlabs.com/masterpass-qr)

![Image of QR Generator 1](https://i.imgur.com/8N8B4Iq.png)

![Image of QR Generator 2](https://i.imgur.com/b1t6jEc.png)

![Image of QR Generator 3](https://i.imgur.com/imMV1Ti.png)

![Image of QR Generator 4](https://i.imgur.com/jaV7E8M.png)

![Image of QR Generator 5](https://i.imgur.com/e1kA1hM.png)

![Image of QR Generator 6](https://i.imgur.com/Omus4ux.png)

![Image of QR Generator 7](https://i.imgur.com/5kkHUdH.png)

# Appendix C - QR Validator

## EMV QR Code Reader

*   App Store: [https://itunes.apple.com/ph/app/emv-qr-code-reader/id1277902667](https://itunes.apple.com/ph/app/emv-qr-code-reader/id1277902667)
*   Play Store: [https://play.google.com/store/apps/details?id=com.euromeric.emvqrcode](https://play.google.com/store/apps/details?id=com.euromeric.emvqrcode)
