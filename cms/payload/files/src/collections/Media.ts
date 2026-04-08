import { CollectionConfig } from "payload/types";

export const Media: CollectionConfig = {
  slug: "media",
  upload: {
    staticDir: "../media",
    mimeTypes: ["image/*", "application/pdf"],
    imageSizes: [
      { name: "thumbnail", width: 300, height: 300, position: "centre" },
      { name: "medium", width: 800, height: undefined, position: "centre" },
    ],
  },
  fields: [
    { name: "alt", type: "text", required: true },
  ],
};
