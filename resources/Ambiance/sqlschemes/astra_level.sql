CREATE TABLE `alma_playerlevel` (
  `license` varchar(80) NOT NULL,
  `exp` int(80) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `alma_playerlevel`
  ADD PRIMARY KEY (`license`);
COMMIT;