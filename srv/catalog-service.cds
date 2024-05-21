using com.capdemo as capdemo from '../db/schema';

// service CatalogService {
//     entity Products       as projection on capdemo.material.Products;
//     entity Suppliers      as projection on capdemo.sales.Suppliers;
//     entity UnitOfMeasures as projection on capdemo.material.UnitOfMeasures;
//     entity Currency       as projection on capdemo.material.Currencies;
//     entity DimensionUnit  as projection on capdemo.material.DimensionUnits;
//     entity SalesData      as projection on capdemo.sales.SalesData;
//     entity Reviews        as projection on capdemo.material.ProductReview;
//     entity Orders as projection on capdemo.sales.Orders;
//     entity OrderItems as projection on capdemo.sales.OrderItems;
//     entity Month as projection on capdemo.sales.Months;
// }

define service CatalogService {

    entity Product           as
        select from capdemo.material.Products {
            // ID,
            // Name          as ProductName     @mandatory,
            // Description                      @mandatory,
            // ImageUrl,
            // ReleaseDate,
            // DiscontinuedDate,
            // Price                            @mandatory,
            // Height,
            // Width,
            // Depth,
            *, //Selector Inteligente Incluye las columnas anteriores al siguiente campo informado
            Quantity,
            UnitOfMeasure as ToUnitOfMeasure @mandatory,
            Currency      as ToCurrency      @mandatory,
            Category      as ToCategory      @mandatory,
            Category.Name as Category        @readonly,
            DimensionUnit as ToDimensionUnit @mandatory,
            Supplier,
            Reviews,
            SalesData
        }

    @readonly
    entity Supplier          as
        select from capdemo.sales.Suppliers {
            ID,
            Name,
            Email,
            Phone,
            Fax,
            Product as ToProduct
        }

    entity Reviews           as
        select from capdemo.material.ProductReview {
            ID,
            Name,
            Rating,
            Comment,
            createdAt,
            Product as ToProduct
        }

    @readonly
    entity SalesData         as
        select from capdemo.sales.SalesData {
            ID,
            DeliveryDate,
            Revenue,
            Currency.ID               as CurrencyKey,
            DeliveryMonth             as DeliveryMonthId,
            DeliveryMonth.Description as DeliveryMonth,
            Product                   as ToProduct
        }

    @readonly
    entity StockAvailability as
        select from capdemo.material.StockAvailability {
            ID,
            Description,
            Product as ToProduct
        }

    @readonly
    entity VH_Categories     as
        select from capdemo.material.Categories {
            ID   as Code,
            Name as Text
        }

    @readonly
    entity VH_Currencies     as
        select from capdemo.material.Currencies {
            ID          as Code,
            Description as Text
        }

    @readonly
    entity VH_UnitOfMeasure  as
        select from capdemo.material.UnitOfMeasures {
            ID          as Code,
            Description as Text
        }

    @readonly
    entity VH_DimensionUnits as
        select from capdemo.material.DimensionUnits {
            ID          as Code,
            Description as Text
        }

// @readonly
// entity VH_DimensionUnitsPostFix as
//     select
//         ID          as Code,
//         Description as Text
//     from capdemo.material.DimensionUnits

}

define service MyService {

    entity SuppliersProduct as
        select from capdemo.material.Products[Name = 'Bread']{ // Expresión de ruta
            *,
            Name,
            Description,
            Supplier.Address
        }
        where
            Supplier.ID = 'aead11fd-e35b-4f6f-a37a-e4a860aaaad7'; // Expresión de ruta

    entity SupliersToSales  as
        select
            Supplier.Email,
            Category.Name,
            SalesData.Currency.ID
        from capdemo.material.Products;

    // Filtro Infix
    entity EntityInfix      as
        select Supplier[Name = 'Exotic Liquids'].Phone from capdemo.material.Products
        where
            Products.Name = 'Bread';

    // Filtro Join SQL = mismo resultado que Infix EntityInfix
    entity EntityJoin       as
        select Phone from capdemo.material.Products
        left join capdemo.sales.Suppliers as supp
            on(
                supp.ID
            ) = Products.Supplier.ID
            and supp.Name = 'Exotic Liquids'
        where
            Products.Name = 'Bread';
}

define service Reports {
    entity AverageRating as projection on capdemo.reports.AverageRating;

    entity Product       as
        select from capdemo.reports.Products {
            ID,
            Name          as ProductName     @mandatory,
            Description                      @mandatory,
            ImageUrl,
            ReleaseDate,
            DiscontinuedDate,
            Price                            @mandatory,
            Height,
            Width,
            Depth,
            Quantity                         @(
                mandatory,
                assert.range: [
                    0.00,
                    20.00
                ]
            ),
            UnitOfMeasure as ToUnitOfMeasure @mandatory,
            Currency      as ToCurrency      @mandatory,
            Category      as ToCategory      @mandatory,
            Category.Name as Category        @readonly,
            DimensionUnit as ToDimensionUnit @mandatory,
            SalesData,
            Supplier,
            Rating,
            StockAvailability,
            ToStockAvailibility
        }
}
