module.exports = {
  extends: ["stylelint-config-standard", "stylelint-prettier/recommended"],
  rules: {
    "selector-class-pattern": [
      "^[\\w_-]+$",
      {
        message: (name) =>
          `Expected classname "${name}" to contain only alphanumeric, - and _, for example "prefix-domain-item_size"`
      }
    ]
  },

  overrides: [
    {
      files: ["**/lwc/**"],
      plugins: ["stylelint-declaration-strict-value"],
      rules: {
        "scale-unlimited/declaration-strict-value": [
          ["/color$/", "background", "font-size", "line-height"],
          {
            ignoreFunctions: false
          }
        ],
        "custom-property-pattern": [
          "^(b2b|exp)\\w+|(dxp|exp)(-[a-z0-9_]+)*$",
          {
            message: (name) =>
              `Expected "${name}" to match supported properties: --b2b*, --exp*, --dxp-*`
          }
        ]
      }
    }
  ]
};
