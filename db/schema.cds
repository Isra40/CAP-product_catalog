namespace com.capdemo;


type Name : String(20);

type Adress {
    Street     : String;
    City       : String;
    State      : String;
    PostalCode : String;
    Country    : String;
}

//-- TIPOS MATRIZ
//------------------------------------------------
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


//-- TIPOS ENUM (Enumeraciones)
//-----------------------------------------------
// type Gender: String enum{
//     male;
//     female;
// };

// entity Order{
//     clientGender: Gender;
//     sttus: Integer enum{
//         submitted = 1;
//         fulfiller = 2;
//         shipped = 3;
//         cancel = -1;
//     };
//     priority: String @assert.range enum {
//         high;
//         medium;
//         low;
//     };
// }
//---------------------------------------------------

entity Products {
    key ID               : UUID;
        //      Tipos por defecto
        //Name             : String default 'NoName';
        //CreationDate     : Date default CURRENT_DATE; //Fecha del sistema
        Name             : String;
        Description      : String;
        ImageUrl         : String;
        //      Tipos por defecto
        ReleaseDate      : DateTime default $now;
        DiscontinuedDate : DateTime;
        Price            : Decimal(16, 2);
        //      Tipo por referencia - Referencia a otra columna de la misma entidad
        //      Height           : type of Price; Decimal(16, 2)
        Height           : Decimal(16, 2);
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
}

entity Suppliers {
    key ID      : UUID;
        //      Tipo por referencia - Referencia a otra columna de otra entidad
        Name    : Products:Name; //String
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
