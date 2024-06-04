using CatalogService as service from '../../srv/catalog-service';
annotate service.Product with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Name',
                Value : Name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Description',
                Value : Description,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ImageUrl',
                Value : ImageUrl,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ReleaseDate',
                Value : ReleaseDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'DiscontinuedDate',
                Value : DiscontinuedDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Price',
                Value : Price,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Height',
                Value : Height,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Width',
                Value : Width,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Depth',
                Value : Depth,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Quantity',
                Value : Quantity,
            },
            {
                $Type : 'UI.DataField',
                Label : 'UnitOfMeasure_ID',
                Value : UnitOfMeasure_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Currency_ID',
                Value : Currency_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'DimensionUnit_ID',
                Value : DimensionUnit_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Category',
                Value : Category,
            },
            {
                $Type : 'UI.DataField',
                Label : 'PriceCondition',
                Value : PriceCondition,
            },
            {
                $Type : 'UI.DataField',
                Label : 'PriceDetermination',
                Value : PriceDetermination,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ToUnitOfMeasure_ID',
                Value : ToUnitOfMeasure_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ToCurrency_ID',
                Value : ToCurrency_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ToCategory_ID',
                Value : ToCategory_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ToDimensionUnit_ID',
                Value : ToDimensionUnit_ID,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Name',
            Value : Name,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Description',
            Value : Description,
        },
        {
            $Type : 'UI.DataField',
            Label : 'ImageUrl',
            Value : ImageUrl,
        },
        {
            $Type : 'UI.DataField',
            Label : 'ReleaseDate',
            Value : ReleaseDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'DiscontinuedDate',
            Value : DiscontinuedDate,
        },
    ],
    UI.SelectionFields: [
        ToCategory_ID,
        ToCurrency_ID        
    ]
);

annotate service.Product with {
    Supplier @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Supplier',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : Supplier_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Email',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Phone',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Fax',
            },
        ],
    }
};

