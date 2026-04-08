import mongoose, { Schema, type Document } from "mongoose";

export interface IItem extends Document {
  name: string;
  description: string;
  completed: boolean;
  createdAt: Date;
}

const itemSchema = new Schema<IItem>(
  {
    name: { type: String, required: true },
    description: { type: String, default: "" },
    completed: { type: Boolean, default: false },
  },
  { timestamps: true }
);

export const Item = mongoose.model<IItem>("Item", itemSchema);
