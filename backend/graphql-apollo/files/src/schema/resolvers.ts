import { books, addBook, type Book } from '../data/store.js';

export const resolvers = {
  Query: {
    books: (): Book[] => books,
    book: (_: unknown, { id }: { id: string }): Book | undefined =>
      books.find((b) => b.id === id),
  },
  Mutation: {
    addBook: (_: unknown, args: { title: string; author: string; year?: number }): Book =>
      addBook(args.title, args.author, args.year),
  },
};
