USE mailserver;
--
-- Virtual domains table. 
--
CREATE TABLE virtual_domains ( 
    id int(11) NOT NULL auto_increment, 
    name varchar(50) NOT NULL, 
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Virtual users table. 
--
CREATE TABLE virtual_users ( 
    id int(11) NOT NULL auto_increment, 
    domain_id int(11) NOT NULL, 
    password varchar(106) NOT NULL, 
    email varchar(100) NOT NULL, 
    PRIMARY KEY (id), 
    UNIQUE KEY email (email), 
    FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Virtual aliase table. 
--
CREATE TABLE virtual_aliases ( 
    id int(11) NOT NULL auto_increment, 
    domain_id int(11) NOT NULL, 
    source varchar(100) NOT NULL, 
    destination varchar(100) NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dummy domain data.
--
INSERT INTO mailserver.virtual_domains (id ,name) 
VALUES ('1', 'example.com'), ('2', 'ubuntu.example.com'), ('3', 'ubuntu'), ('4', 'localhost.example.com');
INSERT INTO mailserver.virtual_users (id, domain_id, password , email) 
VALUES ('1', '1', ENCRYPT('password', SUBSTRING(SHA(RAND()), -16)), 'email1@example.com'), ('2', '1', ENCRYPT('password', SUBSTRING(SHA(RAND()), -16)), 'email2@example.com');
INSERT INTO mailserver.virtual_aliases (id, domain_id, source, destination) 
VALUES ('1', '1', 'alias@example.com', 'email1@example.com');
