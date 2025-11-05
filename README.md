# 🎬 Movie Streaming Platform DBMS Project

### 📘 Overview

This is a **Database Management System (DBMS)** project designed for academic submission. It simulates the backend data model for a **Movie Streaming Platform** and demonstrates a comprehensive understanding of relational database design and advanced SQL.

The complete project documentation, including the full schema, data insertion scripts, and all 30 advanced SQL queries with their outputs, can be found in the PDF report linked below.

---

## 📄 Full Project Report

The complete documentation for this project is available in the PDF file. This includes:

-   Database Schema Design
-   Data Insertion Scripts
-   All 30 Advanced SQL Queries with Screenshots of their Outputs

### ➡️ [Click here to view the Full Project Report (PDF)](./pdf_Movie_Streaming_Platform_Project.pdf)

---

## 🧩 Database Schema Design and ER Diagram

### Schema Philosophy

The schema is logically divided into three core areas:
1.  **User Management:** Tables like `users`, `profiles`, `plans`, and `subscriptions` manage user accounts and billing.
2.  **Content Catalog:** `movies`, `genres`, and the `movie_genres` junction table manage the movie library and its metadata.
3.  **User Interaction:** `watch_history`, `ratings`, `reviews`, and `playlists` track how users interact with the content on the platform.

### Table Descriptions

| Table             | Description                                                                 |
| ----------------- | --------------------------------------------------------------------------- |
| `users`           | Stores core user account credentials and status.                            |
| `profiles`        | Manages individual user profiles under a single account.                    |
| `plans`           | Defines the available subscription plans (e.g., Basic, Premium 4K).         |
| `subscriptions`   | Tracks the relationship between a user and their chosen plan.               |
| `movies`          | Contains all metadata for movies, such as title, duration, and release date.|
| `genres`          | A lookup table for movie genres (e.g., Action, Romance).                    |
| `movie_genres`    | Junction table for the many-to-many relationship between movies and genres. |
| `watch_history`   | Logs the viewing activity for each profile.                                 |
| `ratings`         | Stores the 1-5 star ratings given by a profile to a movie.                  |
| `reviews`         | Stores detailed text reviews written by profiles for movies.                |
| `playlists`       | Allows profiles to create named collections of movies.                      |
| `playlist_movies` | Junction table linking playlists to the movies they contain.                |

---
Here is the Entity-Relationship Diagram for the database schema.

![ER Diagram](./er_diagram.png)


## 📂 Repository Structure

The project is organized into logical files for clarity and ease of evaluation:

-   `README.md`: This file, providing a high-level overview of the project.
-   `schema.sql`: Contains all `CREATE TABLE` statements for building the database structure.
-   `data.sql`: Contains all `INSERT INTO` statements for populating the database with sample data.
-   `queries.sql`: Contains all 30 advanced SQL queries with problem statements.
-   `er_diagram.png`: The schema diagram image.
-   `pdf_Movie_Streaming_Platform_Project.pdf`: The complete project report in PDF format.

---

