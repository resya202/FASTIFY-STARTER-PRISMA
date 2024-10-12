import { PrismaClient as TransClient } from "generated/trans-client";
import { PrismaClient as CoreClient } from "generated/core-client";

export const prismaCore = new CoreClient();
export const prismaTrans = new TransClient();
