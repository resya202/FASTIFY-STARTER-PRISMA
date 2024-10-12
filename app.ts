import dotenv from 'dotenv';
dotenv.config();
import Fastify from "fastify"
import FastifyCors from "@fastify/cors"
import fastifyStatic from "@fastify/static"
import errorHandler from 'app/middlewares/errorHandler';
import routes from 'app/routes';
import rateLimit from '@fastify/rate-limit';

const server = Fastify({
    logger: false
})

server.register(rateLimit,{
    max:100,
    timeWindow:'1 minute'
})

server.register(FastifyCors, {
    origin: "*",
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    allowedHeaders: ['Content-Type', 'Authorization']
})

// Set global error handler
// server.setErrorHandler(errorHandler);

server.get("/health-check", (request, reply) => {
    return reply.status(200).send({
        message: "Hi, Server is up and running.",
    })
})

// ------------------------- Routes & Path --------------------
server.register(routes)
// ------------------------- Starters -------------------------

const startEngine = async () => {
    try {
        const port = Number(process.env.APP_PORT) || 3980

        console.log(`Starting server on: http://localhost:${port}`)
        await server.listen({
            port,
            host: "0.0.0.0"
        })

    } catch (error) {
        console.log('Error starting erver: ', error)
        process.exit(1)
    }
}

startEngine()