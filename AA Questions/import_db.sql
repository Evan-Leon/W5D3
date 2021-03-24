PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    users_id INTEGER NOT NULL,
    FOREIGN KEY(users_id) REFERENCES users(id) 
);

CREATE TABLE questions_follows (
    id INTEGER PRIMARY KEY,
    users_id INTEGER NOT NULL,
    questions_id INTEGER NOT NULL,
    FOREIGN KEY(users_id) REFERENCES users(id),
    FOREIGN KEY (questions_id) REFERENCES questions(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    users_id INTEGER NOT NULL,
    questions_id INTEGER NOT NULL,
    FOREIGN KEY(users_id) REFERENCES users(id),
    FOREIGN KEY (questions_id) REFERENCES questions(id)
);

CREATE TABLE questions_likes (
    id INTEGER PRIMARY KEY,
    likes BOOLEAN NOT NULL,
    questions_id INTEGER NOT NULL,
    users_id INTEGER NOT NULL,
    FOREIGN KEY (questions_id) REFERENCES questions(id),
    FOREIGN KEY(users_id) REFERENCES users(id)
);

INSERT INTO
  users (fname, lname)
VALUES
    ('Sebastian', 'Sanchez'),
    ('Evan', 'Leon');

INSERT INTO
  questions (title, body, users_id)
VALUES
    ('Sebastian', 'Sanchez', 1),
    ('Evan', 'Leon', 2);

INSERT INTO
  questions_follows (users_id, questions_id)
VALUES
    (1, 2),
    (2, 1);

INSERT INTO
  replies (body, users_id, questions_id)
VALUES
    ('Sebastian', 1, 2),
    ('Evan', 2, 1);


INSERT INTO
  questions_likes (likes, questions_id, users_id)
VALUES
    (true, 1, 2),
    (true, 2, 1);

 



