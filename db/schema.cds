namespace com.capdemo;

entity Products {
    key ID               : Integer;
        Name             : String;
        Description      : String;
        ImageUrl         : String;
        ReleaseDate      : DateTime;
        DiscontinuedDate : DateTime;
        Price            : Decimal(16, 2);
        Height           : Decimal(16, 2);
        Weight           : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
}

entity Supplier {
    key ID         : UUID;
        Name       : String;
        Street     : String;
        City       : String;
        State      : String;
        PostalCode : String;
        Country    : String;
        Email      : String;
        Phone      : String;
        Fax        : String;
}

entity Category {
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
    key DeliveryData : DateTime;
        Revenue      : Decimal(16, 2);
}
