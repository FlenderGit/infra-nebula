CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- table
CREATE TABLE users (
    id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    username        VARCHAR(50)  NOT NULL UNIQUE,
    slug            VARCHAR(50)  NOT NULL UNIQUE,
    created_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    deleted_at      TIMESTAMPTZ
);

CREATE TABLE messages (
    id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    author_id       UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    body            TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE media (
    id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    uploader_id     UUID        NOT NULL REFERENCES users(id) ON DELETE SET NULL,
    key             VARCHAR(255) NOT NULL,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


-- relations
CREATE TABLE follows (
    follower_id     UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    following_id    UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (follower_id, following_id),
    CHECK (follower_id <> following_id)
);

CREATE TABLE message_media (
    message_id      UUID        NOT NULL REFERENCES messages(id) ON DELETE CASCADE,
    media_id        UUID        NOT NULL REFERENCES media(id)    ON DELETE CASCADE,
    PRIMARY KEY (message_id, media_id)
);
