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

context material {

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
        Supplier         : Association to one sales.Suppliers;
        UnitOfMeasure    : Association to material.UnitOfMeasures;
        Currency         : Association to material.Currencies;
        DimensionUnit    : Association to material.DimensionUnits;
        Category         : Association to material.Categories;
        // Asociación Many
        ToSalesData      : Association to many sales.SalesData
                               on ToSalesData.Product = $self;
        Reviews          : Association to many sales.ProductReview
                               on Reviews.Product = $self;
    }

    entity Categories {
        key ID   : String(1);
            Name : localized String;
    };

    entity StockAvailability {
        key ID          : Integer;
            Description : localized String;
            Product     : Association to material.Products;
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

    //Entidades - Ampliación -------
    extend Products with {
        PriceCondition     : String(2);
        PriceDetermination : String(3);
    }
//-------------------------------------------------

}

context sales {

    // Composición - Relación entre entidades Si no existe la entidad padre, no puede existir la hija
    entity Orders : cuid {
        // // key ID       : UUID;
        Date     : Date;
        Customer : String;
        Item     : Composition of many sales.OrderItems
                       on Item.Order = $self;
    }


    entity OrderItems : cuid {
        // // key ID       : UUID;
        Order    : Association to sales.Orders;
        Product  : Association to material.Products;
        Quantity : Integer;
    }

    entity Suppliers : cuid, managed {
        // key ID      : UUID;
        //      Tipo por referencia - Referencia a otra columna de otra entidad
        Name    : material.Products:Name; //String
        Address : Adress;
        Email   : String;
        Phone   : String;
        Fax     : String;
        Product : Association to many material.Products
                      on Product.Supplier = $self;
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
        Product : Association to material.Products;

    }

    entity SalesData : cuid, managed {
        // key ID            : UUID;
        DeliveryDate  : DateTime;
        Revenue       : Decimal(16, 2);
        Product       : Association to material.Products;
        Currency      : Association to material.Currencies;
        DeliveryMonth : Association to sales.Months;
    }

}
