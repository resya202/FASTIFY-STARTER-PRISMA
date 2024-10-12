import fastify, { FastifyInstance, FastifyPluginOptions, FastifyReply, FastifyRequest } from "fastify";
import jwt from "jsonwebtoken";
import bcryptjs from "bcryptjs"

interface UserInfo {
    name: string;
    address: string;
    mobileNumber: string;
    email: string;
    password: string;
}
interface LoginRequest {
    email: string;
    password: string
}

interface ChangePasswordRequest {
    oldPassword: string;
    newPassword: string;
}

export async function authRoutes(fastify: FastifyInstance, options: FastifyPluginOptions) {
    fastify.post("/login", async (req: FastifyRequest, reply: FastifyReply) => {
        console.log('Masuk pak eko')
    });

    fastify.post("/register", async (req: FastifyRequest, reply: FastifyReply) => {
        console.log('Lu mau register yah')
    });

}
