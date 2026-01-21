CREATE DATABASE IF NOT EXISTS tourism;
USE tourism;

CREATE TABLE countries (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE cities (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    country_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    CONSTRAINT fk_cities_country
        FOREIGN KEY (country_id)
        REFERENCES countries(country_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE tour_packages (
    tour_id INT AUTO_INCREMENT PRIMARY KEY,
    city_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    duration_days INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_tours_city
        FOREIGN KEY (city_id)
        REFERENCES cities(city_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_tours_duration
        CHECK (duration_days > 0),
    CONSTRAINT chk_tours_price
        CHECK (price > 0)
);

CREATE TABLE services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    description VARCHAR(255)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    tour_id INT NOT NULL,
    service_id INT NOT NULL,
    customer_name VARCHAR(120) NOT NULL,
    phone VARCHAR(30) NOT NULL,
    order_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_orders_tour
        FOREIGN KEY (tour_id)
        REFERENCES tour_packages(tour_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_orders_service
        FOREIGN KEY (service_id)
        REFERENCES services(service_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_orders_price
        CHECK (total_price > 0)
);

CREATE INDEX idx_cities_country_id ON cities(country_id);
CREATE INDEX idx_tours_city_id ON tour_packages(city_id);
CREATE INDEX idx_orders_tour_id ON orders(tour_id);
CREATE INDEX idx_orders_service_id ON orders(service_id);

INSERT INTO countries (name) VALUES
('Россия'),
('Италия'),
('Япония');

INSERT INTO cities (country_id, name) VALUES
(1, 'Москва'),
(1, 'Санкт-Петербург'),
(2, 'Рим'),
(2, 'Милан'),
(3, 'Токио');

INSERT INTO tour_packages (city_id, title, duration_days, price) VALUES
(1, 'Выходные в Москве', 2, 15000),
(2, 'Белые ночи', 5, 42000),
(3, 'Римские каникулы', 4, 65000),
(4, 'Шопинг в Милане', 3, 58000),
(5, 'Япония весной', 7, 120000);

INSERT INTO services (name, description) VALUES
('Страховка', 'Страхование на период поездки'),
('Трансфер', 'Встреча в аэропорту и доставка в отель'),
('Экскурсия', 'Дополнительная экскурсионная программа');

INSERT INTO orders (tour_id, service_id, customer_name, phone, order_date, total_price) VALUES
(1, 1, 'Иван Петров', '+7-900-100-20-30', '2026-01-10', 15000),
(3, 2, 'Мария Смирнова', '+7-900-200-30-40', '2026-01-12', 68000),
(5, 3, 'Алексей Климов', '+7-900-300-40-50', '2026-01-15', 125000);
