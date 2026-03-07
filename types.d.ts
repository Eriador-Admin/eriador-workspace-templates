/**
 * Ambient type declarations for template files in the workspace-templates repo.
 * These allow .tsx template files to pass type checking without installing
 * node_modules. This file is NOT scaffolded into projects.
 */

declare namespace JSX {
  interface IntrinsicElements {
    [elemName: string]: any;
  }
}

declare namespace React {
  type ReactNode = any;
}

declare module 'react' {
  export const StrictMode: any;
  export function createContext(defaultValue?: any): any;
  export function useState<T>(initial: T | (() => T)): [T, (v: T | ((p: T) => T)) => void];
  export type ReactNode = any;
  const React: any;
  export default React;
}

declare module 'react/jsx-runtime' {
  export const jsx: any;
  export const jsxs: any;
  export const Fragment: any;
}

declare module 'react-dom/client' {
  export function createRoot(container: any): { render(element: any): void };
}

declare module 'react-native' {
  export const View: any;
  export const Text: any;
  export const Button: any;
  export const StyleSheet: { create(styles: any): any };
}

declare module '@react-navigation/native' {
  export const NavigationContainer: any;
}

declare module '@react-navigation/native-stack' {
  export function createNativeStackNavigator<T = any>(): any;
  export type NativeStackScreenProps<T, K extends keyof T = keyof T> = any;
}

declare module 'next/server' {
  export const NextResponse: { json(data: any): any };
}

declare module '@trpc/server' {
  export function initTRPC(): any;
  export const TRPCError: any;
}

declare module '@trpc/server/adapters/fetch' {
  export function fetchRequestHandler(opts: any): any;
}

declare module '@trpc/client' {
  export function httpBatchLink(opts: any): any;
}

declare module '@trpc/react-query' {
  export function createTRPCReact<T>(): any;
}

declare module '@tanstack/react-query' {
  export class QueryClient { constructor(opts?: any); }
  export const QueryClientProvider: any;
}

declare module 'superjson' {
  const superjson: any;
  export default superjson;
}

declare module 'zod' {
  export const z: any;
}

declare module '@prisma/client' {
  export class PrismaClient {
    constructor(opts?: any);
    post: any;
    [key: string]: any;
  }
}
