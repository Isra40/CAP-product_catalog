using com.capdemo as capdemo from '../db/schema';

service CatalogService {
    entity Products as projection on capdemo.Products;
}