CREATE DATABASE wallets;
\c wallets;
    -- Table Compte
    CREATE TABLE IF NOT EXISTS compte (
        id_compte SERIAL PRIMARY KEY,
        nom_compte VARCHAR(255),
        solde DECIMAL(10, 2),
        type_compte VARCHAR(50),
        date_ouverture VARCHAR(50),
        adresse VARCHAR(255),
        numero_telephone VARCHAR(20)
    );

    -- Table Transaction
    CREATE TABLE IF NOT EXISTS transaction (
        id_transaction SERIAL PRIMARY KEY,
        id_compte INT REFERENCES compte(id_compte),
        montant DECIMAL(10, 2),
        type_transaction VARCHAR(50),
        date_transaction VARCHAR(50),
        description TEXT,
        categorie VARCHAR(50)
    );

    -- Table Devise
    CREATE TABLE IF NOT EXISTS devise (
        code_devise VARCHAR(3) PRIMARY KEY,
        nom_devise VARCHAR(255),
        taux_change DECIMAL(10, 4),
        pays_origine VARCHAR(50),
        symbole VARCHAR(10)
    );


--Insert
--table compte
INSERT INTO compte (nom_compte, solde, type_compte, date_ouverture, adresse, numero_telephone)
SELECT 'Compte 1', 1000.00, 'Epargne', '2023-01-01', 'Adresse 1', '1234567890'
WHERE NOT EXISTS (SELECT 1 FROM compte WHERE nom_compte = 'Compte 1');

INSERT INTO compte (nom_compte, solde, type_compte, date_ouverture, adresse, numero_telephone)
SELECT 'Compte 2', 500.00, 'Chèques', '2023-02-01', 'Adresse 2', '9876543210'
WHERE NOT EXISTS (SELECT 1 FROM compte WHERE nom_compte = 'Compte 2');

--table transaction
INSERT INTO transaction (id_compte, montant, type_transaction, date_transaction, description, categorie)
SELECT 1, 50.00, 'Dépôt', '2023-01-05', 'Dépôt initial', 'Finance'
WHERE NOT EXISTS (SELECT 1 FROM transaction WHERE id_compte = 1 AND montant = 50.00 AND type_transaction = 'Dépôt' AND date_transaction = '2023-01-05');

INSERT INTO transaction (id_compte, montant, type_transaction, date_transaction, description, categorie)
SELECT 2, -20.00, 'Retrait', '2023-02-10', 'Retrait ATM', 'Dépenses'
WHERE NOT EXISTS (SELECT 1 FROM transaction WHERE id_compte = 2 AND montant = -20.00 AND type_transaction = 'Retrait' AND date_transaction = '2023-02-10');

--table devise 
INSERT INTO devise (code_devise, nom_devise, taux_change, pays_origine, symbole)
SELECT 'EUR', 'Euro', 1.20, 'Union européenne', '€'
WHERE NOT EXISTS (SELECT 1 FROM devise WHERE code_devise = 'EUR');
