CREATE TYPE "Difficulty" AS ENUM ('EASY', 'MEDIUM', 'HARD');
CREATE TYPE "SessionStatus" AS ENUM ('COMPLETED', 'INVALID', 'INCOMPLETE');

CREATE TABLE "User" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" VARCHAR(100) NOT NULL,
    "email" VARCHAR(100) NOT NULL,
    "password" VARCHAR(100) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "Language" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" VARCHAR(100) NOT NULL,
    "slug" VARCHAR(100) NOT NULL,
    "icon" VARCHAR(100),

    CONSTRAINT "Language_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "Snippet" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "languageId" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "difficulty" "Difficulty" NOT NULL,
    "specialCharacters" BOOLEAN NOT NULL DEFAULT false,
    "tags" TEXT[],
    "source" TEXT NOT NULL DEFAULT 'seed',
    "sourceUrl" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Snippet_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "Snippet_languageId_fkey" FOREIGN KEY ("languageId") 
        REFERENCES "Language"("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE "TypingSession" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "userId" UUID NOT NULL,
    "snippetId" UUID NOT NULL,
    "wpm" DOUBLE PRECISION NOT NULL,
    "cpm" DOUBLE PRECISION NOT NULL,
    "precision" DOUBLE PRECISION NOT NULL,
    "totalErrors" INTEGER NOT NULL,
    "difficultKeys" TEXT[],
    "status" "SessionStatus" NOT NULL,
    "archived" BOOLEAN NOT NULL DEFAULT false,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TypingSession_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "TypingSession_userId_fkey" FOREIGN KEY ("userId") 
        REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "TypingSession_snippetId_fkey" FOREIGN KEY ("snippetId") 
        REFERENCES "Snippet"("id") ON DELETE RESTRICT ON UPDATE CASCADE
);