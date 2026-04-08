import { CollectionConfig } from "payload/types";

export const Posts: CollectionConfig = {
  slug: "posts",
  admin: { useAsTitle: "title" },
  fields: [
    { name: "title", type: "text", required: true },
    { name: "content", type: "richText" },
    {
      name: "status",
      type: "select",
      options: ["draft", "published"],
      defaultValue: "draft",
    },
    {
      name: "author",
      type: "relationship",
      relationTo: "users",
    },
    {
      name: "featuredImage",
      type: "upload",
      relationTo: "media",
    },
    { name: "publishedDate", type: "date" },
  ],
};
