CREATE database movie_streaming_db;
USE movie_streaming_db;


CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status ENUM('active','suspended') DEFAULT 'active'
);

CREATE TABLE profiles (
  profile_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  name VARCHAR(100) NOT NULL,
  age_rating_preference VARCHAR(10) DEFAULT 'PG-13',
  avatar_url TEXT,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE plans (
  plan_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL,
  price_monthly DECIMAL(6,2) NOT NULL,
  max_streams INT NOT NULL,
  resolution VARCHAR(20)
);

CREATE TABLE subscriptions (
  subscription_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  plan_id INT,
  start_date DATE NOT NULL,
  end_date DATE,
  status ENUM('active','expired','cancelled') DEFAULT 'active',
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (plan_id) REFERENCES plans(plan_id) ON DELETE RESTRICT
);

CREATE TABLE movies (
  movie_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  release_date DATE,
  duration_minutes INT CHECK (duration_minutes > 0),
  language VARCHAR(50),
  age_rating VARCHAR(10),
  is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE genres (
  genre_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE movie_genres (
  movie_id INT,
  genre_id INT,
  PRIMARY KEY (movie_id, genre_id),
  FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
  FOREIGN KEY (genre_id) REFERENCES genres(genre_id) ON DELETE CASCADE
);

CREATE TABLE watch_history (
  watch_id INT AUTO_INCREMENT PRIMARY KEY,
  profile_id INT,
  movie_id INT,
  watched_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  position_seconds INT,
  completed BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (profile_id) REFERENCES profiles(profile_id) ON DELETE CASCADE,
  FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE
);

CREATE TABLE ratings (
  rating_id INT AUTO_INCREMENT PRIMARY KEY,
  profile_id INT,
  movie_id INT,
  rating INT CHECK (rating BETWEEN 1 AND 5),
  rated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (profile_id, movie_id),
  FOREIGN KEY (profile_id) REFERENCES profiles(profile_id) ON DELETE CASCADE,
  FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE
);

CREATE TABLE reviews (
  review_id INT AUTO_INCREMENT PRIMARY KEY,
  profile_id INT,
  movie_id INT,
  title VARCHAR(100),
  body TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (profile_id) REFERENCES profiles(profile_id) ON DELETE CASCADE,
  FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE
);

CREATE TABLE playlists (
  playlist_id INT AUTO_INCREMENT PRIMARY KEY,
  profile_id INT,
  name VARCHAR(100) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (profile_id) REFERENCES profiles(profile_id) ON DELETE CASCADE
);

CREATE TABLE playlist_movies (
  playlist_id INT,
  movie_id INT,
  added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (playlist_id, movie_id),
  FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id) ON DELETE CASCADE,
  FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE
);

SHOW TABLES;