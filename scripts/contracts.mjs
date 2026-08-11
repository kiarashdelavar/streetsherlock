import { spawnSync } from "node:child_process";
import {
  existsSync,
  mkdirSync,
  mkdtempSync,
  readFileSync,
  rmSync,
} from "node:fs";
import { tmpdir } from "node:os";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const root = fileURLToPath(new URL("../", import.meta.url));
const spec = join(root, "packages", "contracts", "openapi.json");
const generated = join(
  root,
  "packages",
  "contracts",
  "src",
  "generated",
  "api-types.ts",
);
const generator = "openapi-typescript@7.9.1";

function runPnpm(args) {
  const pnpmScript = process.env.npm_execpath;
  const command = pnpmScript ? process.execPath : "corepack";
  const commandArgs = pnpmScript
    ? [pnpmScript, "--silent", ...args]
    : ["pnpm", "--silent", ...args];

  const result = spawnSync(command, commandArgs, {
    cwd: root,
    stdio: "inherit",
    shell: false,
  });

  if (result.error) {
    console.error(`Unable to run pnpm: ${result.error.message}`);
    process.exit(127);
  }
  if (result.status !== 0) {
    process.exit(result.status ?? 1);
  }
}

function generate(output = generated) {
  mkdirSync(dirname(output), { recursive: true });
  runPnpm(["dlx", generator, spec, "-o", output]);
}

function check() {
  const temporaryDirectory = mkdtempSync(join(tmpdir(), "streetsherlock-contracts-"));

  try {
    const candidate = join(temporaryDirectory, "api-types.ts");
    generate(candidate);

    const current = existsSync(generated) ? readFileSync(generated) : null;
    const next = readFileSync(candidate);

    if (current === null || !current.equals(next)) {
      console.error("Generated API types are stale.");
      console.error("Run: corepack pnpm contracts:generate");
      process.exitCode = 1;
      return;
    }

    console.log("OpenAPI TypeScript client is current.");
  } finally {
    rmSync(temporaryDirectory, { recursive: true, force: true });
  }
}

switch (process.argv[2]) {
  case "generate":
    generate();
    break;
  case "check":
    check();
    break;
  default:
    console.error("Usage: node scripts/contracts.mjs {generate|check}");
    process.exitCode = 64;
}
