import { baseLayout } from "./base.js";

export function resetPasswordEmail(resetUrl: string): string {
  return baseLayout(`
    <h1>Reset Your Password</h1>
    <p>Click the button below to reset your password. This link expires in 1 hour.</p>
    <p><a class="btn" href="${resetUrl}">Reset Password</a></p>
    <p style="color: #666; font-size: 14px;">If you didn't request this, you can safely ignore this email.</p>
  `);
}
