namespace com.capdemo;


type Name   : String(50);

type Adress {
    Street     : String;
    City       : String;
    State      : String;
    PostalCode : String;
    Country    : String;
}

//-- TIPOS MATRIZ
// ------------------------------------------------
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

//-- ELEMENTOS VIRTUALES
//-----------------------------------------------
// entity Car {
//     key ID                 : UUID;
//         name               : String;
//         //  Elementos Virtuales (campos que se retornan en las llamadas a los servicios, pero no se graban en BBDD)
//         virtual discount_1 : Decimal;

//         //   Si se quieren sobreescribir los valores en un POST hay que modificar el metadata "Term="Core.Computed"
//         @Core.Computed: false
//         virtual discount_2 : Decimal;
// }
//-------------------------------------------------

// entity Products {
//     key ID               : UUID;
//         //      Tipos por defecto
//         //Name             : String default 'NoName';
//         //CreationDate     : Date default CURRENT_DATE; //Fecha del sistema
//         Name             : String not null; //Restricción not null
//         Description      : String;
//         ImageUrl         : String;
//         //      Tipos por defecto
//         ReleaseDate      : DateTime default $now;
//         DiscontinuedDate : DateTime;
//         Price            : Decimal(16, 2);
//         //      Tipo por referencia - Referencia a otra columna de la misma entidad
//         //      Height           : type of Price; //Decimal(16, 2)
//         Height           : Decimal(16, 2);
//         Width            : Decimal(16, 2);
//         Depth            : Decimal(16, 2);
//         Quantity         : Decimal(16, 2);
//         Supplier_ID      : UUID;
//         //Asociación no Administrada
//         ToSupplier       : Association to one Suppliers
//                                on ToSupplier.ID = Supplier_ID;
//         UnitOfMeasure_ID:  String(2);
//         ToUnitOfMeasure : Association to UnitOfMeasures
//                                 on ToUnitOfMeasure.ID = UnitOfMeasure_ID;
// }

entity Products {
    key ID               : UUID;
        Name             : String not null; //Restricción not null
        Description      : String;
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
entity Orders {
    key ID       : UUID;
        Date     : Date;
        Customer : String;
        Item     : Composition of many OrderItems
                       on Item.Order = $self;
}


entity OrderItems {
    key ID       : UUID;
        Order    : Association to Orders;
        Product  : Association to Products;
        Quantity : Integer;
}

entity Suppliers {
    key ID      : UUID;
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
    key ID          : String(2);
        Description : String;
}

entity DimensionUnits {
    key ID          : String(2);
        Description : String;
}

entity Months {
    key ID               : String(2);
        Description      : String;
        ShortDescription : String(3);
}

entity ProductReview {
    key ID      : UUID;
        Name    : String;
        Rating  : Integer;
        Comment : String;
        Product : Association to Products;

}

entity SalesData {
    key ID            : UUID;
        DeliveryDate  : DateTime;
        Revenue       : Decimal(16, 2);
        Product       : Association to Products;
        Currency      : Association to Currencies;
        DeliveryMonth : Association to Months;
}

//Entidad Select ---------------------------
entity SelProducts   as select from Products;

entity SelProducts1  as
    select from Products {
        *
    };

entity SelProducts2  as
    select from Products {
        Name,
        Price,
        Quantity
    };

entity SelProducts3  as
    select from Products
    left join ProductReview
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
//-------------------------------------------------

//Entidad Projection ---------------------------
//No tenemos la posibilidad de utilizar sentencias SQL (joins, agregados, etc)
//Las proyecciones se utilizan para mostrar columnas de los orígenes de datos que utilizamos
entity ProjProducts  as projection on Products;

entity ProjProducts1 as
    projection on Products {
        *
    };

entity ProjProducts2 as
    projection on Products {
        Name,
        Price,
        Quantity
    };
//-------------------------------------------------

//Entidad con Parámetros  ---------------------------
// Sqlite no soporta entidades con parámetros
// entity ParamProducts(pName : String)     as
//     select from Products {
//         Name,
//         Price,
//         Quantity

//     }
//     where
//         Name = :pName;

// entity ParamProjProducts(pName : String) as
//     projection on Products {
//         Name,
//         Price,
//         Quantity
//     }
//     where
//         Name = :pName;
//-------------------------------------------------

//Entidades - Ampliación -------
extend Products with {
    PriceCondition     : String(2);
    PriceDetermination : String(3);
}
//-------------------------------------------------

// Asocicación Many to Many
entity Course {
    key ID      : UUID;
        Student : Association to many StudentCourse
                      on Student.Course = $self;
}

entity Student {
    key ID     : UUID;
        Course : Association to many StudentCourse
                     on Course.Student = $self;
}

entity StudentCourse {
    key ID      : UUID;
        Student : Association to Student;
        Course  : Association to Course;
}
//-------------------------------------------------
