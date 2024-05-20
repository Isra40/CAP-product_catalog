using com.capdemo as capdemo from '../db/schema';

service CatalogService {
    entity Products       as projection on capdemo.Products;
    entity Suppliers      as projection on capdemo.Suppliers;
    entity UnitOfMeasures as projection on capdemo.UnitOfMeasures;
    entity Currency       as projection on capdemo.Currencies;
    entity DimensionUnit  as projection on capdemo.DimensionUnits;
    entity SalesData      as projection on capdemo.SalesData;
    entity Reviews        as projection on capdemo.ProductReview;
}
