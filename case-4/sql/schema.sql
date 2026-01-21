CREATE DATABASE TourismWeb;
GO

USE TourismWeb;
GO

CREATE TABLE countries (
    country_id INT IDENTITY(1, 1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL
);

CREATE TABLE cities (
    city_id INT IDENTITY(1, 1) PRIMARY KEY,
    country_id INT NOT NULL,
    name NVARCHAR(100) NOT NULL,
    CONSTRAINT fk_cities_country
        FOREIGN KEY (country_id)
        REFERENCES countries(country_id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

CREATE TABLE tour_packages (
    tour_id INT IDENTITY(1, 1) PRIMARY KEY,
    city_id INT NOT NULL,
    title NVARCHAR(150) NOT NULL,
    duration_days INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_tours_city
        FOREIGN KEY (city_id)
        REFERENCES cities(city_id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    CONSTRAINT chk_tours_duration
        CHECK (duration_days > 0),
    CONSTRAINT chk_tours_price
        CHECK (price > 0)
);

CREATE TABLE services (
    service_id INT IDENTITY(1, 1) PRIMARY KEY,
    name NVARCHAR(120) NOT NULL,
    description NVARCHAR(255)
);

CREATE TABLE orders (
    order_id INT IDENTITY(1, 1) PRIMARY KEY,
    tour_id INT NOT NULL,
    service_id INT NOT NULL,
    customer_name NVARCHAR(120) NOT NULL,
    phone NVARCHAR(30) NOT NULL,
    order_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_orders_tour
        FOREIGN KEY (tour_id)
        REFERENCES tour_packages(tour_id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    CONSTRAINT fk_orders_service
        FOREIGN KEY (service_id)
        REFERENCES services(service_id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    CONSTRAINT chk_orders_price
        CHECK (total_price > 0)
);

CREATE INDEX idx_cities_country_id ON cities(country_id);
CREATE INDEX idx_tours_city_id ON tour_packages(city_id);
CREATE INDEX idx_orders_tour_id ON orders(tour_id);
CREATE INDEX idx_orders_service_id ON orders(service_id);

INSERT INTO countries (name) VALUES
(N'Россия'),
(N'Италия'),
(N'Япония');

INSERT INTO cities (country_id, name) VALUES
(1, N'Москва'),
(1, N'Санкт-Петербург'),
(2, N'Рим'),
(2, N'Милан'),
(3, N'Токио');

INSERT INTO tour_packages (city_id, title, duration_days, price) VALUES
(1, N'Выходные в Москве', 2, 15000),
(2, N'Белые ночи', 5, 42000),
(3, N'Римские каникулы', 4, 65000),
(4, N'Шопинг в Милане', 3, 58000),
(5, N'Япония весной', 7, 120000);

INSERT INTO services (name, description) VALUES
(N'Страховка', N'Страхование на период поездки'),
(N'Трансфер', N'Встреча в аэропорту и доставка в отель'),
(N'Экскурсия', N'Дополнительная экскурсионная программа');

INSERT INTO orders (tour_id, service_id, customer_name, phone, order_date, total_price) VALUES
(1, 1, N'Иван Петров', N'+7-900-100-20-30', '2026-01-10', 15000),
(3, 2, N'Мария Смирнова', N'+7-900-200-30-40', '2026-01-12', 68000),
(5, 3, N'Алексей Климов', N'+7-900-300-40-50', '2026-01-15', 125000);
