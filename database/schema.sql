-- Robotic-Mind Database Schema
-- SQL script to initialize the database

-- Users Table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Conversations Table
CREATE TABLE conversations (
    conversation_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Messages Table
CREATE TABLE messages (
    message_id INT PRIMARY KEY AUTO_INCREMENT,
    conversation_id INT NOT NULL,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    message_type ENUM('user', 'ai') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (conversation_id) REFERENCES conversations(conversation_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Emotions Table
CREATE TABLE emotions (
    emotion_id INT PRIMARY KEY AUTO_INCREMENT,
    message_id INT NOT NULL,
    emotion_type VARCHAR(50),
    confidence_score FLOAT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (message_id) REFERENCES messages(message_id) ON DELETE CASCADE
);

-- User Preferences Table
CREATE TABLE user_preferences (
    preference_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL UNIQUE,
    language VARCHAR(10) DEFAULT 'en',
    tone_preference VARCHAR(50),
    notification_enabled BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Ideas Table
CREATE TABLE ideas (
    idea_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    ai_suggestions TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Create indexes for better query performance
CREATE INDEX idx_user_id ON conversations(user_id);
CREATE INDEX idx_conversation_id ON messages(conversation_id);
CREATE INDEX idx_message_id ON emotions(message_id);
CREATE INDEX idx_user_preferences ON user_preferences(user_id);
