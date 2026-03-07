import './globals.css';
import { TRPCProvider } from './providers';

export const metadata = { title: '{{APP_NAME}}' };

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>
        <TRPCProvider>{children}</TRPCProvider>
      </body>
    </html>
  );
}
