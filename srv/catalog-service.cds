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
            ID,
            Name          as ProductName,
            Description,
            ImageUrl,
            ReleaseDate,
            DiscontinuedDate,
            Price,
            Height,
            Width,
            Depth,
            Quantity,
            UnitOfMeasure as ToUnitOfMeasure,
            Currency      as ToCurrency,
            Category      as ToCategory,
            Category.Name as Category,
            DimensionUnit as ToDimensionUnit,
            Supplier,
            Reviews,
            SalesData
        }

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

    entity StockAvailability as
        select from capdemo.material.StockAvailability {
            ID,
            Description,
            Product as ToProduct
        }

    entity VH_Categories     as
        select from capdemo.material.Categories {
            ID   as Code,
            Name as Text
        }

    entity VH_Currencies     as
        select from capdemo.material.Currencies {
            ID          as Code,
            Description as Text
        }

    entity VH_UnitOfMeasure  as
        select from capdemo.material.UnitOfMeasures {
            ID          as Code,
            Description as Text
        }

    entity VH_DimensionUnits as
        select from capdemo.material.DimensionUnits {
            ID          as Code,
            Description as Text
        }

}
