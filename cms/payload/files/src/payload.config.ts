import { buildConfig } from "payload/config";
import { mongooseAdapter } from "@payloadcms/db-mongodb";
import { webpackBundler } from "@payloadcms/bundler-webpack";
import { slateEditor } from "@payloadcms/richtext-slate";
import { Users } from "./collections/Users";
import { Posts } from "./collections/Posts";
import { Media } from "./collections/Media";

export default buildConfig({
  serverURL: `http://localhost:${process.env.PORT || 3000}`,
  editor: slateEditor({}),
  db: mongooseAdapter({ url: process.env.MONGODB_URI || "mongodb://localhost:27017/payload-cms" }),
  admin: { bundler: webpackBundler() },
  collections: [Users, Posts, Media],
  typescript: { outputFile: "src/payload-types.ts" },
});
