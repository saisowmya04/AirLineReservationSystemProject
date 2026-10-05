-- insert an admin
INSERT INTO users(username, password, role)
VALUES ('admin', 'admin123', 'ADMIN');

-- insert normal user
INSERT INTO users(username, password, role)
VALUES ('sowmya', 'user123', 'USER');

select * from users;