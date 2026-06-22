return {
  settings = {
    yaml = {
      format = {
        printWidth = 120
      },
      schemas = {
        ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/openapi-3.X.json"] = {
          "**/openapi.yaml",
          "**/openapi.yml",
          "**/swagger.yaml",
          "**/swagger.yml",
        },
      },
    }
  }
}
