DROP TABLE IF EXISTS elements, connecter, connecter2, pc, sous_reseau, reseau, infrastructure, routeur, utilisateur;


CREATE TABLE utilisateur (
    id_utilisateur SERIAL PRIMARY KEY,
    pseudo VARCHAR(255) NOT NULL,
    mot_de_passe VARCHAR(255) NOT NULL
);

CREATE TABLE routeur (
    id_routeur SERIAL PRIMARY KEY,
    mac MACADDR NOT NULL
);

CREATE TABLE infrastructure (
    id_infrastructure SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    id_utilisateur INTEGER NOT NULL REFERENCES utilisateur(id_utilisateur)
);

CREATE TABLE reseau (
    id_reseau SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    mask_reseau CIDR NOT NULL,
    adresse_reseau INET NOT NULL,
    id_infrastructure INTEGER NOT NULL REFERENCES infrastructure(id_infrastructure)
);

CREATE TABLE sous_reseau (
    id_sous_reseau SERIAL PRIMARY KEY,
    mask CIDR NOT NULL,
    id_reseau INTEGER NOT NULL REFERENCES reseau(id_reseau)
);

CREATE TABLE pc (
    id_pc SERIAL PRIMARY KEY,
    ip INET NOT NULL,
    mac MACADDR NOT NULL,
    id_reseau INTEGER NOT NULL REFERENCES reseau(id_reseau)
);

CREATE TABLE elements (
    id_elements SERIAL PRIMARY KEY,
    ip_source INET NOT NULL,
    ip_destination INET NOT NULL,
    interface_relayage VARCHAR(255),
    masque_destination CIDR,
    mtu INTEGER,
    id_pc INTEGER NOT NULL REFERENCES pc(id_pc),
    id_routeur INTEGER NOT NULL REFERENCES routeur(id_routeur)
);

CREATE TABLE connecter (
    id_reseau INTEGER NOT NULL REFERENCES reseau(id_reseau),
    id_routeur INTEGER NOT NULL REFERENCES routeur(id_routeur),
    interface_routeur VARCHAR(255),
    PRIMARY KEY (id_reseau, id_routeur)
);

CREATE TABLE connecter2 (
    id_reseau INTEGER NOT NULL REFERENCES reseau(id_reseau),
    id_routeur INTEGER NOT NULL REFERENCES routeur(id_routeur),
    interface_routeur_sr VARCHAR(255),
    PRIMARY KEY (id_reseau, id_routeur)
);

-- Insertion dans `utilisateur`
INSERT INTO utilisateur (pseudo, mot_de_passe) VALUES ('user1', 'mdp1');

-- Insertion dans `routeur`
INSERT INTO routeur (mac) VALUES ('00:1B:44:17:4B:E9');

-- Insertion dans `infrastructure`
INSERT INTO infrastructure (nom, id_utilisateur) VALUES ('Infra1', 1);

-- Insertion dans `reseau`
INSERT INTO reseau (nom, mask_reseau, adresse_reseau, id_infrastructure) VALUES ('Reseau1', '255.255.255.0', '192.168.1.0', 1);

SELECT * FROM utilisateur;
SELECT * FROM routeur;
SELECT * FROM infrastructure;