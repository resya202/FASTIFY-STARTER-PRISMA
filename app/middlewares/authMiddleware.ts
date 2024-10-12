import { FastifyReply, FastifyRequest } from "fastify";
import jwt, { JwtPayload } from "jsonwebtoken";

// Define the interface for the user
interface DecodedToken extends JwtPayload {
  id: string;
  email: string;
}

export const authMiddleware = async (
  request: FastifyRequest,
  reply: FastifyReply
): Promise<boolean | void> => {
  try {
    const authHeader = request.headers.authorization;

    if (!authHeader) {
      return reply.status(401).send({
        "status": 401,
        "success": false,
        "message": "Authorization Header Missing"
    });
    }

    const token = authHeader.split(" ")[1];

    const decoded = jwt.verify(token, process.env.JWT_SECRET as string) as DecodedToken;

    // Attach decoded user information to the request object
    request.user = decoded;

    console.log("Success verifying JWT");
    return true;
  } catch (err) {
    return reply.status(401).send({ error: "Invalid token" });
  }
};
