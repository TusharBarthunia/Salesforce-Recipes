
const jwt = require("jsonwebtoken");
const fs = require("fs");

// Salesforce External Client App Consumer Key
const CLIENT_ID = "3MVG97L7PWbPq6UzaHntCyt_ZHfQkStXgUDQSE95peTu7gneE61UZGZ7dQO_Ts0lqieVJk2EN5t7HFOvaDswQ";

// Salesforce Integration User's exact username
const USERNAME = "tbarthuniya7186.8af554c0ea0c@agentforce.com";

// Salesforce Developer Org
const AUDIENCE = "https://login.salesforce.com";

// Read private key
const privateKey = fs.readFileSync("../server.key", "utf8");

// JWT payload
const payload = {
    iss: CLIENT_ID,
    sub: USERNAME,
    aud: AUDIENCE,
    exp: Math.floor(Date.now() / 1000) + 180
};

// Generate signed JWT
const assertion = jwt.sign(payload, privateKey, {
    algorithm: "RS256"
});

console.log("JWT generated successfully!");
console.log(assertion);
