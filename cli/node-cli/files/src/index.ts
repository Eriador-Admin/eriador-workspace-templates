#!/usr/bin/env node
import { Command } from 'commander';
import { registerGreetCommand } from './commands/greet.js';

const program = new Command();

program
  .name('{{CLI_NAME}}')
  .description('{{CLI_DESCRIPTION}}')
  .version('1.0.0');

registerGreetCommand(program);

program.parse();
