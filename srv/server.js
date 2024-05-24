const cds = require("@sap/cds");
const exp = require("constants");

cds.on("bootstrap", (app) => {
     app.get("/alive", (_,res) => {
            res.status(200).send("Server is Alive");
     })
});

module.exports = cds.server;