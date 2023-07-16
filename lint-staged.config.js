module.exports = {
  "force-app/**/*.{cls,cmp,component,css,html,js,page,trigger,xml}": [
    "prettier --write"
  ],
  "force-app/**/*.{cls,trigger,page}": (filenames) => {
    const joinedfiles = filenames.join(",");
    return `sfdx scanner:run -t "${joinedfiles}"  --engine "pmd" -o codescan/apex-scan.csv -f csv -s 3`;
  },
  "force-app/**/*.js": (filenames) => {
    return `sfdx scanner:run -t "${filenames.join(
      ","
    )}" --engine "eslint" --eslintconfig ".eslintrc.json" -o codescan/eslint-scan.csv -f csv -s 3`;
  }
};
