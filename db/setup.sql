CREATE TABLE
    device_type (
        id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100) NOT NULL
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_general_ci;

CREATE TABLE
    devices (
        id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
        device_type INT UNSIGNED NOT NULL,
        name VARCHAR(100) NOT NULL,
        CONSTRAINT fk_devices_device_type FOREIGN KEY (device_type) REFERENCES device_type (id) ON DELETE CASCADE ON UPDATE CASCADE
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

CREATE INDEX fk_devices_device_type ON devices (device_type);

CREATE TABLE
    warp_technique (
        id INT UNSIGNED NOT NULL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        description VARCHAR(1500) NOT NULL
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_general_ci;

CREATE TABLE
    warp_technique_entry (
        id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
        device_id INT UNSIGNED NOT NULL,
        technique_id INT UNSIGNED NOT NULL,
        value FLOAT NOT NULL,
        CONSTRAINT fk_warp_technique_entry FOREIGN KEY (technique_id) REFERENCES warp_technique (id) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT fk_warp_technique_entry_devices FOREIGN KEY (device_id) REFERENCES devices (id) ON DELETE CASCADE ON UPDATE CASCADE
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_general_ci;

CREATE INDEX fk_warp_technique_entry ON warp_technique_entry (technique_id);

CREATE INDEX fk_warp_technique_entry_devices ON warp_technique_entry (device_id);

CREATE TABLE
    warp_entry (
        id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
        technique_entry_id INT UNSIGNED NOT NULL,
        quantity INT UNSIGNED NOT NULL,
        ghg_savings FLOAT NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT current_timestamp(),
        updated_at TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp,
        created_by VARCHAR(100),
        comment VARCHAR(500),
        CONSTRAINT fk_warp_entry FOREIGN KEY (technique_entry_id) REFERENCES warp_technique_entry (id) ON DELETE CASCADE ON UPDATE CASCADE
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_general_ci;

CREATE INDEX fk_warp_entry ON warp_entry (technique_entry_id);

INSERT INTO
    device_type (name)
VALUES
    ('Desktop');

INSERT INTO
    device_type (name)
VALUES
    ('Laptop');

INSERT INTO
    device_type (name)
VALUES
    ('Mobile');

INSERT INTO
    device_type (name)
VALUES
    ('Monitor/TV');

INSERT INTO
    device_type (name)
VALUES
    ('Mixed Electronics');

INSERT INTO
    devices (device_type, name)
VALUES
    (1, 'HP');

INSERT INTO
    devices (device_type, name)
VALUES
    (1, 'DELL');

INSERT INTO
    devices (device_type, name)
VALUES
    (1, 'LENOVO');

INSERT INTO
    devices (device_type, name)
VALUES
    (1, 'ACER');

INSERT INTO
    devices (device_type, name)
VALUES
    (2, 'APPLE');

INSERT INTO
    devices (device_type, name)
VALUES
    (2, 'DELL');

INSERT INTO
    devices (device_type, name)
VALUES
    (2, 'HP');

INSERT INTO
    devices (device_type, name)
VALUES
    (2, 'SAMSUNG');

INSERT INTO
    devices (device_type, name)
VALUES
    (3, 'APPLE');

INSERT INTO
    devices (device_type, name)
VALUES
    (3, 'SAMSUNG');

INSERT INTO
    devices (device_type, name)
VALUES
    (3, 'OPPO');

INSERT INTO
    devices (device_type, name)
VALUES
    (3, 'MOTOROLA');

INSERT INTO
    devices (device_type, name)
VALUES
    (4, 'SAMSUNG');

INSERT INTO
    devices (device_type, name)
VALUES
    (4, 'DELL');

INSERT INTO
    devices (device_type, name)
VALUES
    (4, 'ACER');

INSERT INTO
    devices (device_type, name)
VALUES
    (4, 'ASUS');

INSERT INTO
    devices (device_type, name)
VALUES
    (5, 'BATTERIES');

INSERT INTO
    devices (device_type, name)
VALUES
    (5, 'USB CABLES');

INSERT INTO
    warp_technique (id, name, description)
VALUES
    (
        1,
        'Recycled',
        'The term recycled generally refers to a process of converting waste materials into new products or raw materials, instead of simply disposing of them. Recycling helps to reduce the amount of waste in landfills, conserve natural resources, and reduce the environmental impact of production and consumption.'
    );

INSERT INTO
    warp_technique (id, name, description)
VALUES
    (
        2,
        'Landified',
        'waste management method that involves burying solid waste in the ground. The process begins with the construction of a pit or trench that is lined with a barrier layer to prevent contamination of the surrounding soil and groundwater. The waste is then deposited in the pit and compacted to reduce its volume. Additional layers of soil or materials are added and compacted until the landfill is full, at which point a final cover is placed over the top. The landfill site is then monitored for many years to prevent contamination and manage any gases or liquids produced by the waste. Despite being effective, landfilling presents environmental and health concerns such as pollution and odors.'
    );

INSERT INTO
    warp_technique (id, name, description)
VALUES
    (
        3,
        'Combusted',
        'Combustion is a waste reduction technique that involves burning waste materials in specially designed incinerators. The process involves heating the waste to high temperatures in the presence of oxygen, which breaks it down into ash and gases that can be processed further or used to generate energy. While combustion can reduce the volume of waste and produce energy, it also presents environmental and health concerns such as the emission of greenhouse gases and air pollutants. Modern incinerators are equipped with advanced pollution control technologies to mitigate these concerns. Therefore, while combustion can be an effective waste reduction technique, its use should be carefully considered and monitored to minimize negative environmental impacts.'
    );

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (1, 1, -1.49);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (1, 2, 0.02);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (1, 3, -0.66);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (2, 1, -1.49);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (2, 2, 0.02);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (2, 3, -0.66);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (3, 3, -0.66);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (3, 1, -1.49);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (3, 2, 0.02);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (4, 1, -1.49);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (4, 2, 0.02);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (4, 3, -0.66);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (6, 1, -1.06);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (6, 2, 0.02);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (6, 3, 0.66);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (7, 1, -1.06);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (7, 2, 0.02);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (7, 3, 0.66);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (8, 3, 0.66);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (8, 1, -1.06);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (8, 2, 0.02);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (10, 1, -1.06);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (10, 2, 0.02);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (10, 3, 0.66);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (11, 1, -0.49);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (11, 2, 0.02);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (11, 3, 0.36);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (12, 1, -0.49);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (12, 2, 0.02);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (12, 3, 0.36);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (13, 3, 0.36);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (13, 1, -0.49);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (13, 2, 0.02);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (14, 1, -0.49);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (14, 2, 0.02);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (14, 3, 0.36);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (16, 1, -0.99);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (16, 2, 0.02);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (16, 3, 0.03);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (17, 1, -0.99);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (17, 2, 0.02);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (17, 3, 0.03);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (18, 3, 0.03);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (18, 1, -0.99);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (18, 2, 0.02);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (19, 1, -0.99);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (19, 2, 0.02);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (19, 3, 0.03);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (21, 1, -0.23);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (21, 2, 0.01);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (21, 3, 0.23);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (22, 1, -0.35);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (22, 2, 0.01);

INSERT INTO
    warp_technique_entry (device_id, technique_id, value)
VALUES
    (22, 3, 0.19);