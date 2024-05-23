const cds = require("@sap/cds");
const { Orders } = cds.entities("com.training");

module.exports = (srv) => {


    srv.before("*", (req) => {
        console.log(`Method: ${req.method}`);
        console.log(`Target: ${req.target}`);
    });

    //*********** READ **********/
    srv.on("READ", "Orders", async (req) => {
        //      Si se solicita un cliente        
        if (req.data.ClientEmail !== undefined) {
            return await SELECT.from`com.training.Orders`
                .where`ClientEmail = ${req.data.ClientEmail}`;
        }
        return await SELECT.from(Orders);
    });

    srv.after("READ", "Orders", (data) => {
        return data.map((order) => (order.Reviewed = true));
    });


    //*********** CREATE **********/
    srv.before("CREATE", "Orders", (req) => {
        req.data.CreatedOn = new Date().toISOString().slice(0, 10);
        console.log(req.data.CreatedOn);
        return req;// 
    });

    srv.on("CREATE", "Orders", async (req) => {
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
    srv.on("UPDATE", "Orders", async (req) => {
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
        console.log("Before end", returnData);
        return returnData;
    });


    //*********** DELETE **********/
    srv.on("DELETE", "Orders", async (req) => {
        let returnData = await cds
            .transaction(req)
            .run(
                DELETE.from(Orders).where({
                    ClientEmail: req.data.ClientEmail,
                })
            )
            .then((resolve, reject) => {
                console.log("Resolve: ", resolve);
                console.log("Reject: ", reject);

                if (resolve !== 1) {
                    req.error(409, "Record Not Found");
                }
            }).catch((err) => {
                console.log(err);
                req.error(err.code, err.message);
            });
        console.log("Before end", returnData);
        return returnData;
    });

    //*********** FUNCTION **********/
    srv.on("getClientTaxRate", async (req) => {
        //NO server side-effect
        const { ClientEmail } = req.data;
        const db = srv.transaction(req);

        const result = await db
            .read(Orders, ["Country_code"])
            .where({ ClientEmail: ClientEmail });

        console.log(result[0]);
        switch (result[0].Country_code) {
            case 'ES':
                return 21.5;
            case 'UK':
                return 24.6;
            default:
                break;
        }
    });

    //*********** ACTION **********/
    srv.on("cancelOrder", async (req) => {
        //Server side-effect
        const { ClientEmail } = req.data;
        const db = srv.transaction(req);

        const resultRead = await db
            .read(Orders, ["FirstName", "LastName", "Approved"])
            .where({ ClientEmail: ClientEmail });

        let returnOrder = {
            status: "",
            message: ""
        };

        console.log(ClientEmail);
        console.log(resultRead);

        if (resultRead[0].Approved == false) {
            const resultUpdate = await db
                .update(Orders)
                .set({ Status: 'C' })
                .where({ ClientEmail: ClientEmail })
            returnOrder.status = "Succeeded";
            returnOrder.message = `The Order placed by ${resultRead[0].FirstName} ${resultRead[0].LastName} was canceled`;
        } else {
            returnOrder.status = "Failed";
            returnOrder.message = `The Order placed by ${resultRead[0].FirstName} ${resultRead[0].LastName} was NOT cancel
            because we have Approved`;
        }
        console.log("Action cancel order execute");
        return returnOrder;
    });

}; 