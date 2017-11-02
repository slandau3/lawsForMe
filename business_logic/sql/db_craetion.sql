CREATE TABLE role_permission (
  id SERIAL PRIMARY KEY,
  comment_permission int NOT NULL,
  view_permission int NOT NULL
);

CREATE TABLE role (
  id SERIAL PRIMARY KEY,
  level int REFERENCES role_permission(id)
);



CREATE TABLE "user" (
  id uuid PRIMARY KEY,
  username VARCHAR(20) UNIQUE NOT NULL,
  first_name VARCHAR(20),
  last_name VARCHAR(20),
  password VARCHAR(100) NOT NULL, -- Can be null if social login is used
  created_at TIMESTAMP NOT NULL DEFAULT now(),
  updated_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE address (
  id SERIAL PRIMARY KEY,
  street_1 VARCHAR(80),
  street_2 VARCHAR(80),
  city TEXT,
  state TEXT,
  belongs_to uuid REFERENCES "user"(id),
  created_at TIMESTAMP NOT NULL DEFAULT now(),
  updated_at TIMESTAMP NOT NULL DEFAULT now()
);


CREATE TABLE federal_law (
  id SERIAL PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT now(),
  updated_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE discussion (
  id SERIAL PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  thread_permission_req INT NOT NULL DEFAULT 0, -- permission level needed to create a thread
  created_at TIMESTAMP NOT NULL DEFAULT now(),
  updated_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE thread (
  id SERIAL PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  discussion_id INT NOT NULL REFERENCES discussion(id),
  comment_permission_req INT NOT NULL DEFAULT 0,
  view_permission_req INT NOT NULL DEFAULT 0,
  starter_text TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT now(),
  updated_at TIMESTAMP NOT NULL DEFAULT now()
);


CREATE TABLE forum_comment (
  id SERIAL PRIMARY KEY,
  author uuid REFERENCES "user"(id),
  content TEXT NOT NULL,
  thread_id INT NOT NULL REFERENCES thread(id),
  created_at TIMESTAMP NOT NULL DEFAULT now(),
  updated_at TIMESTAMP NOT NULL DEFAULT now()
);