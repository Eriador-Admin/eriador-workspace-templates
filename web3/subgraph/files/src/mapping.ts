import { BigInt } from "@graphprotocol/graph-ts";
import { NumberChanged as NumberChangedEvent } from "../generated/Counter/Counter";
import { Counter, NumberChanged } from "../generated/schema";

const COUNTER_ID = "singleton";

export function handleNumberChanged(event: NumberChangedEvent): void {
  // Create immutable event entity
  const id = event.transaction.hash.concatI32(event.logIndex.toI32());
  const numberChanged = new NumberChanged(id.toHexString());
  numberChanged.oldNumber = event.params.oldNumber;
  numberChanged.newNumber = event.params.newNumber;
  numberChanged.blockNumber = event.block.number;
  numberChanged.blockTimestamp = event.block.timestamp;
  numberChanged.transactionHash = event.transaction.hash;
  numberChanged.save();

  // Update singleton counter entity
  let counter = Counter.load(COUNTER_ID);
  if (!counter) {
    counter = new Counter(COUNTER_ID);
    counter.totalChanges = BigInt.fromI32(0);
  }
  counter.currentNumber = event.params.newNumber;
  counter.totalChanges = counter.totalChanges.plus(BigInt.fromI32(1));
  counter.lastUpdatedAt = event.block.timestamp;
  counter.lastTransactionHash = event.transaction.hash;
  counter.save();
}
