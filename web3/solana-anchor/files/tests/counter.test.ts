import * as anchor from "@coral-xyz/anchor";
import { Program } from "@coral-xyz/anchor";
import { Keypair, SystemProgram } from "@solana/web3.js";
import { expect } from "chai";

describe("counter", () => {
  const provider = anchor.AnchorProvider.env();
  anchor.setProvider(provider);

  const program = anchor.workspace.Counter as Program;
  const counterKeypair = Keypair.generate();

  it("initializes the counter", async () => {
    await program.methods
      .initialize()
      .accounts({
        counter: counterKeypair.publicKey,
        authority: provider.wallet.publicKey,
        systemProgram: SystemProgram.programId,
      })
      .signers([counterKeypair])
      .rpc();

    const account = await program.account.counter.fetch(
      counterKeypair.publicKey
    );
    expect(account.count.toNumber()).to.equal(0);
    expect(account.authority.toBase58()).to.equal(
      provider.wallet.publicKey.toBase58()
    );
  });

  it("increments the counter", async () => {
    await program.methods
      .increment()
      .accounts({
        counter: counterKeypair.publicKey,
        authority: provider.wallet.publicKey,
      })
      .rpc();

    const account = await program.account.counter.fetch(
      counterKeypair.publicKey
    );
    expect(account.count.toNumber()).to.equal(1);
  });

  it("increments again", async () => {
    await program.methods
      .increment()
      .accounts({
        counter: counterKeypair.publicKey,
        authority: provider.wallet.publicKey,
      })
      .rpc();

    const account = await program.account.counter.fetch(
      counterKeypair.publicKey
    );
    expect(account.count.toNumber()).to.equal(2);
  });

  it("decrements the counter", async () => {
    await program.methods
      .decrement()
      .accounts({
        counter: counterKeypair.publicKey,
        authority: provider.wallet.publicKey,
      })
      .rpc();

    const account = await program.account.counter.fetch(
      counterKeypair.publicKey
    );
    expect(account.count.toNumber()).to.equal(1);
  });

  it("sets the counter to a specific value", async () => {
    await program.methods
      .set(new anchor.BN(42))
      .accounts({
        counter: counterKeypair.publicKey,
        authority: provider.wallet.publicKey,
      })
      .rpc();

    const account = await program.account.counter.fetch(
      counterKeypair.publicKey
    );
    expect(account.count.toNumber()).to.equal(42);
  });
});
