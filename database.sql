CREATE TABLE Programs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    price INT,
    type VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    description TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    program_id BIGINT NOT NULL REFERENCES Programs(id)
);


CREATE TABLE Courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    description TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Modules_Courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    module_id BIGINT NOT NULL REFERENCES Modules(id),
    course_id BIGINT NOT NULL REFERENCES Courses(id)
);

CREATE TABLE Lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    course_id BIGINT REFERENCES Courses(id),
    name VARCHAR(255),
    content TEXT,
    video_link VARCHAR(255),
    lesson_position INT,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE TeachingGroups (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slag VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Users (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    teachingGroup_id BIGINT REFERENCES TeachingGroups(id),
    name VARCHAR(255),
    email VARCHAR(255),
    password_hash VARCHAR(255),
    role VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE payment_status AS ENUM ('pending', 'paid', 'failed', 'refunded');

CREATE TABLE Enrollments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES Users(id),
    program_id BIGINT REFERENCES Programs(id),
    status payment_status,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Payments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    price INT,
    status payment_status,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE completion_status AS ENUM ('active', 'completed', 'pending', 'cancelled');
CREATE TABLE ProgramCompletions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES Users(id),
    program_id BIGINT REFERENCES Programs(id),
    status completion_status,
    start_date TIMESTAMP,
    finish_date TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Certificates (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES Users(id),
    program_id BIGINT REFERENCES Programs(id),
    url VARCHAR(255),
    certificate_date TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Quizzes (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    content TEXT,
    lesson_id BIGINT REFERENCES Lessons(id),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Exercises (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT REFERENCES Lessons(id),
    url VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);


