#Customer Support Ticket Analytics 

CREATE DATABASE support_analytics;

SHOW DATABASES;

USE support_analytics;

CREATE TABLE customers (
customer_id INT AUTO_INCREMENT PRIMARY KEY,
full_name VARCHAR(100) NOT NULL, 
email VARCHAR(100) UNIQUE NOT NULL, 
created_at DATE NOT NULL);

DROP TABLE customers;

CREATE TABLE customers (
customer_id INT AUTO_INCREMENT PRIMARY KEY,
full_name VARCHAR(100) NOT NULL, 
email_id VARCHAR(100) UNIQUE NOT NULL, 
created_at DATE NOT NULL);

SHOW TABLES;

DROP TABLE agents;

CREATE TABLE agents (
agent_id INT AUTO_INCREMENT PRIMARY KEY, 
full_name VARCHAR(100) NOT NULL, 
team VARCHAR(100) NOT NULL, 
hired_at DATE NOT NULL);

SHOW TABLES;

CREATE TABLE tickets(
ticket_id INT AUTO_INCREMENT PRIMARY KEY,
 customer_id INT NOT NULL, 
 agent_id INT NOT NULL,
 priority ENUM ('low','medium','high','urgent') NOT NULL,
 created_at DATETIME NOT NULL,
 closed_at DATETIME NULL,
 
 CONSTRAINT fk_tickets_customer
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  
 CONSTRAINT fk_tickets_agent
  FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
  );

  SHOW TABLES;

  INSERT INTO customers (full_name, email_id, created_at) VALUES 
  ('Hande Ercel', 'hande23@gmail.com','2025-01-01'),
  ('Nina Gupta', 'nina12gupta@gmail.com','2025-09-04'),
  ('Sheetal Sinha', 'sheetals@gmail.com', '2025-06-30'),
  ('Murat Denis', 'Murath123@gmail.com', '2025-09-16');

  SELECT * FROM customers;

  INSERT INTO agents(full_name, team, hired_at) VALUES
  ('Burak Benz', 'Support','2024-01-09'),
  ('Helen Deniz', 'Support', '2024-08-15'),
  ('Lora Lopa', 'Escalations', '2023-11-20'),
  ('Nina Benz', 'Escalations', '2024-08-03');

 Select * FROM agents;

 SELECT agent_id, full_name, team FROM agents;

 INSERT INTO tickets (customer_id, agent_id, priority, created_at, closed_at) VALUES
 (1,1,'High','2025-01-10 10:15:00', NULL ),
 (2,2,'Medium','2025-01-11 14:30:00', NULL),
 (3,3,'Urgent','2025-01-12 09:45:00', NULL),
 (4,4,'Low','2025-08-14 10:55:00', NULL);

 SELECT * FROM tickets;

 SELECT
  tickets.ticket_id,
  customers.full_name,
  agents.full_name,
  tickets.priority,
  tickets.created_at
FROM tickets
JOIN customers ON tickets.customer_id = customers.customer_id
JOIN agents ON tickets.agent_id = agents.agent_id
WHERE tickets.closed_at IS NULL;

SELECT 
  agents.full_name,
  COUNT(tickets.ticket_id) AS open_tickets
FROM tickets
JOIN agents ON tickets.agent_id = agents.agent_id
WHERE tickets.closed_at IS NULL
GROUP BY agents.full_name;

SELECT
  tickets.priority,
  COUNT(tickets.ticket_id) AS total_tickets
FROM tickets
GROUP BY tickets.priority;

