INSERT INTO users (email, password_hash, status) VALUES
('rohan.sharma@example.com', 'hash123_rohan', 'active'),
('priya.patel@example.com', 'hash456_priya', 'active'),
('vikram.singh@example.com', 'hash789_vikram', 'suspended'),
('aisha.khan@example.com', 'hash101_aisha', 'active'),
('arjun.mehta@example.com', 'hash112_arjun', 'active');


INSERT INTO plans (name, price_monthly, max_streams, resolution) VALUES
('Basic Mobile', 199.00, 1, '480p'),
('Standard HD', 499.00, 2, '1080p'),
('Premium 4K', 799.00, 4, '4K+HDR'),
('Family Plan', 649.00, 4, '1080p'),
('Student Offer', 149.00, 1, '720p');


INSERT INTO subscriptions (user_id, plan_id, start_date, end_date, status) VALUES
(1, 2, '2025-01-15', NULL, 'active'),
(2, 3, '2025-02-20', NULL, 'active'),
(3, 1, '2024-11-10', '2025-05-10', 'cancelled'),
(4, 4, '2025-03-01', NULL, 'active'),
(5, 2, '2024-08-05', '2025-08-04', 'expired');


INSERT INTO profiles (user_id, name, age_rating_preference, avatar_url) VALUES
(1, 'Rohan Main', 'PG-13', 'http://example.com/avatars/rohan.jpg'),
(1, 'Rohan Kids', 'G', 'http://example.com/avatars/rohan_kids.jpg'),
(2, 'Priya', 'R', 'http://example.com/avatars/priya.jpg'),
(4, 'Aisha Movies', 'PG-13', 'http://example.com/avatars/aisha.jpg'),
(5, 'Arjun Watch', 'G', 'http://example.com/avatars/arjun.jpg');


INSERT INTO genres (name) VALUES
('Action'),
('Romance'),
('Comedy'),
('Drama'),
('Thriller');


INSERT INTO movies (title, description, release_date, duration_minutes, language, age_rating, is_active) VALUES
('3 Idiots', 'Two friends are searching for their long lost companion. They revisit their college days and recall the memories of their friend who inspired them to think differently.', '2009-12-25', 170, 'Hindi', 'PG-13', TRUE),
('Lagaan', 'The people of a small village in Victorian India stake their future on a game of cricket against their ruthless British rulers.', '2001-06-15', 224, 'Hindi', 'PG', TRUE),
('Dilwale Dulhania Le Jayenge', 'When Raj meets Simran in Europe, it isn`t love at first sight but when Simran moves to India for an arranged marriage, love strikes.', '1995-10-20', 189, 'Hindi', 'G', TRUE),
('Andhadhun', 'A series of mysterious events change the life of a blind pianist, who must now report a crime that he should technically know nothing of.', '2018-10-05', 139, 'Hindi', 'R', TRUE),
('Gangs of Wasseypur', 'A clash between Sultan and Shahid Khan leads to the expulsion of Khan from Wasseypur, and ignites a deadly blood feud spanning three generations.', '2012-06-22', 321, 'Hindi', 'R', TRUE);


INSERT INTO movie_genres (movie_id, genre_id) VALUES
(1, 3), -- 3 Idiots -> Comedy
(1, 4), -- 3 Idiots -> Drama
(2, 4), -- Lagaan -> Drama
(3, 2), -- DDLJ -> Romance
(5, 1), -- Gangs of Wasseypur -> Action
(5, 5); -- Gangs of Wasseypur -> Thriller


INSERT INTO watch_history (profile_id, movie_id, position_seconds, completed) VALUES
(1, 1, 7200, TRUE),   -- Rohan Main watched 3 Idiots
(2, 3, 3600, FALSE),  -- Priya watched DDLJ
(3, 2, 8400, TRUE),   -- Priya watched Lagaan
(4, 4, 1200, FALSE),  -- Aisha watched Andhadhun
(1, 5, 9000, FALSE);  -- Rohan Main watched Gangs of Wasseypur


INSERT INTO ratings (profile_id, movie_id, rating) VALUES
(1, 1, 5),   -- Rohan Main rated 3 Idiots
(2, 3, 5),   -- Priya rated DDLJ
(3, 2, 4),   -- Priya rated Lagaan
(4, 4, 5),   -- Aisha rated Andhadhun
(1, 2, 4);   -- Rohan Main rated Lagaan


INSERT INTO reviews (profile_id, movie_id, title, body) VALUES
(1, 1, 'An absolute masterpiece!', 'One of the best movies ever made about the education system. A must watch!'),
(2, 3, 'Classic Bollywood Romance', 'Shah Rukh Khan and Kajol are iconic. The story is timeless.'),
(3, 2, 'Inspirational and Epic', 'A gripping story of courage and determination. The cricket match was legendary.'),
(4, 4, 'Mind-bending thriller', 'Kept me on the edge of my seat until the very end. The plot twists are incredible.'),
(1, 5, 'A Gritty Saga', 'Raw, powerful, and unforgettable. A very realistic portrayal of crime and power struggles.');


INSERT INTO playlists (profile_id, name) VALUES
(1, 'Weekend Binge'),
(2, '90s Classics'),
(4, 'My Top Thrillers'),
(1, 'Feel Good Movies'),
(5, 'Family Movie Night');


INSERT INTO playlist_movies (playlist_id, movie_id) VALUES
(1, 1), -- Add '3 Idiots' to 'Weekend Binge'
(1, 5), -- Add 'Gangs of Wasseypur' to 'Weekend Binge'
(2, 3), -- Add 'DDLJ' to '90s Classics'
(3, 4), -- Add 'Andhadhun' to 'My Top Thrillers'
(4, 1); -- Add '3 Idiots' to 'Feel Good Movies'
