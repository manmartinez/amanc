
CREATE TABLE sponsors (
                id BIGINT AUTO_INCREMENT NOT NULL,
                name VARCHAR(100) NOT NULL,
                logo_filename VARCHAR(100),
                url VARCHAR(100) NOT NULL,
                credit DOUBLE PRECISION DEFAULT 0 NOT NULL,
                is_active TINYINT DEFAULT 1 NOT NULL,
                created_at DATETIME NOT NULL,
                updated_at DATETIME NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE banners (
                id BIGINT NOT NULL,
                url VARCHAR(150) NOT NULL,
                image_filename VARCHAR(100),
                sponsor_id BIGINT NOT NULL,
                created_at DATETIME NOT NULL,
                updated_at DATETIME NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE topics (
                id BIGINT AUTO_INCREMENT NOT NULL,
                name VARCHAR(150) NOT NULL,
                is_active INT DEFAULT 1 NOT NULL,
                created_at DATETIME NOT NULL,
                updated_at DATETIME NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE levels (
                id BIGINT AUTO_INCREMENT NOT NULL,
                level_number INT DEFAULT 0 NOT NULL,
                topic_id BIGINT NOT NULL,
                created_at DATETIME NOT NULL,
                updated_at DATETIME NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE questions (
                id BIGINT AUTO_INCREMENT NOT NULL,
                text VARCHAR(100) NOT NULL,
                topic_id BIGINT NOT NULL,
                level_id BIGINT NOT NULL,
                created_at DATETIME NOT NULL,
                updated_at DATETIME NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE answers (
                id BIGINT AUTO_INCREMENT NOT NULL,
                text VARCHAR(150) NOT NULL,
                question_id BIGINT NOT NULL,
                is_correct INT DEFAULT 0 NOT NULL,
                created_at DATETIME NOT NULL,
                updated_at DATETIME NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE users (
                id BIGINT AUTO_INCREMENT NOT NULL,
                name VARCHAR(100) NOT NULL,
                surname VARCHAR(100) NOT NULL,
                email VARCHAR(100) NOT NULL,
                encrypted_password VARCHAR(100) NOT NULL,
                is_active INT DEFAULT 1 NOT NULL,
                user_type INT NOT NULL,
                created_at DATETIME NOT NULL,
                updated_at DATETIME NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE players (
                id BIGINT AUTO_INCREMENT NOT NULL,
                user_id BIGINT NOT NULL,
                best_score INT DEFAULT 0 NOT NULL,
                best_level INT DEFAULT 0 NOT NULL,
                total_points INT DEFAULT 0 NOT NULL,
                created_at DATETIME NOT NULL,
                updated_at DATETIME NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE games (
                id BIGINT NOT NULL,
                player_id BIGINT,
                current_level_id BIGINT NOT NULL,
                score INT DEFAULT 0 NOT NULL,
                status INT DEFAULT 0 NOT NULL,
                created_at DATETIME NOT NULL,
                updated_at DATETIME NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE game_answers (
                id BIGINT AUTO_INCREMENT NOT NULL,
                game_id BIGINT NOT NULL,
                answer_id BIGINT NOT NULL,
                created_at DATETIME NOT NULL,
                updated_at DATETIME NOT NULL,
                PRIMARY KEY (id)
);


ALTER TABLE banners ADD CONSTRAINT sponsors_banners_fk
FOREIGN KEY (sponsor_id)
REFERENCES sponsors (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE questions ADD CONSTRAINT topics_questions_fk
FOREIGN KEY (topic_id)
REFERENCES topics (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE levels ADD CONSTRAINT topics_levels_fk
FOREIGN KEY (topic_id)
REFERENCES topics (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE questions ADD CONSTRAINT levels_questions_fk
FOREIGN KEY (level_id)
REFERENCES levels (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE games ADD CONSTRAINT levels_games_fk
FOREIGN KEY (current_level_id)
REFERENCES levels (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE answers ADD CONSTRAINT questions_answers_fk
FOREIGN KEY (question_id)
REFERENCES questions (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE game_answers ADD CONSTRAINT answers_game_answers_fk
FOREIGN KEY (answer_id)
REFERENCES answers (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE players ADD CONSTRAINT users_players_fk
FOREIGN KEY (user_id)
REFERENCES users (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE games ADD CONSTRAINT players_games_fk
FOREIGN KEY (player_id)
REFERENCES players (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE game_answers ADD CONSTRAINT games_game_answers_fk
FOREIGN KEY (game_id)
REFERENCES games (id)
ON DELETE CASCADE
ON UPDATE CASCADE;
