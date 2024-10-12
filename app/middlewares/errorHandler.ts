import { FastifyReply, FastifyRequest } from "fastify";

// Define a custom error type that extends the Error class
interface CustomError extends Error {
    statusCode?: number;
}

// Custom error handler
const errorHandler = (error: CustomError, request: FastifyRequest, reply: FastifyReply) => {
    console.log('Error inside errorHandler: ', error)
    const statusCode = error.statusCode || 500;

    const response = {
        statusCode,
        error: error.message,
        ...(process.env.NODE_ENV === 'development' && { stack: error.stack }),
    };

    return reply.status(statusCode).send(response);
};

export default errorHandler;
