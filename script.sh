#!/bin/bash

# Define as variáveis de conexão com o banco de dados
DB_HOST="togatoga.cpeoxe1xovc8.us-east-1.rds.amazonaws.com"
DB_USER="togatoga"
DB_PASS="togatoga"
DB_NAME="togatoga"

# Comando para conectar e executar consultas SQL no banco de dados
MYSQL_COMMAND="mysql -h $DB_HOST -u $DB_USER -p$DB_PASS $DB_NAME -e"

# Testa a conexão com o banco de dados
$MYSQL_COMMAND "SELECT 1;"

# Verifica se a conexão foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Conexão com o banco de dados bem-sucedida."
else
    echo "Falha na conexão com o banco de dados."
    exit 1
fi

# Cria as tabelas e insere dados nelas (conforme seu script original)
$MYSQL_COMMAND "
CREATE TABLE IF NOT EXISTS hospitals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS doctors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    hospital_id INT,
    FOREIGN KEY (hospital_id) REFERENCES hospitals(id)
);

CREATE TABLE IF NOT EXISTS transports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    chassis INT
);

CREATE TABLE IF NOT EXISTS services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    hospital_id INT,
    date TIMESTAMP,
    doctor_id INT,
    FOREIGN KEY (hospital_id) REFERENCES hospitals(id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);

CREATE TABLE IF NOT EXISTS allocations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    transport_id INT,
    FOREIGN KEY (patient_id) REFERENCES patients(id),
    FOREIGN KEY (transport_id) REFERENCES transports(id)
);

INSERT INTO hospitals (name, address) VALUES
('Hospital A', 'Endereço Hospital A'),
('Hospital B', 'Endereço Hospital B');

INSERT INTO doctors (name) VALUES
('Dr. Smith'),
('Dr. Johnson');

INSERT INTO patients (name, hospital_id) VALUES
('Paciente 1', 1),
('Paciente 2', 1),
('Paciente 3', 2);

INSERT INTO transports (chassis) VALUES
(123456),
(789012);

INSERT INTO services (hospital_id, date, doctor_id) VALUES
(1, '2024-01-01 10:00:00', 1),
(1, '2024-01-02 11:00:00', 2),
(2, '2024-01-03 12:00:00', 1);

INSERT INTO allocations (patient_id, transport_id) VALUES
(1, 1),
(2, 1),
(3, 2);
"
