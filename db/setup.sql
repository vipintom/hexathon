DROP SCHEMA mydatabase;

CREATE SCHEMA mydatabase;

CREATE TABLE
    device_type (
        id INT UNSIGNED NOT NULL PRIMARY KEY,
        name VARCHAR(100) NOT NULL
    ) engine = InnoDB;

CREATE TABLE
    devices (
        id INT UNSIGNED NOT NULL PRIMARY KEY,
        device_type INT UNSIGNED NOT NULL,
        name VARCHAR(100) NOT NULL,
        CONSTRAINT fk_devices_device_type FOREIGN KEY (device_type) REFERENCES device_type (id) ON DELETE CASCADE ON UPDATE CASCADE
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE INDEX fk_devices_device_type ON devices (device_type);

CREATE TABLE
    warp_technique (
        id INT UNSIGNED NOT NULL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        description VARCHAR(500) NOT NULL
    ) engine = InnoDB;

CREATE TABLE
    warp_technique_entry (
        id INT UNSIGNED NOT NULL PRIMARY KEY,
        device_id INT UNSIGNED NOT NULL,
        technique_id INT UNSIGNED NOT NULL,
        value DECIMAL(3, 3) NOT NULL,
        CONSTRAINT fk_warp_technique_entry FOREIGN KEY (technique_id) REFERENCES warp_technique (id) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT fk_warp_technique_entry_devices FOREIGN KEY (device_id) REFERENCES devices (id) ON DELETE CASCADE ON UPDATE CASCADE
    ) engine = InnoDB;

CREATE INDEX fk_warp_technique_entry ON warp_technique_entry (technique_id);

CREATE INDEX fk_warp_technique_entry_devices ON warp_technique_entry (device_id);

CREATE TABLE
    warp_entry (
        id INT UNSIGNED NOT NULL PRIMARY KEY,
        technique_entry_id INT UNSIGNED NOT NULL,
        quantity INT UNSIGNED NOT NULL,
        ghg_savings DECIMAL(3, 3) NOT NULL,
        created_at TIMESTAMP DEFAULT current_timestamp(),
        updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        created_by INT,
        comment VARCHAR(500),
        CONSTRAINT fk_warp_entry FOREIGN KEY (technique_entry_id) REFERENCES warp_technique_entry (id) ON DELETE CASCADE ON UPDATE CASCADE
    ) engine = InnoDB;

CREATE INDEX fk_warp_entry ON warp_entry (technique_entry_id);