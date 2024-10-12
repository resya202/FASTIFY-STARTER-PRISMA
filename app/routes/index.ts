import fastify from "fastify";
import { authRoutes } from "./authRoutes";


async function routes(fastify: any, options: any) {
    fastify.register(authRoutes, { prefix: '/auth' });
}

export default routes