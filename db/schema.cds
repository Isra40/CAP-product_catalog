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
        SalesData        : Association to many sales.SalesData
                               on SalesData.Product = $self;
        Reviews          : Association to many material.ProductReview
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

    entity ProductReview : cuid, managed {
        // key ID      : UUID;
        Name    : String;
        Rating  : Integer;
        Comment : String;
        Product : Association to material.Products;

    }

    entity SelProducts   as select from material.Products;
    //Entidad Projection ---------------------------
    //No tenemos la posibilidad de utilizar sentencias SQL (joins, agregados, etc)
    //Las proyecciones se utilizan para mostrar columnas de los orígenes de datos que utilizamos
    entity ProjProducts  as projection on Products;

    entity ProjProducts1 as
        projection on material.Products {
            *
        };

    entity ProjProducts2 as
        projection on material.Products {
            Name,
            Price,
            Quantity
        };
    //-------------------------------------------------

    //Entidades - Ampliación -------
    extend material.Products with {
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

    entity SelProducts1 as
        select from material.Products {
            *
        };

    entity SelProducts2 as
        select from material.Products {
            Name,
            Price,
            Quantity
        };

    entity SelProducts3 as
        select from material.Products
        left join material.ProductReview
            on Products.Name = ProductReview.Name
        {
            Rating,
            Products.Name,
            sum(Price) as TotalPrice

        }
        group by
            Rating,
            Products.Name
        order by
            Rating;

    entity SalesData : cuid, managed {
        // key ID            : UUID;
        DeliveryDate  : DateTime;
        Revenue       : Decimal(16, 2);
        Product       : Association to material.Products;
        Currency      : Association to material.Currencies;
        DeliveryMonth : Association to sales.Months;
    }

}

context reports {
    entity AverageRating as
        select from capdemo.material.ProductReview {
            Product.ID  as ProductId,
            avg(Rating) as AverageRating : Decimal(16, 2)
        }
        group by
            Product.ID //Agrupación
} 
