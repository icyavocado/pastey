DROP TABLE IF EXISTS `pastey_bin`;
CREATE TABLE `pastey_bin` (
	`id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`name`	TEXT NOT NULL UNIQUE,
	`value`	TEXT,
	`expiration`	TEXT
);