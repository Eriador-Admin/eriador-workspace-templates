const express = require("express");
const swaggerUi = require("swagger-ui-express");
const YAML = require("yamljs");
const path = require("path");

const app = express();
const PORT = process.env.SWAGGER_PORT || {{DEV_PORT}};

const spec = YAML.load(path.join(__dirname, "spec", "openapi.yaml"));

app.use("/", swaggerUi.serve, swaggerUi.setup(spec));

app.listen(PORT, () => {
  console.log(`Swagger UI available at http://localhost:${PORT}`);
});
