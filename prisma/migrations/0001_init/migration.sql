-- Enable UUID generation extension (safe if already present)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Enums
DO $$ BEGIN
  CREATE TYPE source_type AS ENUM ('rss', 'api');
EXCEPTION
  WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
  CREATE TYPE log_type AS ENUM ('ingestion', 'analysis', 'digest', 'error');
EXCEPTION
  WHEN duplicate_object THEN null;
END $$;

-- Tables
CREATE TABLE IF NOT EXISTS "Source" (
  "id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  "name" TEXT NOT NULL,
  "type" source_type NOT NULL,
  "url" TEXT NOT NULL,
  "isActive" BOOLEAN NOT NULL DEFAULT TRUE,
  "createdAt" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS "Article" (
  "id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  "sourceId" UUID NOT NULL,
  "title" TEXT NOT NULL,
  "url" TEXT NOT NULL,
  "publishedAt" TIMESTAMPTZ NOT NULL,
  "content" TEXT NOT NULL,
  "lang" TEXT NOT NULL,
  "sports" TEXT[] NOT NULL,
  "teams" TEXT[] NOT NULL,
  "countries" TEXT[] NOT NULL,
  "sentiment" DOUBLE PRECISION NULL,
  "hash" TEXT NOT NULL,
  "createdAt" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT "Article_sourceId_fkey" FOREIGN KEY ("sourceId") REFERENCES "Source"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT "Article_hash_unique" UNIQUE ("hash")
);

CREATE TABLE IF NOT EXISTS "TrendDay" (
  "id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  "date" DATE NOT NULL,
  "sport" TEXT NOT NULL,
  "score" DOUBLE PRECISION NOT NULL,
  "topArticleIds" TEXT[] NOT NULL,
  "createdAt" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS "TrendDay_date_sport_idx" ON "TrendDay" ("date", "sport");

CREATE TABLE IF NOT EXISTS "Digest" (
  "id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  "date" DATE NOT NULL UNIQUE,
  "html" TEXT NOT NULL,
  "md" TEXT NOT NULL,
  "lang" TEXT NOT NULL,
  "createdAt" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS "Log" (
  "id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  "timestamp" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "type" log_type NOT NULL,
  "message" TEXT NOT NULL
);
