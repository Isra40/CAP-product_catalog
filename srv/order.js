const cds = require("@sap/cds");
const { Orders } = cds.entities("com.training");

module.exports = (srv) => {

    //*********** READ **********/
    srv.on("READ", "GetOrders", async (req) => {
        console.log("srv.on");
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


    //*********** CREATE **********/
    srv.before("CREATE", "CreateOrder", (req) => {
        // req.data.CreatedOn = new Date().toISOString().slice(0,10);
        console.log("srv.on");
        // return req;// 
    });

    srv.on("CREATE", "CreateOrder", async (req) => {
        let returnData = await cds
            .transaction(req)
            .run(
                INSERT.into(Orders).entries({
                    ClientEmail: req.data.ClientEmail,
                    FirstName: req.data.FirstName,
                    LastName: req.data.LastName,
                    CreatedOn: req.data.CreatedOn,
                    Reviewed: req.data.Reviewed,
                    Approved: req.data.Approved,
                    Country_code: req.data.Country_code,
                    Status: req.data.Status
                })
            )
            .then((resolve, reject) => {
                console.log("Resolve", resolve);
                console.log("Reject", reject);

                if (typeof resolve !== "undefined") {
                    return req.data;
                } else {
                    req.console.error(409, "Record Not Inserted");
                }
            })
            .catch((err) => {
                console.log(err);
                req.error(err.code, err.message);
            });
        return returnData;
    });

    //*********** UPDATE **********/
    srv.on("UPDATE", "UpdateOrder", async (req) => {
        let returnData = await cds
            .transaction(req)
            .run([
                UPDATE(Orders, req.data.ClientEmail).set({
                    FirstName: req.data.FirstName,
                    LastName: req.data.LastName,
                }),
            ])
            .then((resolve, reject) => {
                console.log("Resolve: ", resolve);
                console.log("Reject: ", reject);
        
                if (resolve[0] == 0) {
                  req.error(409, "Record Not Found");
                }
            }).catch((err) => {
                console.log(err);
                req.error(err.code, err.message);
            });
    });

}; 