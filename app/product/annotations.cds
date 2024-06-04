using CatalogService as service from '../../srv/catalog-service';

annotate service.Product with @(

    Capabilities      : {DeleteRestrictions: {
        $Type    : 'Capabilities.DeleteRestrictionsType',
        Deletable: false
    }, },

    UI.HeaderInfo     : {
        TypeName      : '{i18n>Product}',
        TypeNamePlural: '{i18n>Products}',
        ImageUrl      : ImageUrl,
        Title         : {Value: ProductName},
        Description   : {Value: Description}
    },

    UI.SelectionFields: [
        ToCategory_ID,
        ToCurrency_ID,
        StockAvailability
    ],

    UI.LineItem       : [
        {
            $Type: 'UI.DataField',
            Label: '{i18n>ImageUrl}',
            Value: ImageUrl,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>ProductName}',
            Value: ProductName,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Description}',
            Value: Description,
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Label : '{i18n>Supplier}',
            Target: 'Supplier/@Communication.Contact'
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>ReleaseDate}',
            Value: ReleaseDate,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>DiscontinuedDate}',
            Value: DiscontinuedDate,
        },
        {
            Label : '{i18n>Rating}',
            $Type : 'UI.DataFieldForAnnotation',
            Target: '@UI.DataPoint#AverageRating'
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Price}',
            Value: Price
        }
    ]
);

annotate service.Product with @(UI.FieldGroup #GeneratedGroup1: {
    $Type: 'UI.FieldGroupType',
    Data : [
        {
            $Type: 'UI.DataField',
            Label: '{i18n>ReleaseDate}',
            Value: ReleaseDate,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>DiscontinuedDate}',
            Value: DiscontinuedDate,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Price}',
            Value: Price,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Height}',
            Value: Height,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Width}',
            Value: Width,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Depth}',
            Value: Depth,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Quantity}',
            Value: Quantity,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>UnitOfMeasure}',
            Value: ToUnitOfMeasure_ID,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Currency}',
            Value: ToCurrency_ID,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>CategoryId}',
            Value: ToCategory_ID,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Category}',
            Value: Category,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>DimensionUnitID}',
            Value: ToDimensionUnit_ID,
        }
    ],
}, );

annotate service.Product with {
    ImageUrl @(UI.IsImageURL: true)
};

/**
 * Annotations for SH
 */
annotate service.Product with {
    //Category
    ToCategory @(Common: {
        Text     : {
            $value                : Category,
            ![@UI.TextArrangement]: #TextOnly,
        },
        ValueList: {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Categories',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: ToCategory_ID,
                    ValueListProperty: 'Code'
                },
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: Category,
                    ValueListProperty: 'Text'
                }
            ]
        },
    });

    //Currency
    ToCurrency @(Common: {
        ValueListWithFixedValues: false,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Currencies',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: ToCurrency_ID,
                    ValueListProperty: 'Code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Text'
                }
            ]
        },
    });

    StockAvailability @(Common : {
        ValueListWithFixedValues : true,
        ValueList                : {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'StockAvailability',
            Parameters     : [{
                $Type             : 'Common.ValueListParameterInOut',
                LocalDataProperty : StockAvailability,
                ValueListProperty : 'ID'
            }]
        },
    });

};

/**
 * Annotations for VH_Categories Entity
 */
annotate service.VH_Categories with {
    Code @(
        UI    : {Hidden: true},
        Common: {Text: {
            $value                : Text,
            ![@UI.TextArrangement]: #TextOnly,
        }}
    );
    Text @(UI: {HiddenFilter: true});
};

/**
 * Annotations for VH_Currency Entity
 */
annotate service.VH_Currencies {
    Code @(UI: {
        title       : '{i18n>Code}',
        HiddenFilter: true
    });
    Text @(UI: {
        title       : '{i18n>Text}',
        HiddenFilter: true
    });
};

/**
 * Annotations for StockAvailability Entity
 */
annotate service.StockAvailability {
    ID @(Common: {Text: {
        $value                : Description,
        ![@UI.TextArrangement]: #TextOnly,
    }, })
};

/**
 * Annotations for VH_UnitOfMeasure Entity
 */
annotate service.VH_UnitOfMeasure {
    Code @(UI: {
        title       : '{i18n>Code}',
        HiddenFilter: true
    });
    Text @(UI: {
        title       : '{i18n>Text}',
        HiddenFilter: true
    });
};

/**
 * Annotations for VH_DimensionUnits Entity
 */
annotate service.VH_DimensionUnits {
    Code @(UI: {
        title       : '{i18n>Code}',
        HiddenFilter: true
    });
    Text @(UI: {
        title       : '{i18n>Text}',
        HiddenFilter: true
    });
};

/**
 * Annotations for Supplier Entity
 */
annotate service.Supplier with @(Communication: {Contact: {
    $Type: 'Communication.ContactType',
    fn   : Name,
    role : '{i18n>Supplier}',
    photo: 'sap-icon://supplier',
    email: [{
        type   : #work,
        address: Email
    }],
    tel  : [
        {
            type: #work,
            uri : Phone
        },
        {
            type: #fax,
            uri : Fax
        }
    ]
}, });
