export interface Book {
  id: string;
  title: string;
  author: string;
  year?: number;
}

let nextId = 3;

export const books: Book[] = [
  { id: '1', title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', year: 1925 },
  { id: '2', title: 'To Kill a Mockingbird', author: 'Harper Lee', year: 1960 },
];

export function addBook(title: string, author: string, year?: number): Book {
  const book: Book = { id: String(nextId++), title, author, year };
  books.push(book);
  return book;
}
