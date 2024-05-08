namespace com.capdemo;


type Name              : String(20);

type Adress {
    Street     : String;
    City       : String;
    State      : String;
    PostalCode : String;
    Country    : String;
}

// type EmailAddresses_01 : array of {
//     kind  : String;
//     email : String;
// }


// type EmailAddresses_02 {
//     kind  : String;
//     email : String;
// }

// entity Emails{
//     email_01: EmailAddresses_01;
//     email_02: many EmailAddresses_02;
//     email_03: many {
//         kind  : String;
//         email : String;        
//     }
// }

//cds db/schema.cds -2 sql
// NCLOB - National Character Large Object
entity Products {
    key ID               : UUID;
        Name             : String;
        Description      : String;
        ImageUrl         : String;
        ReleaseDate      : DateTime;
        DiscontinuedDate : DateTime;
        Price            : Decimal(16, 2);
        Height           : Decimal(16, 2);
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
}

entity Suppliers {
    key ID      : UUID;
        Name    : String;
        Address : Adress;
        Email   : String;
        Phone   : String;
        Fax     : String;
}

entity Categories {
    key ID   : String(1);
        Name : String;
}

entity StockAvailability {
    key ID          : Integer;
        Description : String;
}

entity Currencies {
    key ID          : String(3);
        Description : String;
}

entity UnitOfMeasures {
    key ID          : String(3);
        Description : String;
}

entity DimensionUnits {
    key ID          : String(2);
        Description : String;
}

entity Months {
    key ID               : String(2);
        Description      : String;
        ShortDescription : String;
}

entity ProductReview {
    key Name    : String;
        Rating  : Integer;
        Comment : String;
}

entity SalesData {
    key ID           : UUID;
        DeliveryDate : DateTime;
        Revenue      : Decimal(16, 2);
}
