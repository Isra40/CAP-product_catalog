const cds = require("@sap/cds");
const { Orders } = cds.entities("com.training");

module.exports = (srv) => {

    //*********** READ **********/
    srv.on("READ", "GetOrders", async (req) => {

        //      Si se solicita un cliente        
        if (req.data.ClientEmail !== undefined) {
            return await SELECT.from`com.training.Orders`
                .where`ClientEmail = ${req.data.ClientEmail}`;
        }
        return await SELECT.from(Orders);
    });

    srv.after("READ", "GetOrders", (data) => {
        return data.map((order) => (order.Reviewed = true));
    });

}; 