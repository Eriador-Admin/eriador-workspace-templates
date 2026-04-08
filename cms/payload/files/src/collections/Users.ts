import { CollectionConfig } from "payload/types";

export const Users: CollectionConfig = {
  slug: "users",
  auth: true,
  admin: { useAsTitle: "email" },
  fields: [
    { name: "name", type: "text" },
    { name: "role", type: "select", options: ["admin", "editor", "viewer"], defaultValue: "viewer" },
  ],
};
