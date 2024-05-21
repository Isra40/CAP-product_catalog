namespace com.capdemo;

using {
    cuid,
    managed
} from '@sap/cds/common';


type Name   : String(50);

type Adress {
    Street     : String;
    City       : String;
    State      : String;
    PostalCode : String;
    Country    : String;
}

//-- TIPOS ENUM (Enumeraciones)
//-----------------------------------------------
type Gender : String enum {
    male;
    female;
};

entity Order {
    clientGender : Gender;
    sttus        : Integer enum {
        submitted = 1;
        fulfiller = 2;
        shipped   = 3;
        cancel    = -1;
    };
    priority     : String @assert.range enum {
        high;
        medium;
        low;
    };
}
//-------------------------------------------------

entity Products : cuid, managed {
    // key ID               : UUID;  //Sustituido por el aspecto cuid
    Name             : localized String not null; //Restricción not null
    Description      : localized String;
    ImageUrl         : String;
    ReleaseDate      : DateTime default $now;
    DiscontinuedDate : DateTime;
    Price            : Decimal(16, 2);
    Height           : Decimal(16, 2);
    Width            : Decimal(16, 2);
    Depth            : Decimal(16, 2);
    Quantity         : Decimal(16, 2);
    //      Asociación Administrada
    Supplier         : Association to one Suppliers;
    UnitOfMeasure    : Association to UnitOfMeasures;
    Currency         : Association to Currencies;
    DimensionUnit    : Association to DimensionUnits;
    Category         : Association to Categories;
    // Asociación Many
    ToSalesData      : Association to many SalesData
                           on ToSalesData.Product = $self;
    Reviews          : Association to many ProductReview
                           on Reviews.Product = $self;
}

// Composición - Relación entre entidades Si no existe la entidad padre, no puede existir la hija
entity Orders : cuid {
    // // key ID       : UUID;
    Date     : Date;
    Customer : String;
    Item     : Composition of many OrderItems
                   on Item.Order = $self;
}


entity OrderItems : cuid {
    // // key ID       : UUID;
    Order    : Association to Orders;
    Product  : Association to Products;
    Quantity : Integer;
}

entity Suppliers : cuid, managed {
    // key ID      : UUID;
    //      Tipo por referencia - Referencia a otra columna de otra entidad
    Name    : Products:Name; //String
    Address : Adress;
    Email   : String;
    Phone   : String;
    Fax     : String;
    Product : Association to many Products
                  on Product.Supplier = $self;
}

entity Categories {
    key ID   : String(1);
        Name : localized String;
}

entity StockAvailability {
    key ID          : Integer;
        Description : localized String;
        Product     : Association to Products;
}

entity Currencies {
    key ID          : String(3);
        Description : localized String;
}

entity UnitOfMeasures {
    key ID          : String(2);
        Description : localized String;
}

entity DimensionUnits {
    key ID          : String(2);
        Description : localized String;
}

entity Months {
    key ID               : String(2);
        Description      : localized String;
        ShortDescription : localized String(3);
}

entity ProductReview : cuid, managed {
    // key ID      : UUID;
    Name    : String;
    Rating  : Integer;
    Comment : String;
    Product : Association to Products;

}

entity SalesData : cuid, managed {
    // key ID            : UUID;
    DeliveryDate  : DateTime;
    Revenue       : Decimal(16, 2);
    Product       : Association to Products;
    Currency      : Association to Currencies;
    DeliveryMonth : Association to Months;
}





//Entidades - Ampliación -------
extend Products with {
    PriceCondition     : String(2);
    PriceDetermination : String(3);
}
//-------------------------------------------------


