import { Command } from 'commander';
import { log } from '../utils/logger.js';

export function registerGreetCommand(program: Command): void {
  program
    .command('greet')
    .description('Greet someone by name')
    .requiredOption('-n, --name <name>', 'Name to greet')
    .option('-s, --shout', 'Greet in uppercase', false)
    .action((options: { name: string; shout: boolean }) => {
      let message = `Hello, ${options.name}!`;
      if (options.shout) {
        message = message.toUpperCase();
      }
      log.success(message);
    });
}
