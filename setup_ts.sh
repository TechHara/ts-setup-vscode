PRJNAME=$1

mkdir $PRJNAME
cd $PRJNAME
npm init -y
npm i --save-dev typescript

# we assume typescript is installed globally
tsc --init --sourceMap --rootDir src --outDir dist

# create source files
mkdir src
cat > src/index.ts <<'EOL'
import { world } from "./world";

console.log(`hello ${world()}`);
EOL

cat > src/world.ts <<EOF
export function world() { return "world"; }
EOF

# create vscode config file
mkdir .vscode

cat > .vscode/launch.json << 'EOL'
{
	"version": "0.2.0",
	"configurations": [
		{
			"type": "node",
			"request": "launch",
			"name": "debug",
			"skipFiles": [
				"<node_internals>/**"
			],
			"preLaunchTask": "tsc: build - tsconfig.json",
			"program": "${workspaceFolder}/dist/index.js",
			"outFiles": [
				"${workspaceFolder}/**/*.js"
			]
		}
	]
}
EOL

# compile
tsc

# launch vscode
code .
