set -e

npm run build
npm publish
npm prune

VER=$(node_modules/node-jq/bin/jq -r '.version' package.json)

for d in $(ls examples); do(
  cd examples/$d
  deno run --allow-read --allow-write ../../scripts/upgrade-dep-version.ts package.json vanjs-ui $VER
  npm prune
)done
