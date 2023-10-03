module.exports = {
  "src/**/*.{cls,cmp,component,css,html,js,page,trigger,xml}": [
    "prettier --write"
  ],
  "src/**/*.{cls,trigger,page}": (filenames) => {
    const joinedfiles = filenames.join(",");
    return `sf scanner run -t "${joinedfiles}"  --engine "pmd" -o codescan/apex-scan.csv -f csv -s 3`;
  },
  "src/**/*.js": (filenames) => {
    return `sf scanner run -t "${filenames.join(
      ","
    )}" --engine "eslint" --eslintconfig ".eslintrc.json" -o codescan/eslint-scan.csv -f csv -s 3`;
  }
};
