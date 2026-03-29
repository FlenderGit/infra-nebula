CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Users
INSERT INTO users (username, slug) VALUES
    ('alice',   'alice'),
    ('bob',     'bob'),
    ('charlie', 'charlie');

-- Messages (on récupère les ids via subquery)
INSERT INTO messages (author_id, body) VALUES
    ((SELECT id FROM users WHERE slug = 'alice'),   'Hello everyone!'),
    ((SELECT id FROM users WHERE slug = 'alice'),   'Check out this photo'),
    ((SELECT id FROM users WHERE slug = 'bob'),     'Hey Alice!'),
    ((SELECT id FROM users WHERE slug = 'charlie'), 'First post here');

-- Media
INSERT INTO media (uploader_id, key) VALUES
    ((SELECT id FROM users WHERE slug = 'alice'), 'media/abc-123/photo1.jpg'),
    ((SELECT id FROM users WHERE slug = 'alice'), 'media/def-456/photo2.jpg'),
    ((SELECT id FROM users WHERE slug = 'bob'),   'media/ghi-789/avatar.png');

-- Follows
INSERT INTO follows (follower_id, following_id) VALUES
    ((SELECT id FROM users WHERE slug = 'alice'),   (SELECT id FROM users WHERE slug = 'bob')),
    ((SELECT id FROM users WHERE slug = 'alice'),   (SELECT id FROM users WHERE slug = 'charlie')),
    ((SELECT id FROM users WHERE slug = 'bob'),     (SELECT id FROM users WHERE slug = 'alice')),
    ((SELECT id FROM users WHERE slug = 'charlie'), (SELECT id FROM users WHERE slug = 'alice'));

-- Message <-> Media
INSERT INTO message_media (message_id, media_id) VALUES
    (
        (SELECT id FROM messages WHERE body = 'Check out this photo'),
        (SELECT id FROM media WHERE key = 'media/abc-123/photo1.jpg')
    ),
    (
        (SELECT id FROM messages WHERE body = 'Check out this photo'),
        (SELECT id FROM media WHERE key = 'media/def-456/photo2.jpg')
    );
