import 'fastify';

declare module 'fastify' {
    interface FastifyRequest {
        user?: {
            id: string;
            email: string;
            // Add other properties that your JWT contains
        };
    }
}
