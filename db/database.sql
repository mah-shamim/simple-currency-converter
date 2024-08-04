CREATE TABLE `exchange_rates` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `currency` varchar(3) NOT NULL,
    `rate` decimal(10, 4) NOT NULL,
    `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE currencies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(3) NOT NULL,
    name VARCHAR(50) NOT NULL
);

INSERT INTO currencies (code, name) VALUES
('USD', 'United States Dollar'),
('EUR', 'Euro'),
('GBP', 'British Pound'),
('JPY', 'Japanese Yen'),
('BDT', 'Bangladesh Taka'),
('AUD', 'Australian Dollar');