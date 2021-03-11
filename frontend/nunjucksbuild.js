#!/usr/bin/env node
const fs = require('fs');
const nunjucks = require('nunjucks');
const input = process.argv[2];
const output = process.argv[3];
const templates_dir = process.argv[4];
const env = new nunjucks.Environment(new nunjucks.FileSystemLoader(templates_dir), { 'lstripBlocks': true, 'trimBlocks': true, });
fs.writeFileSync(
	output,
	nunjucks.compile(fs.readFileSync(input, 'utf8'), env).render({ 'filename': require('path').basename(input, '.njk'), }),
	'utf8',
);
