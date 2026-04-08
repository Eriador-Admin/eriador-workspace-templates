import fs from "fs";
import path from "path";

const OUTPUT_DIR = path.join(process.cwd(), "output");

export function saveJSON(filename: string, data: unknown) {
  fs.mkdirSync(OUTPUT_DIR, { recursive: true });
  const filepath = path.join(OUTPUT_DIR, filename);
  fs.writeFileSync(filepath, JSON.stringify(data, null, 2));
  console.log(`Saved ${filepath}`);
}

export function saveCSV(filename: string, rows: Record<string, string>[]) {
  if (rows.length === 0) return;
  fs.mkdirSync(OUTPUT_DIR, { recursive: true });
  const headers = Object.keys(rows[0]);
  const csv = [
    headers.join(","),
    ...rows.map((r) =>
      headers.map((h) => `"${(r[h] || "").replace(/"/g, '""')}"`).join(",")
    ),
  ].join("\n");
  const filepath = path.join(OUTPUT_DIR, filename);
  fs.writeFileSync(filepath, csv);
  console.log(`Saved ${filepath}`);
}
