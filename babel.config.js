{
  plugins: [
    [require("babel-plugin-module-resolver").default, {
      "root": ["./app"],
      "alias": {
        "assets": "./assets"
      }
    }]
  ]
}