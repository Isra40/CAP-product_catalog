sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'logaligroup/product/test/integration/FirstJourney',
		'logaligroup/product/test/integration/pages/ProductList',
		'logaligroup/product/test/integration/pages/ProductObjectPage',
		'logaligroup/product/test/integration/pages/ReviewsObjectPage'
    ],
    function(JourneyRunner, opaJourney, ProductList, ProductObjectPage, ReviewsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('logaligroup/product') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheProductList: ProductList,
					onTheProductObjectPage: ProductObjectPage,
					onTheReviewsObjectPage: ReviewsObjectPage
                }
            },
            opaJourney.run
        );
    }
);