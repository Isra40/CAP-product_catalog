namespace com.training;

using {
    cuid,
    managed
} from '@sap/cds/common';

//-- TIPOS MATRIZ
// ------------------------------------------------
type EmailAddresses_01 : array of {
    kind  : String;
    email : String;
}


type EmailAddresses_02 {
    kind  : String;
    email : String;
}

entity Emails {
    email_01 :      EmailAddresses_01;
    email_02 : many EmailAddresses_02;
    email_03 : many {
        kind  : String;
        email : String;
    }
}

//cds db/schema.cds -2 sql
// NCLOB - National Character Large Object

//-- ELEMENTOS VIRTUALES
//-----------------------------------------------
entity Car : cuid {
    name               : String;
    //  Elementos Virtuales (campos que se retornan en las llamadas a los servicios, pero no se graban en BBDD)
    virtual discount_1 : Decimal;

    //   Si se quieren sobreescribir los valores en un POST hay que modificar el metadata "Term="Core.Computed"
    @Core.Computed: false
    virtual discount_2 : Decimal;
}


entity Products : cuid, managed {
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

}

entity ProductReview : cuid, managed {
    // key ID      : UUID;
    Name    : String;
    Rating  : Integer;
    Comment : String;
    Product : Association to Products;

}


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

// Asocicación Many to Many
entity Course : cuid {
    // key ID      : UUID;
    Student : Association to many StudentCourse
                  on Student.Course = $self;
}

entity Student : cuid {
    // key ID     : UUID;
    Course : Association to many StudentCourse
                 on Course.Student = $self;
}

entity StudentCourse : cuid {
    // key ID      : UUID;
    Student : Association to Student;
    Course  : Association to Course;
}
//-------------------------------------------------

entity Orders {
    key ClientEmail  : String(65);
        FirstName    : String(30);
        LastName     : String(30);
        CreatedOn    : Date;
        Reviewed     : Boolean;
        Approved     : Boolean;
        Country_code : String(2);
        Status       : String(5)
}
