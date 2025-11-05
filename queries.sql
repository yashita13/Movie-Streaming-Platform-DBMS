SELECT
    u.email,
    p.name AS plan_name,
    s.start_date
FROM users u
INNER JOIN subscriptions s ON u.user_id = s.user_id
INNER JOIN plans p ON s.plan_id = p.plan_id
WHERE s.status = 'active';

SELECT
    m.title,
    COUNT(w.watch_id) AS times_completed
FROM movies m
LEFT JOIN watch_history w ON m.movie_id = w.movie_id AND w.completed = TRUE
GROUP BY m.title
ORDER BY times_completed DESC;

SELECT
    g.name AS genre,
    m.title
FROM movie_genres mg
RIGHT JOIN genres g ON mg.genre_id = g.genre_id
LEFT JOIN movies m ON mg.movie_id = m.movie_id
ORDER BY g.name;

SELECT
    u.email,
    p1.name AS profile1_name,
    p2.name AS profile2_name
FROM profiles p1
INNER JOIN profiles p2 ON p1.user_id = p2.user_id AND p1.profile_id < p2.profile_id
INNER JOIN users u ON p1.user_id = u.user_id;


SELECT
    p.name AS profile_name,
    g.name AS genre_to_recommend
FROM profiles p
CROSS JOIN genres g
ORDER BY p.name, g.name;


SELECT email
FROM users
WHERE user_id IN (
    SELECT user_id
    FROM subscriptions
    WHERE plan_id IN (
        SELECT plan_id
        FROM plans
        WHERE price_monthly > 500.00
    )
);

SELECT title, release_date
FROM movies
WHERE movie_id NOT IN (
    SELECT DISTINCT movie_id
    FROM ratings
);


SELECT email
FROM users u
WHERE EXISTS (
    SELECT 1
    FROM profiles p
    JOIN reviews r ON p.profile_id = r.profile_id
    WHERE p.user_id = u.user_id
);


SELECT DISTINCT m.title
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id
WHERE r.rating > ANY (
    -- This subquery now finds all ratings for movies classified as 'Drama'
    SELECT r_inner.rating
    FROM ratings r_inner
    JOIN movie_genres mg ON r_inner.movie_id = mg.movie_id
    JOIN genres g ON mg.genre_id = g.genre_id
    WHERE g.name = 'Drama'
);


SELECT m.title, r.rating
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id
WHERE r.rating >= ALL (
    SELECT rating FROM ratings
);


SELECT
    m.title,
    AVG(r.rating) AS average_rating
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id
GROUP BY m.title
HAVING AVG(r.rating) >= 4.5
ORDER BY average_rating DESC;


SELECT
    s.status,
    COUNT(p.profile_id) AS number_of_profiles
FROM subscriptions s
JOIN users u ON s.user_id = u.user_id
JOIN profiles p ON u.user_id = p.user_id
GROUP BY s.status;


SELECT
    u.email
FROM users u
JOIN profiles p ON u.user_id = p.user_id
JOIN subscriptions s ON u.user_id = s.user_id
JOIN plans pl ON s.plan_id = pl.plan_id
WHERE s.status = 'active' AND pl.name = 'Standard HD'
GROUP BY u.email
HAVING COUNT(p.profile_id) > 1;



SELECT
    g.name AS genre,
    SUM(m.duration_minutes) AS total_minutes_watched
FROM genres g
JOIN movie_genres mg ON g.genre_id = mg.genre_id
JOIN movies m ON mg.movie_id = m.movie_id
JOIN watch_history wh ON m.movie_id = wh.movie_id
WHERE wh.completed = TRUE
GROUP BY g.name
ORDER BY total_minutes_watched DESC;


SELECT
    g.name AS genre,
    AVG(m.duration_minutes) as avg_duration
FROM genres g
JOIN movie_genres mg ON g.genre_id = mg.genre_id
JOIN movies m ON mg.movie_id = m.movie_id
GROUP BY g.name
ORDER BY avg_duration DESC
LIMIT 1;


SELECT DISTINCT m.title
FROM movies m
WHERE m.movie_id IN (
    SELECT wh.movie_id
    FROM watch_history wh
    WHERE wh.profile_id IN (
        SELECT p.profile_id
        FROM profiles p
        WHERE p.user_id = (
            SELECT u.user_id
            FROM users u
            WHERE u.email = 'priya.patel@example.com'
        )
    )
);


SELECT u.email, s1.start_date, s1.status
FROM users u
JOIN subscriptions s1 ON u.user_id = s1.user_id
WHERE s1.start_date = (
    SELECT MAX(s2.start_date)
    FROM subscriptions s2
    WHERE s2.user_id = s1.user_id
);


SELECT m1.title, m1.release_date, r.rating
FROM movies m1
JOIN ratings r ON m1.movie_id = r.movie_id
WHERE r.rating > (
    SELECT AVG(r2.rating)
    FROM ratings r2
    JOIN movies m2 ON r2.movie_id = m2.movie_id
    WHERE YEAR(m2.release_date) = YEAR(m1.release_date)
);


SELECT m1.title, m1.release_date, r.rating
FROM movies m1
JOIN ratings r ON m1.movie_id = r.movie_id
WHERE r.rating > (
    SELECT AVG(r2.rating)
    FROM ratings r2
    JOIN movies m2 ON r2.movie_id = m2.movie_id
    WHERE YEAR(m2.release_date) != YEAR(m1.release_date)
);


SELECT p.name
FROM playlists p
WHERE EXISTS (
    SELECT 1
    FROM playlist_movies pm
    JOIN movie_genres mg ON pm.movie_id = mg.movie_id
    JOIN genres g ON mg.genre_id = g.genre_id
    WHERE pm.playlist_id = p.playlist_id AND g.name = 'Action'
);


SELECT g.name AS genre, m.title, m.duration_minutes
FROM genres g
JOIN movie_genres mg ON g.genre_id = mg.genre_id
JOIN movies m ON mg.movie_id = m.movie_id
WHERE m.duration_minutes = (
    SELECT MAX(m2.duration_minutes)
    FROM movies m2
    JOIN movie_genres mg2 ON m2.movie_id = mg2.movie_id
    WHERE mg2.genre_id = g.genre_id
);


SELECT
    m.title AS user_favorites
FROM movies m
WHERE m.movie_id IN (
    SELECT r.movie_id
    FROM ratings r
    WHERE r.rating >= 4 AND r.profile_id IN (
        SELECT p.profile_id
        FROM profiles p
        WHERE p.user_id = 1
    )
)
UNION
SELECT
    pl.name AS user_favorites
FROM playlists pl
WHERE pl.profile_id IN (
    SELECT p.profile_id
    FROM profiles p
    WHERE p.user_id = 1
);


SELECT m.title
FROM movies m
WHERE m.movie_id IN (
    SELECT mg.movie_id
    FROM movie_genres mg
    JOIN genres g ON mg.genre_id = g.genre_id
    WHERE g.name = 'Drama'
) AND m.movie_id IN (
    SELECT mg.movie_id
    FROM movie_genres mg
    JOIN genres g ON mg.genre_id = g.genre_id
    WHERE g.name = 'Comedy'
);


SELECT m.title
FROM movies m
JOIN movie_genres mg ON m.movie_id = mg.movie_id
JOIN genres g ON mg.genre_id = g.genre_id
WHERE g.name = 'Action'
AND m.movie_id NOT IN (
    SELECT pm.movie_id
    FROM playlist_movies pm
    JOIN playlists p ON pm.playlist_id = p.playlist_id
    WHERE p.name = '90s Classics'
);


SELECT
    u.email,
    'Status: Engaged High-Value Customer' AS report_reason,
    p.name AS plan_name,
    p.price_monthly
FROM users u
JOIN subscriptions s ON u.user_id = s.user_id
JOIN plans p ON s.plan_id = p.plan_id
WHERE
    p.price_monthly > 400.00
    AND s.status = 'active'
    AND u.user_id IN (
        SELECT DISTINCT p.user_id
        FROM profiles p
        JOIN watch_history wh ON p.profile_id = wh.profile_id
        WHERE wh.watched_at >= CURDATE() - INTERVAL 90 DAY
    )
UNION ALL
SELECT
    u.email,
    'Risk: Suspended Account with Non-Renewing Plan' AS report_reason,
    p.name AS plan_name,
    p.price_monthly
FROM users u
JOIN subscriptions s ON u.user_id = s.user_id
JOIN plans p ON s.plan_id = p.plan_id
WHERE
    u.status = 'suspended'
    AND s.status = 'cancelled';



WITH HighlyRatedMovies AS (
    SELECT movie_id, AVG(rating) AS avg_rating
    FROM ratings
    GROUP BY movie_id
    HAVING AVG(rating) > 4.0
)
SELECT
    m.title,
    g.name AS genre
FROM movies m
JOIN HighlyRatedMovies hrm ON m.movie_id = hrm.movie_id
JOIN movie_genres mg ON m.movie_id = mg.movie_id
JOIN genres g ON mg.genre_id = g.genre_id
ORDER BY m.title;


SELECT
    m.title,
    g.name AS genre,
    m.release_date,
    RANK() OVER (PARTITION BY g.name ORDER BY m.release_date DESC) as date_rank
FROM movies m
JOIN movie_genres mg ON m.movie_id = mg.movie_id
JOIN genres g ON mg.genre_id = g.genre_id;


SELECT
    m.title,
    r.rating,
    AVG(r.rating) OVER (PARTITION BY m.title) AS movie_average_rating
FROM ratings r
JOIN movies m ON r.movie_id = m.movie_id
ORDER BY m.title;


WITH RankedMovies AS (
    SELECT
        m.title,
        g.name AS genre,
        m.duration_minutes,
        ROW_NUMBER() OVER(PARTITION BY g.name ORDER BY m.duration_minutes DESC) as rn
    FROM movies m
    JOIN movie_genres mg ON m.movie_id = mg.movie_id
    JOIN genres g ON mg.genre_id = g.genre_id
)
SELECT title, genre, duration_minutes
FROM RankedMovies
WHERE rn <= 3;


SELECT
    m.title,
    wh.watched_at,
    LAG(m.title, 1, 'N/A') OVER (ORDER BY wh.watched_at) AS previous_movie,
    LEAD(m.title, 1, 'N/A') OVER (ORDER BY wh.watched_at) AS next_movie
FROM watch_history wh
JOIN movies m ON wh.movie_id = m.movie_id
WHERE wh.profile_id = 1 -- Assuming we are checking for the profile with ID 1
ORDER BY wh.watched_at;



WITH MonthlyRevenue AS (
    SELECT
        DATE_FORMAT(start_date, '%Y-%m-01') AS month,
        SUM(p.price_monthly) as monthly_total
    FROM subscriptions s
    JOIN plans p ON s.plan_id = p.plan_id
    WHERE p.name = 'Standard HD'
    GROUP BY month
)
SELECT
    month,
    monthly_total,
    SUM(monthly_total) OVER (ORDER BY month) AS running_total_revenue
FROM MonthlyRevenue;
