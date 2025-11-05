# 🎬 Movie Streaming Platform Management System (DBMS Project)

### 📘 Overview
This is a **Database Management System (DBMS)** project designed for academic submission.  
It simulates the backend data model for a **Movie Streaming Platform** (like Netflix or Prime Video).  
The project demonstrates advanced SQL concepts, including:
- ER Diagram & Normalization (3NF)
- Table creation with constraints
- Sample data insertion
- 30 advanced SQL queries with joins, subqueries, aggregation, and set operations

---

## 🧩 1️⃣ ER Diagram

**Entities:**
- `Users` – stores user profiles and subscription details  
- `Subscription_Plans` – defines plan types, price, and duration  
- `Movies` – details about movies and ratings  
- `Actors` – actor information  
- `Genres` – movie genres  
- `Movie_Actors` – relationship (many-to-many) between movies and actors  
- `Movie_Genres` – relationship between movies and genres  
- `Watch_History` – logs user watching activity  
- `Reviews` – user-given ratings and comments  
- `Playlists` & `Playlist_Items` – user-created movie collections  
- `Payments` – subscription payment records  

**Relationships:**
- One user → One subscription plan  
- One user → Many watch_history entries  
- Many movies ↔ Many actors (via `movie_actors`)  
- Many movies ↔ Many genres (via `movie_genres`)  
- One user → Many reviews  
- One playlist → Many movies  

**ER Diagram Example:**
![ER Diagram](./er_diagram.png)

---

## 🏗️ 2️⃣ Database Design & Table Creation

All table creation scripts are available in [`create_tables.sql`](./create_tables.sql).

Example:
```sql
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT CHECK(age > 0),
    email VARCHAR(100) UNIQUE NOT NULL,
    country VARCHAR(30),
    subscription_id INT,
    created_at DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (subscription_id) REFERENCES subscription_plans(subscription_id)
);
