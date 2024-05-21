using com.capdemo as capdemo from '../db/schema';
// using com.training as training from '../db/schema';

service CatalogService {
    entity Products       as projection on capdemo.material.Products;
    entity Suppliers      as projection on capdemo.sales.Suppliers;
    entity UnitOfMeasures as projection on capdemo.material.UnitOfMeasures;
    entity Currency       as projection on capdemo.material.Currencies;
    entity DimensionUnit  as projection on capdemo.material.DimensionUnits;
    entity SalesData      as projection on capdemo.sales.SalesData;
    entity Reviews        as projection on capdemo.sales.ProductReview;
    entity Orders as projection on capdemo.sales.Orders;
    entity OrderItems as projection on capdemo.sales.OrderItems;
    entity Month as projection on capdemo.sales.Months;
}
