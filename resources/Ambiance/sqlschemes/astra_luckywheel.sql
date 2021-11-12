CREATE TABLE `alma_daywheel` (
  `license` varchar(80) NOT NULL,
  `time` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `alma_daywheel`
  ADD PRIMARY KEY (`license`);
COMMIT;
