CREATE TABLE mountains (
id INT AUTO_INCREMENT PRIMARY KEY,
`name` varchar(50) NOT NULL
);

CREATE TABLE peaks (
id INT AUTO_INCREMENT PRIMARY KEY,
`name` varchar(50) NOT NULL,
mountain_id INT,
CONSTRAINT `fk_peaks_mountains`
FOREIGN KEY (mountain_id)
REFERENCES mountains(id));


SELECT 
    v.driver_id,
    v.vehicle_type,
    CONCAT(c.first_name, ' ', c.last_name) AS driver_name
FROM
    vehicles AS v
        JOIN
    campers AS c ON v.driver_id = c.id;
    
    CREATE TABLE mountains (
id INT AUTO_INCREMENT PRIMARY KEY,
`name` varchar(50) NOT NULL
);
CREATE TABLE peaks (
id INT AUTO_INCREMENT PRIMARY KEY,
`name` varchar(50) NOT NULL,
mountain_id INT,
CONSTRAINT `fk_peaks_mountains`
FOREIGN KEY (mountain_id)
REFERENCES mountains(id)
ON DELETE CASCADE);

SELECT r.starting_point AS `route_starting_point`,
r.end_point AS `route_ending_points`,
r.leader_id, concat(c.first_name," ", c.last_name) AS leader_name 
FROM routes AS r
JOIN campers AS c 
ON r.leader_id = c.id;

