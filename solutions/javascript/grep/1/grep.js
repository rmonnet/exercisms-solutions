#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

/**
 * Reads the given file and returns lines.
 *
 * This function works regardless of POSIX (LF) or windows (CRLF) encoding.
 *
 * @param {string} file path to file
 * @returns {string[]} the lines
 */
function readLines(file) {
  const data = fs.readFileSync(path.resolve(file), { encoding: 'utf-8' });
  return data.split(/\r?\n/);
}

const VALID_OPTIONS = {
  '-n': 'printLineNumbers',
  '-l': 'printFilename',
  '-i': 'ignoreCase',
  '-v': 'reverseResult',
  '-x': 'matchEntireLine',
}

// Reads the options from the set of arguments.
// Returns an option object with meaningful option names to make the main function easier to read.
// Returns the set of enabled options.
function readOptions(args) {
  
  const options = {};
  while (args.length > 0 && args[0].startsWith('-')) {
    const arg = args.shift();
    if (!arg in VALID_OPTIONS) throw new Error(`Invalid option: ${arg}`);
    options[VALID_OPTIONS[arg]] = true;
  }
  return options;
}

// Main function implementing the grep function.
// It takes the list of arguments from the command line and returns the list of findings.
function main(args) {

  // Process the command line arguments.
  
  // We need at least <nodepath>, <script name>, <pattern>, <filename>
  if (args.length < 4) throw new Error('Usage: grep <pattern> [options] <filename>');

  // the arguments are organized as:
  //   <nodepath>, <script name(grep.js)>, [<options>], <pattern>, [<filenames>]
  const processName = args.shift();
  const scriptName = args.shift();
  const options = readOptions(args);
  const pattern = args.shift();
  const fileNames = args;
  const findings = [];

  // Build the regexp from the pattern and relevant options.
  const regexOptions = (options.ignoreCase) ? 'i' : '';
  let regexPattern = (options.matchEntireLine) ? `^${pattern}$` : pattern;
  const regex = new RegExp(regexPattern, regexOptions);
  
  const multipleFiles = fileNames.length > 1;
  
  // Scan the files and collect the matches.
  for (const fileName of fileNames) {
    
    let lineno = 0;
    for (const line of readLines(fileName)) {
      
      lineno++;
      let match = (options.reverseResult) ? !regex.test(line) : regex.test(line);
      if (match) {
        // option printFileName only requires reporting the first match
        if (options.printFilename) {
          findings.push(fileName);
          break;
        }
        let lineMatch = line;
        if (options.printLineNumbers) lineMatch = `${lineno}:${lineMatch}`;
        if (multipleFiles) lineMatch = `${fileName}:${lineMatch}`;
        findings.push(lineMatch);
      }
    }
  }
  return findings;
}

// Run the main function on the script arguments and print the result.
try {
  const findings = main(process.argv);
  if (findings.length > 0) console.log(findings.join('\n'));
} catch (e) {
  console.error(e.message);
}

