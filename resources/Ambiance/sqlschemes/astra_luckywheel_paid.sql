CREATE TABLE `alma_paid_wheel` (
  `license` varchar(80) NOT NULL,
  `ammount` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `alma_paid_wheel`
  ADD PRIMARY KEY (`license`);
COMMIT;
