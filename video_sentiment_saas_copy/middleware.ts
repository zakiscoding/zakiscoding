import { auth } from "~/server/auth";

export const runtime = "nodejs";

export default auth((req) => {
  const isAuthenticated = !!req.auth;

  if (!isAuthenticated) {
    return Response.redirect(new URL("/login", req.nextUrl));
  }
});

export const config = {
  matcher: ["/"],
};
