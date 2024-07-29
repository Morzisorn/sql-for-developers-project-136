CREATE TABLE Programs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    price INT NOT NULL,
    type VARCHAR(255) NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    program_id BIGINT NOT NULL REFERENCES Programs(id)
);

CREATE TABLE ProgramModules (
    PRIMARY KEY (program_id, module_id),
    program_id BIGINT NOT NULL REFERENCES Programs(id),
    module_id BIGINT NOT NULL REFERENCES Modules(id)
);

CREATE TABLE Courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE CourseModules (
    PRIMARY KEY (course_id, module_id),
    module_id BIGINT NOT NULL REFERENCES Modules(id),
    course_id BIGINT NOT NULL REFERENCES Courses(id)
);

CREATE TABLE Lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    course_id BIGINT NOT NULL REFERENCES Courses(id),
    name VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    video_link VARCHAR(255),
    lesson_position INT NOT NULL,
    is_deleted BOOLEAN,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE TeachingGroups (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slag VARCHAR(255) NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Users (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    teachingGroup_id BIGINT NOT NULL REFERENCES TeachingGroups(id),
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE payment_status AS ENUM ('pending', 'paid', 'failed', 'refunded');

CREATE TABLE Enrollments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT NOT NULL REFERENCES Users(id),
    program_id BIGINT NOT NULL REFERENCES Programs(id),
    status payment_status NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Payments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    price INT NOT NULL,
    status payment_status NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE completion_status AS ENUM ('active', 'completed', 'pending', 'cancelled');
CREATE TABLE ProgramCompletions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT NOT NULL REFERENCES Users(id),
    program_id BIGINT NOT NULL REFERENCES Programs(id),
    status completion_status NOT NULL,
    start_date TIMESTAMP,
    finish_date TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Certificates (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT NOT NULL REFERENCES Users(id),
    program_id BIGINT NOT NULL REFERENCES Programs(id),
    url VARCHAR(255),
    certificate_date TIMESTAMP NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Quizzes (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    lesson_id BIGINT NOT NULL REFERENCES Lessons(id),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Exercises (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT NOT NULL REFERENCES Lessons(id),
    url VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Discussions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT NOT NULL REFERENCES Lessons(id),
    comment TEXT NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE article_status AS ENUM ('created', 'in moderation', 'published', 'archived');
CREATE TABLE Blog (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT NOT NULL REFERENCES Users(id),
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    status article_status NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP

);

