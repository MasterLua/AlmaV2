-- phpMyAdmin SQL Dump
-- version 5.0.4deb2~bpo10+1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : Dim 14 nov. 2021 à 09:38
-- Version du serveur :  10.3.31-MariaDB-0+deb10u1
-- Version de PHP : 7.3.31-1~deb10u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `almav2`
--

-- --------------------------------------------------------

--
-- Structure de la table `alma_accounts`
--

CREATE TABLE `alma_accounts` (
  `steam` varchar(50) NOT NULL DEFAULT '0',
  `fivem` varchar(50) NOT NULL DEFAULT '0',
  `vip` tinyint(4) NOT NULL DEFAULT 0,
  `expiration` int(255) NOT NULL DEFAULT 0,
  `investisseur` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `alma_accounts`
--

INSERT INTO `alma_accounts` (`steam`, `fivem`, `vip`, `expiration`, `investisseur`) VALUES
('055eec09e035d3567b7ba2691d04851ab243a107', '1516837', 0, 0, 0),
('2575ac82da3a12b33e52ffe48dc63ca6efe2f3db', '0', 0, 0, 0),
('26a6ed6f3c05191b38ca1e3dc57cb349df614329', '0', 0, 0, 0),
('3339e6215337f29d2b77b311702a80f2c9637dc6', '4822123', 0, 0, 0),
('3411b72cb47c10d8d78026ee46ea5d09843e0685', '2506133', 0, 0, 0),
('3f13c40aebd47edf7899f3e1f82cb44684ecf38f', '2843038', 0, 0, 0),
('556324f99fd7e2ea9ad1fe5542b8d8a1b8470485', '4633435', 0, 0, 0),
('764fb156dd9475f40df6c98effe8f2c3bf886980', '4059308', 0, 0, 0),
('870915b3e51b169f0325dd9b270e694b382fc2b5', '0', 0, 0, 0),
('a58642a034203259f2574eed4f43d83f46979553', '0', 0, 0, 0),
('ac7c1ae563dc1234e69bdc206d49c677eff23097', '2787512', 0, 0, 0),
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', '1462783', 2, 1638885262, 0),
('c941e05cd8a0733c6e180831b4bf36eb3665165d', '0', 0, 0, 0),
('c9a4f510db6a7f621cd57e41f3cfaf12b035ada2', '2767453', 0, 0, 0),
('caefce36f70c17d9bee7c766d271fbce0199419d', '920283', 0, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `alma_ammunation`
--

CREATE TABLE `alma_ammunation` (
  `id` int(11) NOT NULL,
  `weapon` varchar(80) NOT NULL,
  `label` varchar(90) NOT NULL,
  `price` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `alma_ban`
--

CREATE TABLE `alma_ban` (
  `id_ban` int(11) NOT NULL,
  `tokens` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `by_name` text NOT NULL,
  `user_name` text DEFAULT NULL,
  `reason` longtext DEFAULT NULL,
  `expiration` int(50) DEFAULT NULL,
  `permanent` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `alma_ban`
--

INSERT INTO `alma_ban` (`id_ban`, `tokens`, `by_name`, `user_name`, `reason`, `expiration`, `permanent`) VALUES
(15, '4:63bf156dfbaf6ed02bd4ccb4e0f7d68e54e987b45298806a6c5c5b48db4c8ca4', '[Fondateur] Authentic', 'wmdu31', 'ntm', 1636816263, 1);

-- --------------------------------------------------------

--
-- Structure de la table `alma_commands`
--

CREATE TABLE `alma_commands` (
  `id` bigint(20) NOT NULL,
  `fivem` varchar(50) NOT NULL DEFAULT '0',
  `command` varchar(50) NOT NULL DEFAULT '0',
  `argument` varchar(50) NOT NULL DEFAULT '0',
  `transaction` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `alma_daywheel`
--

CREATE TABLE `alma_daywheel` (
  `license` varchar(80) NOT NULL,
  `time` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `alma_entreprise`
--

CREATE TABLE `alma_entreprise` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `money` int(11) NOT NULL,
  `dirtycash` int(11) NOT NULL,
  `coffre` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `alma_garage`
--

CREATE TABLE `alma_garage` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `pos` varchar(255) NOT NULL,
  `SpawnPoint` varchar(255) NOT NULL,
  `DeletePoint` varchar(255) NOT NULL,
  `Heading` int(11) DEFAULT 0,
  `blip` int(11) DEFAULT 0,
  `type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `alma_garage`
--

INSERT INTO `alma_garage` (`id`, `name`, `pos`, `SpawnPoint`, `DeletePoint`, `Heading`, `blip`, `type`) VALUES
(27, 'Parking GrooveStreet', '{\"x\":-6.64520406723022,\"y\":-1719.4334716796876,\"z\":29.29779434204101}', '{\"x\":5.07790946960449,\"y\":-1715.842529296875,\"z\":29.29578399658203}', '{\"x\":-20.64522933959961,\"y\":-1726.4110107421876,\"z\":29.31169509887695}', 0, 1, 'car'),
(28, 'Parking Pillbox', '{\"x\":-348.7176513671875,\"y\":-874.8361206054688,\"z\":31.31008911132812}', '{\"x\":-328.8158264160156,\"y\":-877.7062377929688,\"z\":31.07286643981933}', '{\"x\":-338.8739013671875,\"y\":-890.8026733398438,\"z\":31.07145881652832}', 0, 1, 'car'),
(29, 'Parking Aguja', '{\"x\":-1184.1798095703126,\"y\":-1509.5859375,\"z\":4.64930391311645}', '{\"x\":-1196.6605224609376,\"y\":-1497.6241455078126,\"z\":4.36310529708862}', '{\"x\":-1204.666015625,\"y\":-1484.9302978515626,\"z\":4.36933183670043}', 0, 1, 'car'),
(30, 'Parking DelPerro', '{\"x\":-1206.48193359375,\"y\":-647.1587524414063,\"z\":25.90129470825195}', '{\"x\":-1204.3232421875,\"y\":-654.3712768554688,\"z\":25.90130043029785}', '{\"x\":-1198.201416015625,\"y\":-662.0109252929688,\"z\":25.90124893188476}', 0, 1, 'car'),
(31, 'Garage Aeroport', '{\"x\":-986.0765380859375,\"y\":-2707.7080078125,\"z\":13.83067417144775}', '{\"x\":-982.9541015625,\"y\":-2709.1630859375,\"z\":13.83275890350341}', '{\"x\":-979.8726806640625,\"y\":-2709.719970703125,\"z\":13.84832859039306}', 0, 1, 'car'),
(32, 'Garage Helico Aeroport', '{\"x\":-1186.1451416015626,\"y\":-2841.01806640625,\"z\":13.94614315032959}', '{\"x\":-1178.3511962890626,\"y\":-2845.54150390625,\"z\":13.94577026367187}', '{\"x\":-1178.3511962890626,\"y\":-2845.54150390625,\"z\":13.94577026367187}', 0, 1, 'aircraft'),
(33, 'Garage Helico Aeroport Sandy', '{\"x\":1721.94921875,\"y\":3274.480712890625,\"z\":41.14162826538086}', '{\"x\":1711.4998779296876,\"y\":3257.18701171875,\"z\":41.06793212890625}', '{\"x\":1711.4998779296876,\"y\":3257.18701171875,\"z\":41.06806182861328}', 0, 1, 'aircraft'),
(34, 'Garage Spawn 1', '{\"x\":-727.908447265625,\"y\":-68.51436614990235,\"z\":41.7503662109375}', '{\"x\":-733.2658081054688,\"y\":-71.69017028808594,\"z\":41.74742126464844}', '{\"x\":-736.9634399414063,\"y\":-73.4754638671875,\"z\":41.74746322631836}', 0, 1, 'car'),
(35, 'Garage Spawn 2', '{\"x\":-902.19873046875,\"y\":-159.5089874267578,\"z\":41.88142013549805}', '{\"x\":-905.2955322265625,\"y\":-161.10174560546876,\"z\":41.8794937133789}', '{\"x\":-908.4867553710938,\"y\":-162.69517517089845,\"z\":41.87744140625}', 0, 1, 'car'),
(36, 'Garage Casino', '{\"x\":884.930908203125,\"y\":-29.61385917663574,\"z\":78.76412963867188}', '{\"x\":883.2681274414063,\"y\":-32.07880401611328,\"z\":78.76412963867188}', '{\"x\":881.2848510742188,\"y\":-35.06534957885742,\"z\":78.76412963867188}', 0, 1, 'car'),
(37, 'Garage Hawick', '{\"x\":527.8548583984375,\"y\":-146.04014587402345,\"z\":58.37151718139648}', '{\"x\":536.7034912109375,\"y\":-136.29531860351563,\"z\":59.60051345825195}', '{\"x\":549.3505249023438,\"y\":-135.69464111328126,\"z\":59.40459823608398}', 0, 1, 'car'),
(38, 'Garage Mirror Park', '{\"x\":1036.065673828125,\"y\":-763.7364501953125,\"z\":57.99287414550781}', '{\"x\":1041.4403076171876,\"y\":-782.6431274414063,\"z\":58.00897216796875}', '{\"x\":1041.440185546875,\"y\":-782.6417846679688,\"z\":58.00897216796875}', 0, 1, 'car'),
(39, 'Parking jSPfrereejhaut', '{\"x\":-205.90284729003907,\"y\":314.6566162109375,\"z\":96.94556427001953}', '{\"x\":-209.3042449951172,\"y\":315.20806884765627,\"z\":96.94564819335938}', '{\"x\":-213.23313903808595,\"y\":315.2898254394531,\"z\":96.94564819335938}', 0, 1, 'car'),
(40, 'Parking Derriere Banquez', '{\"x\":375.0022888183594,\"y\":283.1969299316406,\"z\":103.17820739746094}', '{\"x\":371.1997985839844,\"y\":284.3172607421875,\"z\":103.25212860107422}', '{\"x\":359.6898193359375,\"y\":290.05877685546877,\"z\":103.5067138671875}', 0, 1, 'car'),
(41, 'garagecomicojsp', '{\"x\":487.39373779296877,\"y\":-30.59864234924316,\"z\":77.71842193603516}', '{\"x\":494.2873840332031,\"y\":-36.26412200927734,\"z\":77.71842193603516}', '{\"x\":491.3607482910156,\"y\":-23.91872215270996,\"z\":77.71841430664063}', 0, 1, 'car'),
(42, 'garagevillariche', '{\"x\":-71.13211059570313,\"y\":902.9609985351563,\"z\":235.60877990722657}', '{\"x\":-69.99139404296875,\"y\":900.220703125,\"z\":235.57833862304688}', '{\"x\":-69.54499053955078,\"y\":897.3328857421875,\"z\":235.55557250976563}', 0, 1, 'car'),
(43, 'VRAI PARKING CENTRAL', '{\"x\":221.14010620117188,\"y\":-811.9108276367188,\"z\":30.60455131530761}', '{\"x\":230.26405334472657,\"y\":-798.6986694335938,\"z\":30.57514953613281}', '{\"x\":224.26885986328126,\"y\":-758.578857421875,\"z\":30.82619667053222}', 0, 1, 'car'),
(44, 'Parking Pacific Bluff', '{\"x\":-2030.4591064453126,\"y\":-465.32666015625,\"z\":11.60397434234619}', '{\"x\":-2040.1766357421876,\"y\":-459.18927001953127,\"z\":11.39603519439697}', '{\"x\":-2042.4893798828126,\"y\":-472.03253173828127,\"z\":11.65456676483154}', 0, 1, 'car'),
(45, 'Parking Chumash', '{\"x\":-3148.938720703125,\"y\":1110.3988037109376,\"z\":20.85143089294433}', '{\"x\":-3142.67529296875,\"y\":1114.0321044921876,\"z\":20.70245361328125}', '{\"x\":-3147.799072265625,\"y\":1103.1033935546876,\"z\":20.70582008361816}', 0, 1, 'car'),
(47, 'garage marina', '{\"x\":-863.4942016601563,\"y\":-1324.4237060546876,\"z\":1.60516762733459}', '{\"x\":-869.7057495117188,\"y\":-1339.4354248046876,\"z\":-0.55692946910858}', '{\"x\":-869.7059326171875,\"y\":-1339.43603515625,\"z\":-0.48162171244621}', 0, 1, 'boat'),
(50, 'garagelaoucvide', '{\"x\":-100.97563171386719,\"y\":85.44194030761719,\"z\":71.48909759521485}', '{\"x\":-97.906982421875,\"y\":84.43753814697266,\"z\":71.55401611328125}', '{\"x\":-94.8561019897461,\"y\":82.24374389648438,\"z\":71.5618896484375}', 0, 1, 'car'),
(55, 'Garage Prison', '{\"x\":1857.112060546875,\"y\":2642.813232421875,\"z\":45.67185974121094}', '{\"x\":1857.1156005859376,\"y\":2643.006103515625,\"z\":45.67185974121094}', '{\"x\":1856.654296875,\"y\":2649.80810546875,\"z\":45.67185974121094}', 0, 1, 'car'),
(57, 'garagenordammu', '{\"x\":1704.603271484375,\"y\":3764.842529296875,\"z\":34.3656997680664}', '{\"x\":1713.6341552734376,\"y\":3767.510498046875,\"z\":34.30812072753906}', '{\"x\":1708.781982421875,\"y\":3774.81103515625,\"z\":34.49717712402344}', 0, 1, 'car'),
(58, 'garage nord', '{\"x\":115.81245422363281,\"y\":6599.08837890625,\"z\":32.00666427612305}', '{\"x\":125.56177520751953,\"y\":6598.078125,\"z\":31.93776130676269}', '{\"x\":123.90943908691406,\"y\":6589.69970703125,\"z\":31.98310852050781}', 0, 1, 'car'),
(60, 'garageversunesociety', '{\"x\":-194.89715576171876,\"y\":206.5764617919922,\"z\":86.44784545898438}', '{\"x\":-200.1585693359375,\"y\":210.80007934570313,\"z\":86.57903289794922}', '{\"x\":-202.9425811767578,\"y\":205.38619995117188,\"z\":85.43212127685547}', 0, 1, 'car'),
(72, 'MS-13', '{\"x\":-3200.641845703125,\"y\":829.8593139648438,\"z\":8.93492412567138}', '{\"x\":-3204.48046875,\"y\":842.8469848632813,\"z\":8.93492984771728}', '{\"x\":-3195.61962890625,\"y\":828.4258422851563,\"z\":8.93492412567138}', 0, 0, 'car'),
(73, 'Ballas', '{\"x\":99.75286102294922,\"y\":-1958.9881591796876,\"z\":20.79748153686523}', '{\"x\":85.2049331665039,\"y\":-1970.7476806640626,\"z\":20.74760246276855}', '{\"x\":102.59017181396485,\"y\":-1963.548828125,\"z\":20.84456253051757}', 0, 0, 'car'),
(74, 'Vagos', '{\"x\":317.5733947753906,\"y\":-2043.1175537109376,\"z\":20.93509864807129}', '{\"x\":328.8169860839844,\"y\":-2042.7781982421876,\"z\":20.77210807800293}', '{\"x\":330.0943908691406,\"y\":-2030.05322265625,\"z\":21.12354850769043}', 0, 0, 'car'),
(75, 'Marabunta', '{\"x\":1418.8848876953126,\"y\":-1500.8460693359376,\"z\":60.30427551269531}', '{\"x\":1422.347412109375,\"y\":-1504.1319580078126,\"z\":60.86611557006836}', '{\"x\":1401.7362060546876,\"y\":-1513.95947265625,\"z\":58.23176574707031}', 0, 0, 'car'),
(76, 'Families', '{\"x\":-188.94932556152345,\"y\":-1601.67919921875,\"z\":34.35103607177734}', '{\"x\":-188.44491577148438,\"y\":-1586.1082763671876,\"z\":34.79404830932617}', '{\"x\":-158.2359161376953,\"y\":-1589.4039306640626,\"z\":34.38740921020508}', 0, 0, 'car'),
(77, 'Cayo', '{\"x\":4437.03125,\"y\":-4483.28955078125,\"z\":4.30311393737793}', '{\"x\":4434.087890625,\"y\":-4491.11669921875,\"z\":4.2219181060791}', '{\"x\":4420.35888671875,\"y\":-4489.82666015625,\"z\":4.31097316741943}', 0, 0, 'car'),
(78, 'Diamond & Flit', '{\"x\":-874.9222412109375,\"y\":-59.10549545288086,\"z\":38.07644653320312}', '{\"x\":-874.9589233398438,\"y\":-51.25149154663086,\"z\":38.19439697265625}', '{\"x\":-874.1717529296875,\"y\":-55.89319229125976,\"z\":38.1439323425293}', 0, 0, 'car'),
(79, 'La Meute Orga', '{\"x\":2479.556640625,\"y\":4957.75732421875,\"z\":45.0184326171875}', '{\"x\":2467.886962890625,\"y\":4958.66650390625,\"z\":45.09782791137695}', '{\"x\":2487.843017578125,\"y\":4960.6884765625,\"z\":44.8224868774414}', 0, 0, 'car'),
(80, 'ambulance', '{\"x\":276.23016357421877,\"y\":-597.3221435546875,\"z\":43.15167999267578}', '{\"x\":272.90887451171877,\"y\":-589.42333984375,\"z\":43.16426086425781}', '{\"x\":282.15093994140627,\"y\":-581.5462646484375,\"z\":43.26884460449219}', 0, 0, 'car'),
(81, 'Cosa Nostra', '{\"x\":-1785.147705078125,\"y\":453.5050048828125,\"z\":128.30813598632813}', '{\"x\":-1790.5751953125,\"y\":457.0296630859375,\"z\":128.30813598632813}', '{\"x\":-1790.3758544921876,\"y\":462.0968933105469,\"z\":128.30813598632813}', 0, 0, 'car'),
(82, 'loszetas', '{\"x\":16.33405685424804,\"y\":551.6587524414063,\"z\":176.6416473388672}', '{\"x\":9.14996719360351,\"y\":553.4096069335938,\"z\":176.02740478515626}', '{\"x\":1.10470700263977,\"y\":542.7156982421875,\"z\":174.3019256591797}', 0, 0, 'car'),
(83, 'lspd', '{\"x\":457.73602294921877,\"y\":-989.2189331054688,\"z\":25.69981575012207}', '{\"x\":453.6729431152344,\"y\":-991.4322509765625,\"z\":25.69981575012207}', '{\"x\":458.6319274902344,\"y\":-995.5419921875,\"z\":25.69981384277343}', 0, 0, 'car'),
(84, 'Bennys', '{\"x\":-181.95245361328126,\"y\":-1280.6424560546876,\"z\":31.29610443115234}', '{\"x\":-188.80795288085938,\"y\":-1254.2220458984376,\"z\":31.29610443115234}', '{\"x\":-181.69471740722657,\"y\":-1254.563720703125,\"z\":31.29610443115234}', 0, 1, 'car'),
(85, 'Cartel De Cali', '{\"x\":1398.3341064453126,\"y\":1115.1025390625,\"z\":114.83735656738281}', '{\"x\":1412.103759765625,\"y\":1118.5843505859376,\"z\":114.83799743652344}', '{\"x\":1417.10009765625,\"y\":1118.3123779296876,\"z\":114.83797454833985}', 0, 0, 'car'),
(86, 'Al-Quatala', '{\"x\":-134.54457092285157,\"y\":1005.4692993164063,\"z\":235.740478515625}', '{\"x\":-130.4093475341797,\"y\":1004.9445190429688,\"z\":235.73208618164063}', '{\"x\":-124.38693237304688,\"y\":1008.4194946289063,\"z\":235.73208618164063}', 0, 0, 'car'),
(87, 'Bloods', '{\"x\":1370.8740234375,\"y\":-590.2650756835938,\"z\":74.18297576904297}', '{\"x\":1367.0609130859376,\"y\":-581.8388061523438,\"z\":74.38035583496094}', '{\"x\":1383.007080078125,\"y\":-600.20654296875,\"z\":74.33793640136719}', 0, 0, 'car'),
(88, 'Yakuza', '{\"x\":-922.3496704101563,\"y\":211.20533752441407,\"z\":67.46452331542969}', '{\"x\":-932.2182006835938,\"y\":211.1621856689453,\"z\":67.46468353271485}', '{\"x\":-928.27197265625,\"y\":213.07215881347657,\"z\":67.46464538574219}', 0, 0, 'car'),
(89, 'ms13 airship', '{\"x\":-3187.005615234375,\"y\":771.9785766601563,\"z\":3.01697731018066}', '{\"x\":-3190.7578125,\"y\":754.2164916992188,\"z\":2.12710714340209}', '{\"x\":-3190.102294921875,\"y\":747.2960815429688,\"z\":2.05654764175415}', 0, 0, 'aircraft'),
(90, 'Publique', '{\"x\":424.0989990234375,\"y\":-360.4464416503906,\"z\":47.13105392456055}', '{\"x\":426.1334228515625,\"y\":-367.22845458984377,\"z\":47.068115234375}', '{\"x\":433.70916748046877,\"y\":-369.75982666015627,\"z\":47.11236953735351}', 123, 1, 'car');

-- --------------------------------------------------------

--
-- Structure de la table `alma_isdead`
--

CREATE TABLE `alma_isdead` (
  `id` int(25) NOT NULL,
  `license` varchar(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `alma_jail`
--

CREATE TABLE `alma_jail` (
  `jailId` int(11) NOT NULL,
  `identifier` varchar(70) NOT NULL,
  `time` int(11) DEFAULT 0,
  `raison` longtext DEFAULT NULL,
  `update_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `alma_jail`
--

INSERT INTO `alma_jail` (`jailId`, `identifier`, `time`, `raison`, `update_at`) VALUES
(58, 'c9a4f510db6a7f621cd57e41f3cfaf12b035ada2', 7095, 'Troll', '2021-11-11 16:15:36');

-- --------------------------------------------------------

--
-- Structure de la table `alma_logs_commands`
--

CREATE TABLE `alma_logs_commands` (
  `id` bigint(20) NOT NULL,
  `fivem` varchar(50) NOT NULL DEFAULT '0',
  `command` varchar(50) NOT NULL DEFAULT '0',
  `argument` varchar(50) NOT NULL DEFAULT '0',
  `transaction` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `alma_logs_commands`
--

INSERT INTO `alma_logs_commands` (`id`, `fivem`, `command`, `argument`, `transaction`) VALUES
(48, '8', 'addVip', '2', 'vip'),
(49, '1462783', 'addVip', '2', 'vip');

-- --------------------------------------------------------

--
-- Structure de la table `alma_paid_wheel`
--

CREATE TABLE `alma_paid_wheel` (
  `license` varchar(80) NOT NULL,
  `ammount` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `alma_playerlevel`
--

CREATE TABLE `alma_playerlevel` (
  `license` varchar(80) NOT NULL,
  `exp` int(80) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `alma_playerlevel`
--

INSERT INTO `alma_playerlevel` (`license`, `exp`) VALUES
('license:26a6ed6f3c05191b38ca1e3dc57cb349df614329', 900),
('license:3f13c40aebd47edf7899f3e1f82cb44684ecf38f', 200),
('license:556324f99fd7e2ea9ad1fe5542b8d8a1b8470485', 10400),
('license:764fb156dd9475f40df6c98effe8f2c3bf886980', 200),
('license:b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 9000),
('license:c941e05cd8a0733c6e180831b4bf36eb3665165d', 400);

-- --------------------------------------------------------

--
-- Structure de la table `alma_sixt`
--

CREATE TABLE `alma_sixt` (
  `id` int(5) NOT NULL,
  `identifier` varchar(64) DEFAULT NULL,
  `name` varchar(12) DEFAULT NULL,
  `model` varchar(32) DEFAULT NULL,
  `plate` varchar(42) DEFAULT NULL,
  `expiration` int(11) DEFAULT NULL,
  `expired` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `alma_sixt`
--

INSERT INTO `alma_sixt` (`id`, `identifier`, `name`, `model`, `plate`, `expiration`, `expired`) VALUES
(2401, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'Golf Mk7', 'rmodmk7', 'SIXT2401', 1636824878, 1),
(6221, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'Golf Mk7', 'rmodmk7', 'SIXT6221', 1636824928, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `alma_society`
--

CREATE TABLE `alma_society` (
  `id` int(11) NOT NULL,
  `name` longtext NOT NULL,
  `money` varchar(255) NOT NULL,
  `moneysale` varchar(255) NOT NULL,
  `data` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `alma_society`
--

INSERT INTO `alma_society` (`id`, `name`, `money`, `moneysale`, `data`) VALUES
(19, 'yakuza1', '1190644', '185984', '{\"ecstasytraitement\":{\"label\":\"Pochon d\'Ecstasy\",\"count\":43,\"item\":\"ecstasytraitement\"},\"opiumrecolte\":{\"label\":\"Opium\",\"count\":209,\"item\":\"opiumrecolte\"},\"weedtraitement\":{\"label\":\"Pochon de weed\",\"count\":60,\"item\":\"weedtraitement\"},\"beuhrecolte\":{\"label\":\"Beuh\",\"count\":0,\"item\":\"beuhrecolte\"},\"acierrecolte\":{\"label\":\"Acier Brut\",\"count\":7,\"item\":\"acierrecolte\"},\"methtraitement\":{\"label\":\"Pochon de meth\",\"count\":38,\"item\":\"methtraitement\"},\"cocainetraitement\":{\"label\":\"Pochon de coke\",\"count\":9,\"item\":\"cocainetraitement\"},\"aciertraitement\":{\"label\":\"Acier Traiter\",\"count\":70,\"item\":\"aciertraitement\"},\"ecstasyrecolte\":{\"label\":\"Ecstasy\",\"count\":72,\"item\":\"ecstasyrecolte\"},\"opiumtraitement\":{\"label\":\"Pochon d\'opium\",\"count\":49,\"item\":\"opiumtraitement\"}}'),
(21, 'mecano', '1556350', '0', '{\"bread\":{\"label\":\"Pain\",\"count\":59,\"item\":\"bread\"},\"water\":{\"label\":\"Bouteille d\'eau\",\"count\":59,\"item\":\"water\"}}'),
(22, 'mecano1', '221', '0', '[]'),
(23, 'lameute', '20344839', '0', '{\"bandage\":{\"label\":\"Bandage\",\"count\":0,\"item\":\"bandage\"},\"water\":{\"label\":\"Bouteille d\'eau\",\"count\":1,\"item\":\"water\"},\"opiumrecolte\":{\"label\":\"Opium\",\"count\":10,\"item\":\"opiumrecolte\"},\"cocainetraitement\":{\"label\":\"Pochon de coke\",\"count\":0,\"item\":\"cocainetraitement\"},\"clip\":{\"label\":\"Chargeur\",\"count\":0,\"item\":\"clip\"},\"piluleoubli\":{\"label\":\"GHB\",\"count\":0,\"item\":\"piluleoubli\"},\"ecstameutetraitement\":{\"label\":\"Pochon Meute\",\"count\":0,\"item\":\"ecstameutetraitement\"},\"fixkit\":{\"label\":\"Kit réparation\",\"count\":0,\"item\":\"fixkit\"},\"bread\":{\"label\":\"Pain\",\"count\":3,\"item\":\"bread\"},\"ecstameute\":{\"label\":\"Ecstasy Meute\",\"count\":0,\"item\":\"ecstameute\"}}'),
(25, 'jowfarming', '500', '0', '{\"acierrecolte\":{\"label\":\"Acier Brut\",\"count\":1,\"item\":\"acierrecolte\"},\"medikit\":{\"label\":\"Medikit\",\"count\":3,\"item\":\"medikit\"},\"opiumrecolte\":{\"label\":\"Opium\",\"count\":0,\"item\":\"opiumrecolte\"},\"aciertraitement\":{\"label\":\"Acier Traiter\",\"count\":2,\"item\":\"aciertraitement\"},\"basic_key\":{\"label\":\"Clefs de Menottes Basique\",\"count\":0,\"item\":\"basic_key\"},\"jowrecolte\":{\"label\":\"Jow Recolte\",\"count\":0,\"item\":\"jowrecolte\"}}'),
(26, 'blanchimentbma', '22500', '0', '[]'),
(27, 'blanchimentbma', '22500', '0', '[]'),
(28, 'diamond&flit', '12265050', '0', '{\"jowtraitement\":{\"label\":\"Jow Traitement\",\"count\":0,\"item\":\"jowtraitement\"},\"drill\":{\"label\":\"Perceuse ( Braquage )\",\"count\":0,\"item\":\"drill\"},\"redbull\":{\"label\":\"Redbull\",\"count\":0,\"item\":\"redbull\"},\"piluleoubli\":{\"label\":\"GHB\",\"count\":0,\"item\":\"piluleoubli\"},\"opiumrecolte\":{\"label\":\"Opium\",\"count\":0,\"item\":\"opiumrecolte\"},\"bankcard\":{\"label\":\"Clé USB ( Braquage )\",\"count\":0,\"item\":\"bankcard\"},\"basic_key\":{\"label\":\"Clefs de Menottes Basique\",\"count\":0,\"item\":\"basic_key\"},\"jowrecolte\":{\"label\":\"Jow Recolte\",\"count\":0,\"item\":\"jowrecolte\"}}'),
(29, 'ambulance', '6493688', '0', '{\"medikit\":{\"label\":\"Medikit\",\"count\":7,\"item\":\"medikit\"},\"bandage\":{\"label\":\"Bandage\",\"count\":22,\"item\":\"bandage\"}}');

-- --------------------------------------------------------

--
-- Structure de la table `alma_wallet`
--

CREATE TABLE `alma_wallet` (
  `id` int(11) NOT NULL,
  `identifiers` text NOT NULL,
  `transaction` text DEFAULT NULL,
  `price` text NOT NULL,
  `currency` text DEFAULT NULL,
  `points` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `alma_wallet`
--

INSERT INTO `alma_wallet` (`id`, `identifiers`, `transaction`, `price`, `currency`, `points`, `created_at`, `updated_at`) VALUES
(2322, '1462783', 'Capsule de bierre zebi', '100', 'EUR', 20000, '2021-10-25 18:08:19', '2021-10-25 18:08:19'),
(2323, '1462783', 'Achat de : Golf Mk7', '0', 'Points', -2500, '2021-10-26 12:47:14', '2021-10-26 12:47:14'),
(2324, '1462783', 'Achat de : Golf Mk7', '0', 'Points', -2500, '2021-10-26 12:50:07', '2021-10-26 12:50:07'),
(2325, '1462783', 'Achat de : Golf Mk7', '0', 'Points', -2500, '2021-10-26 12:51:56', '2021-10-26 12:51:56'),
(2326, '1462783', 'Achat de : Golf Mk7', '0', 'Points', -2500, '2021-10-26 13:00:12', '2021-10-26 13:00:12'),
(2327, '1462783', 'Achat véhicule Golf Mk7', '0', 'Points', -2500, '2021-10-28 16:16:58', '2021-10-28 16:16:58'),
(2328, '1462783', 'Achat de Pack Illégal', '0', 'Points', -5000, '2021-10-28 16:17:04', '2021-10-28 16:17:04'),
(2329, '1462783', 'Ajout de ModernCoins via la console', '0', 'Points', 30000, '2021-11-01 04:56:13', '2021-11-01 04:56:13'),
(2330, '1462783', 'Achat d\'une caisse (Gold)', '0', 'Points', -1000, '2021-11-01 04:56:21', '2021-11-01 04:56:21'),
(2331, '1462783', 'Achat de Pack Customisation', '0', 'Points', -1000, '2021-11-10 18:22:09', '2021-11-10 18:22:09');

-- --------------------------------------------------------

--
-- Structure de la table `billing`
--

CREATE TABLE `billing` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `sender` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `target_type` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `target` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `items`
--

CREATE TABLE `items` (
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 1,
  `rare` tinyint(4) NOT NULL DEFAULT 0,
  `can_remove` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `items`
--

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('acierrecolte', 'Acier Brut', 1, 0, 1),
('aciertraitement', 'Acier Traiter', 1, 0, 1),
('armor', 'Kevlar', 3, 0, 1),
('bandage', 'Bandage', 0, 0, 1),
('bankcard', 'Clé USB ( Braquage )', 0, 0, 1),
('Barettedeshit', 'Barette de shit', 0, 0, 1),
('basic_cuff', 'Menottes Basique', 0, 0, 1),
('basic_key', 'Clefs de Menottes Basique', 0, 0, 1),
('beer', 'Bière', 0, 0, 1),
('beuhrecolte', 'Beuh', 1, 0, 1),
('beuhtraitement', 'Pochon Beuh', 1, 0, 1),
('blowpipe', 'Chalumeaux', 2, 0, 1),
('bmatraitement', 'BMA traitement', 0, 0, 1),
('bread', 'Pain', 0, 0, 1),
('burger', 'Burger', 0, 0, 1),
('cafe', 'Café Espresso', 0, 0, 1),
('carokit', 'Kit carosserie', 3, 0, 1),
('carotool', 'Outils carosserie', 4, 0, 1),
('chip', 'Jeton', 0, 0, 1),
('cigarette', 'Cigarette', 0, 0, 1),
('clip', 'Chargeur', 0, 0, 1),
('coca', 'Coca', 0, 0, 1),
('cocainerecolte', 'Coke', 1, 0, 1),
('cocainetraitement', 'Pochon de coke', 0, 0, 1),
('cola', 'Cola', 0, 0, 1),
('defibrillateur', 'Défibrillateur', 2, 0, 1),
('Diamant', 'Diamant pure', 0, 0, 1),
('donut', 'Donut', 0, 0, 1),
('dragonballcocktail', 'Dragon ball Cocktail', 5, 0, 1),
('drill', 'Perceuse ( Braquage )', 1, 0, 1),
('duffbeer', 'Duff beer', 5, 0, 1),
('dvrcocktail', 'DVR cocktail', 5, 0, 1),
('ecstameute', 'Ecstasy Meute', 0, 0, 1),
('ecstameutetraitement', 'Pochon Meute', 0, 0, 1),
('ecstasyrecolte', 'Ecstasy', 1, 0, 1),
('ecstasytraitement', 'Pochon d\'Ecstasy', 1, 0, 1),
('feuille_coca', 'Feuille de coca', 1, 0, 1),
('firstaidkit', 'Trousse premier secours', 1, 0, 1),
('fixkit', 'Kit réparation', 2, 0, 1),
('fixtool', 'Outils réparation', 2, 0, 1),
('gazbottle', 'Bouteille de gaz', 2, 0, 1),
('gitanes', 'Gitanes', 0, 0, 1),
('golden_egg', 'Golden Egg', 1, 0, 1),
('grand_cru', 'Grand cru', 0, 0, 1),
('grapperaisin', 'Grappe de raisin', 0, 0, 1),
('handcuff', 'Serre câble ', 0, 0, 1),
('hookah', 'Chicha', 1, 0, 1),
('hotdog', 'Hot-Dog', 0, 0, 1),
('hulkcockail', 'Hulk Cockail', 5, 0, 1),
('ice', 'Glaçon', 0, 0, 1),
('jager', 'Jägermeister', 1, 0, 1),
('jagerbomb', 'Jägermeister', 1, 0, 1),
('jagercerbere', 'Jäger Cerbère', 1, 0, 1),
('jamesbondcocktail', 'Jamesbond Cocktail', 5, 0, 1),
('jewels', 'Jewels', 0, 0, 1),
('jowrecolte', 'Jow Recolte', 0, 0, 1),
('jowtraitement', 'Jow Traitement', 0, 0, 1),
('jumelles', 'Jumelles', 0, 0, 1),
('jus_coca', 'Jus de coca', 1, 0, 1),
('jus_raisin', 'Jus de raisin', 1, 0, 1),
('jusfruit', 'Jus de fruits', 1, 0, 1),
('jusleechi', 'Jus de Leechi', 0, 0, 1),
('laser_drill', 'Laser Drill', 1, 0, 1),
('limonade', 'Limonade', 1, 0, 1),
('lockpick', 'Pied de Biche', 1, 0, 1),
('lsdrecolte', 'LSD', 1, 0, 1),
('lsdtraitement', 'Pochon LSD', 1, 0, 1),
('malbora', 'Malboro', 0, 0, 1),
('martini', 'Martini blanc', 1, 0, 1),
('marvelcocktail', 'Marvel Cocktail', 5, 0, 1),
('meat', 'Viande', 0, 0, 1),
('medikit', 'Medikit', 2, 0, 1),
('menthe', 'Feuille de menthe', 1, 0, 1),
('methrecolte', 'Meth', 1, 0, 1),
('methtraitement', 'Pochon de meth', 0, 0, 1),
('metreshooter', 'Mètre de shooter', 0, 0, 1),
('milkdragon', 'Milk dragon', 5, 0, 1),
('mixapero', 'Mix Apéritif', 0, 0, 1),
('mojito', 'Mojito', 0, 0, 1),
('onepunchman', 'One Punch Man Cocktail', 5, 0, 1),
('opiumrecolte', 'Opium', 0, 0, 1),
('opiumtraitement', 'Pochon d\'opium', 0, 0, 1),
('orange', 'Orange', 0, 0, 1),
('orange_juice', 'Jus d\'orange', 0, 0, 1),
('oxygen_mask', 'Masque à Oxygène', 1, 0, 1),
('patochebeer', 'Capsule Beer', 5, 0, 1),
('peinture_1', 'Peinture de niveau 1', 1, 0, 1),
('peinture_2', 'Peinture de niveau 2', 1, 0, 1),
('peinture_3', 'Peinture de niveau 3', 1, 0, 1),
('pepperspray', 'Gazeuse', 1, 0, -1),
('phone', 'Téléphone', 0, 0, 1),
('pierredediamant', 'Pierre de diamant', 0, 0, 1),
('piluleoubli', 'GHB', 1, 0, 1),
('police_cuff', 'Menottes LSPD', 0, 0, 1),
('police_key', 'Clefs de Menottes LSPD', 0, 0, 1),
('pomme', 'Pomme', 0, 0, 1),
('Poudredecana', 'Poudre de canabis', 0, 0, 1),
('radio', 'Radio', 1, 0, 1),
('raisin', 'Raisin', 0, 0, 1),
('redbull', 'Redbull', 0, 0, 1),
('repairkit', 'Repairkit', 2, 0, 1),
('resinedecannabis', 'Resine de cannabis', 0, 0, 1),
('rhum', 'Rhum', 0, 0, 1),
('rhumcoca', 'Rhum-Coca', 1, 0, 1),
('rhumfruit', 'Rhum-Jus de fruits', 1, 0, 1),
('scarfacecolada', 'Scarface Colada', 5, 0, 1),
('shit', 'Barette de shit', 0, 0, 1),
('tabac', 'Tabac', 1, 0, 1),
('tabacblond', 'Tabac Blond', 1, 0, 1),
('tabacblondsec', 'Tabac Blond Séché', 1, 0, 1),
('tabacbrun', 'Tabac Brun', 1, 0, 1),
('tabacbrunsec', 'Tabac Brun Séché', 1, 0, 1),
('tarte_pomme', 'Tarte aux Pommes', 0, 0, 1),
('teqpaf', 'Teq\'paf', 1, 0, 1),
('tequila', 'Tequila', 1, 0, 1),
('vine', 'Vin', 1, 0, 1),
('vitodaiquiri', 'Vito Daiquiri', 5, 0, 1),
('vittvin', 'Vin Blanc', 1, 0, 1),
('vodka', 'Vodka', 0, 0, 1),
('vodkaenergy', 'Vodka-Energy', 0, 0, 1),
('vodkafruit', 'Vodka-Jus de fruits', 0, 0, 1),
('vodkaredbull', 'Vodka-Redbull', 0, 0, 1),
('water', 'Bouteille d\'eau', 0, 0, 1),
('weedrecolte', 'Weed', 1, 0, 1),
('weedtraitement', 'Pochon de weed', 0, 0, 1),
('whisky', 'Whisky', 0, 0, 1),
('whiskycoca', 'Whisky-coca', 1, 0, 1),
('white_phone', 'Téléphone', 1, 0, 1),
('winch', 'Winch', 1, 0, 1),
('yoshishooter', 'Yoshi shooter', 5, 0, 1),
('zetony', 'Jetons', -1, 0, 1);

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `jobs`
--

INSERT INTO `jobs` (`name`, `label`) VALUES
('ambulance', 'EMS'),
('unemployed', 'Citoyen'),
('unemployed2', 'Citizen');

-- --------------------------------------------------------

--
-- Structure de la table `job_grades`
--

CREATE TABLE `job_grades` (
  `id` int(11) NOT NULL,
  `job_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `skin_female` longtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `job_grades`
--

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(1, 'unemployed', 0, 'unemployed', 'Chômage', 200, '{}', '{}'),
(2, 'ambulance', 0, 'ambulance', 'Ambulancier', 350, '{\"beard_1\":0,\"eye_color\":0,\"makeup_3\":0,\"blemishes_1\":0,\"mask_1\":0,\"glasses_1\":0,\"bproof_2\":0,\"lipstick_3\":0,\"beard_2\":0,\"torso_1\":249,\"pants_1\":24,\"blush_3\":0,\"torso_2\":0,\"blush_2\":0,\"complexion_1\":0,\"lipstick_2\":0,\"makeup_2\":0,\"bproof_1\":0,\"sun_2\":0,\"complexion_2\":0,\"chain_2\":0,\"sun_1\":0,\"eyebrows_3\":0,\"tshirt_1\":94,\"hair_color_1\":0,\"eyebrows_2\":0,\"mask_2\":0,\"helmet_2\":0,\"hair_2\":0,\"beard_3\":0,\"moles_2\":0,\"bags_1\":0,\"arms_2\":0,\"decals_2\":0,\"age_1\":0,\"ears_1\":-1,\"moles_1\":0,\"bracelets_2\":0,\"watches_1\":-1,\"face\":0,\"bags_2\":0,\"pants_2\":5,\"chest_3\":0,\"blemishes_2\":0,\"chest_1\":0,\"hair_color_2\":0,\"blush_1\":0,\"tshirt_2\":0,\"helmet_1\":-1,\"hair_1\":0,\"shoes_2\":0,\"lipstick_4\":0,\"eyebrows_4\":0,\"ears_2\":0,\"watches_2\":0,\"bodyb_2\":0,\"bodyb_1\":0,\"eyebrows_1\":0,\"decals_1\":57,\"makeup_4\":0,\"glasses_2\":0,\"age_2\":0,\"shoes_1\":8,\"arms\":90,\"chain_1\":126,\"bracelets_1\":-1,\"chest_2\":0,\"beard_4\":0,\"makeup_1\":0,\"lipstick_1\":0,\"skin\":0,\"sex\":0}', '{\"age_1\":0,\"blush_3\":0,\"complexion_2\":0,\"bracelets_2\":0,\"chain_2\":0,\"bodyb_1\":0,\"pants_1\":23,\"hair_1\":4,\"lipstick_4\":0,\"bproof_2\":0,\"bodyb_2\":0,\"shoes_2\":1,\"sun_2\":0,\"blush_1\":0,\"shoes_1\":4,\"decals_1\":65,\"eyebrows_2\":10,\"makeup_1\":6,\"glasses\":0,\"chest_3\":0,\"bags_2\":0,\"arms\":105,\"watches_1\":2,\"arms_2\":0,\"hair_color_1\":28,\"beard_3\":0,\"chain_1\":96,\"chest_1\":0,\"mask_1\":0,\"sex\":1,\"decals_2\":0,\"bproof_1\":0,\"hair_color_2\":28,\"eyebrows_3\":61,\"makeup_2\":8,\"helmet_1\":-1,\"bags_1\":0,\"lipstick_3\":23,\"face\":45,\"bracelets_1\":-1,\"tshirt_1\":29,\"beard_4\":0,\"moles_2\":10,\"mask_2\":0,\"helmet_2\":0,\"makeup_3\":25,\"skin\":10,\"beard_2\":0,\"shoes\":1,\"blemishes_2\":0,\"moles_1\":0,\"pants_2\":0,\"complexion_1\":0,\"glasses_2\":1,\"age_2\":0,\"ears_1\":12,\"watches_2\":0,\"eyebrows_4\":0,\"eye_color\":3,\"lipstick_2\":4,\"glasses_1\":11,\"eyebrows_1\":1,\"ears_2\":0,\"makeup_4\":18,\"sun_1\":0,\"blush_2\":0,\"torso_2\":0,\"chest_2\":0,\"hair_2\":0,\"tshirt_2\":0,\"torso_1\":257,\"lipstick_1\":1,\"blemishes_1\":0,\"beard_1\":0}'),
(3, 'ambulance', 1, 'doctor', 'Medecin', 500, '{\"beard_1\":0,\"eye_color\":0,\"makeup_3\":0,\"blemishes_1\":0,\"mask_1\":0,\"glasses_1\":0,\"bproof_2\":0,\"lipstick_3\":0,\"beard_2\":0,\"torso_1\":13,\"pants_1\":24,\"blush_3\":0,\"torso_2\":3,\"blush_2\":0,\"complexion_1\":0,\"lipstick_2\":0,\"makeup_2\":0,\"bproof_1\":0,\"sun_2\":0,\"complexion_2\":0,\"chain_2\":0,\"sun_1\":0,\"eyebrows_3\":0,\"tshirt_1\":15,\"hair_color_1\":0,\"eyebrows_2\":0,\"mask_2\":0,\"helmet_2\":0,\"hair_2\":0,\"beard_3\":0,\"moles_2\":0,\"bags_1\":0,\"arms_2\":0,\"decals_2\":0,\"age_1\":0,\"ears_1\":-1,\"moles_1\":0,\"bracelets_2\":0,\"watches_1\":-1,\"face\":0,\"bags_2\":0,\"pants_2\":5,\"chest_3\":0,\"blemishes_2\":0,\"chest_1\":0,\"hair_color_2\":0,\"blush_1\":0,\"tshirt_2\":0,\"helmet_1\":-1,\"hair_1\":0,\"shoes_2\":9,\"lipstick_4\":0,\"eyebrows_4\":0,\"ears_2\":0,\"watches_2\":0,\"bodyb_2\":0,\"bodyb_1\":0,\"eyebrows_1\":0,\"decals_1\":57,\"makeup_4\":0,\"glasses_2\":0,\"age_2\":0,\"shoes_1\":57,\"arms\":92,\"chain_1\":126,\"bracelets_1\":-1,\"chest_2\":0,\"beard_4\":0,\"makeup_1\":0,\"lipstick_1\":0,\"skin\":0,\"sex\":0}', '{\"age_1\":0,\"blush_3\":0,\"complexion_2\":0,\"bracelets_2\":0,\"chain_2\":0,\"bodyb_1\":0,\"pants_1\":51,\"hair_1\":4,\"lipstick_4\":0,\"bproof_2\":0,\"bodyb_2\":0,\"shoes_2\":7,\"sun_2\":0,\"blush_1\":0,\"shoes_1\":1,\"decals_1\":66,\"eyebrows_2\":10,\"makeup_1\":6,\"glasses\":0,\"chest_3\":0,\"bags_2\":0,\"arms\":106,\"watches_1\":2,\"arms_2\":0,\"hair_color_1\":28,\"beard_3\":0,\"chain_1\":96,\"chest_1\":0,\"mask_1\":0,\"sex\":1,\"decals_2\":0,\"bproof_1\":0,\"hair_color_2\":28,\"eyebrows_3\":61,\"makeup_2\":8,\"helmet_1\":-1,\"bags_1\":0,\"lipstick_3\":23,\"face\":45,\"bracelets_1\":-1,\"tshirt_1\":29,\"beard_4\":0,\"moles_2\":10,\"mask_2\":0,\"helmet_2\":0,\"makeup_3\":25,\"skin\":10,\"beard_2\":0,\"shoes\":1,\"blemishes_2\":0,\"moles_1\":0,\"pants_2\":0,\"complexion_1\":0,\"glasses_2\":1,\"age_2\":0,\"ears_1\":12,\"watches_2\":0,\"eyebrows_4\":0,\"eye_color\":3,\"lipstick_2\":4,\"glasses_1\":11,\"eyebrows_1\":1,\"ears_2\":0,\"makeup_4\":18,\"sun_1\":0,\"blush_2\":0,\"torso_2\":2,\"chest_2\":0,\"hair_2\":0,\"tshirt_2\":0,\"torso_1\":9,\"lipstick_1\":1,\"blemishes_1\":0,\"beard_1\":0}'),
(4, 'ambulance', 2, 'chief_doctor', 'Médecin-Chef', 700, '{\"beard_1\":0,\"eye_color\":0,\"makeup_3\":0,\"blemishes_1\":0,\"mask_1\":0,\"glasses_1\":0,\"bproof_2\":0,\"lipstick_3\":0,\"beard_2\":0,\"torso_1\":250,\"pants_1\":24,\"blush_3\":0,\"torso_2\":0,\"blush_2\":0,\"complexion_1\":0,\"lipstick_2\":0,\"makeup_2\":0,\"bproof_1\":0,\"sun_2\":0,\"complexion_2\":0,\"chain_2\":0,\"sun_1\":0,\"eyebrows_3\":0,\"tshirt_1\":15,\"hair_color_1\":0,\"eyebrows_2\":0,\"mask_2\":0,\"helmet_2\":0,\"hair_2\":0,\"beard_3\":0,\"moles_2\":0,\"bags_1\":0,\"arms_2\":0,\"decals_2\":0,\"age_1\":0,\"ears_1\":-1,\"moles_1\":0,\"bracelets_2\":0,\"watches_1\":-1,\"face\":0,\"bags_2\":0,\"pants_2\":5,\"chest_3\":0,\"blemishes_2\":0,\"chest_1\":0,\"hair_color_2\":0,\"blush_1\":0,\"tshirt_2\":0,\"helmet_1\":-1,\"hair_1\":0,\"shoes_2\":0,\"lipstick_4\":0,\"eyebrows_4\":0,\"ears_2\":0,\"watches_2\":0,\"bodyb_2\":0,\"bodyb_1\":0,\"eyebrows_1\":0,\"decals_1\":57,\"makeup_4\":0,\"glasses_2\":0,\"age_2\":0,\"shoes_1\":26,\"arms\":74,\"chain_1\":126,\"bracelets_1\":-1,\"chest_2\":0,\"beard_4\":0,\"makeup_1\":0,\"lipstick_1\":0,\"skin\":0,\"sex\":0}', '{\"age_1\":0,\"blush_3\":0,\"complexion_2\":0,\"bracelets_2\":0,\"chain_2\":0,\"bodyb_1\":0,\"pants_1\":50,\"hair_1\":4,\"lipstick_4\":0,\"bproof_2\":0,\"bodyb_2\":0,\"shoes_2\":2,\"sun_2\":0,\"blush_1\":0,\"shoes_1\":4,\"decals_1\":66,\"eyebrows_2\":10,\"makeup_1\":6,\"glasses\":0,\"chest_3\":0,\"bags_2\":0,\"arms\":96,\"watches_1\":2,\"arms_2\":0,\"hair_color_1\":28,\"beard_3\":0,\"chain_1\":96,\"chest_1\":0,\"mask_1\":0,\"sex\":1,\"decals_2\":0,\"bproof_1\":0,\"hair_color_2\":28,\"eyebrows_3\":61,\"makeup_2\":8,\"helmet_1\":-1,\"bags_1\":0,\"lipstick_3\":23,\"face\":45,\"bracelets_1\":-1,\"tshirt_1\":29,\"beard_4\":0,\"moles_2\":10,\"mask_2\":0,\"helmet_2\":0,\"makeup_3\":25,\"skin\":10,\"beard_2\":0,\"shoes\":1,\"blemishes_2\":0,\"moles_1\":0,\"pants_2\":0,\"complexion_1\":0,\"glasses_2\":1,\"age_2\":0,\"ears_1\":12,\"watches_2\":0,\"eyebrows_4\":0,\"eye_color\":3,\"lipstick_2\":4,\"glasses_1\":11,\"eyebrows_1\":1,\"ears_2\":0,\"makeup_4\":18,\"sun_1\":0,\"blush_2\":0,\"torso_2\":0,\"chest_2\":0,\"hair_2\":0,\"tshirt_2\":0,\"torso_1\":258,\"lipstick_1\":1,\"blemishes_1\":0,\"beard_1\":0}'),
(5, 'ambulance', 3, 'boss', 'Directeur', 900, '{\"beard_1\":0,\"eye_color\":0,\"makeup_3\":0,\"blemishes_1\":0,\"mask_1\":0,\"glasses_1\":5,\"bproof_2\":0,\"lipstick_3\":0,\"eyebrows_4\":0,\"torso_1\":102,\"pants_1\":24,\"blush_3\":0,\"torso_2\":1,\"blush_2\":0,\"complexion_1\":0,\"lipstick_2\":0,\"makeup_2\":0,\"bproof_1\":35,\"sun_2\":0,\"makeup_4\":0,\"chain_2\":0,\"sun_1\":0,\"eyebrows_3\":0,\"tshirt_1\":72,\"hair_color_1\":14,\"hair_1\":49,\"mask_2\":0,\"helmet_2\":0,\"hair_2\":0,\"beard_3\":0,\"moles_2\":0,\"bags_1\":0,\"arms_2\":0,\"decals_2\":0,\"age_1\":0,\"ears_1\":-1,\"moles_1\":0,\"lipstick_4\":0,\"arms\":75,\"face\":0,\"eyebrows_1\":0,\"pants_2\":5,\"chest_3\":0,\"chest_1\":0,\"bodyb_2\":0,\"beard_2\":0,\"glasses_2\":1,\"tshirt_2\":4,\"helmet_1\":-1,\"blush_1\":0,\"bags_2\":0,\"decals_1\":0,\"watches_1\":1,\"chain_1\":126,\"watches_2\":0,\"bracelets_1\":-1,\"bodyb_1\":0,\"bracelets_2\":0,\"ears_2\":0,\"lipstick_1\":0,\"blemishes_2\":0,\"age_2\":0,\"shoes_2\":1,\"complexion_2\":0,\"shoes_1\":30,\"beard_4\":0,\"chest_2\":0,\"hair_color_2\":0,\"makeup_1\":0,\"eyebrows_2\":0,\"skin\":0,\"sex\":0}', '{\"age_1\":0,\"blush_3\":0,\"complexion_2\":0,\"bracelets_2\":0,\"chain_2\":0,\"bodyb_1\":0,\"pants_1\":51,\"hair_1\":4,\"lipstick_4\":0,\"bproof_2\":0,\"bodyb_2\":0,\"shoes_2\":2,\"sun_2\":0,\"blush_1\":0,\"shoes_1\":81,\"decals_1\":66,\"eyebrows_2\":10,\"makeup_1\":6,\"glasses\":0,\"chest_3\":0,\"bags_2\":0,\"arms\":96,\"watches_1\":2,\"arms_2\":0,\"hair_color_1\":28,\"beard_3\":0,\"chain_1\":96,\"chest_1\":0,\"mask_1\":0,\"sex\":1,\"decals_2\":0,\"bproof_1\":0,\"hair_color_2\":28,\"eyebrows_3\":61,\"makeup_2\":8,\"helmet_1\":-1,\"bags_1\":0,\"lipstick_3\":23,\"face\":45,\"bracelets_1\":-1,\"tshirt_1\":29,\"beard_4\":0,\"moles_2\":10,\"mask_2\":0,\"helmet_2\":0,\"makeup_3\":25,\"skin\":10,\"beard_2\":0,\"shoes\":1,\"blemishes_2\":0,\"moles_1\":0,\"pants_2\":0,\"complexion_1\":0,\"glasses_2\":1,\"age_2\":0,\"ears_1\":12,\"watches_2\":0,\"eyebrows_4\":0,\"eye_color\":3,\"lipstick_2\":4,\"glasses_1\":11,\"eyebrows_1\":1,\"ears_2\":0,\"makeup_4\":18,\"sun_1\":0,\"blush_2\":0,\"torso_2\":2,\"chest_2\":0,\"hair_2\":0,\"tshirt_2\":0,\"torso_1\":14,\"lipstick_1\":1,\"blemishes_1\":0,\"beard_1\":0}'),
(22, 'unemployed2', 0, 'unemployed2', 'Citizen', 1, '', '');

-- --------------------------------------------------------

--
-- Structure de la table `lottery_users`
--

CREATE TABLE `lottery_users` (
  `id` int(11) NOT NULL DEFAULT 0,
  `identifier` varchar(255) NOT NULL,
  `code` int(255) NOT NULL,
  `trix` int(1) NOT NULL DEFAULT 0,
  `date` varchar(255) DEFAULT NULL,
  `datetirage` varchar(255) DEFAULT NULL,
  `timemec` int(255) NOT NULL,
  `gain` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `lottery_users`
--

INSERT INTO `lottery_users` (`id`, `identifier`, `code`, `trix`, `date`, `datetirage`, `timemec`, `gain`) VALUES
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 84141710, 0, '31/10/2021 à 02:11', '01/11/2021', 1635642716, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 90313042, 0, '31/10/2021 à 02:11', '01/11/2021', 1635642718, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 77859157, 0, '31/10/2021 à 02:11', '01/11/2021', 1635642719, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 13983832, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642731, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 76765950, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642733, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 65511067, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642735, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 97824435, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642736, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 60224066, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642739, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 52262369, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642742, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 44463433, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642743, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 55919053, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642745, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 67230902, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642746, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 88932291, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642748, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 34486219, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642750, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 33148871, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642751, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 84800889, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642753, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 15028211, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642754, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 40104166, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642755, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 81434461, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642757, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 71782769, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642758, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 99009874, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642760, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 20903862, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642762, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 27099609, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642763, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 56201171, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642764, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 91403537, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642765, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 21530490, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642766, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 25301106, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642768, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 83048502, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642769, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 59179687, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642771, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 79657660, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642772, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 91720920, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642773, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 30316840, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642774, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 15459526, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642775, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 14651150, 0, '31/10/2021 à 02:12', '01/11/2021', 1635642777, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 82741970, 0, '31/10/2021 à 02:15', '01/11/2021', 1635642935, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 38720703, 0, '31/10/2021 à 02:15', '01/11/2021', 1635642940, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 91826714, 0, '31/10/2021 à 02:15', '01/11/2021', 1635642941, NULL),
(0, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 55962456, 0, '31/10/2021 à 02:15', '01/11/2021', 1635642942, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `open_car`
--

CREATE TABLE `open_car` (
  `id` int(11) NOT NULL,
  `owner` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `plate` varchar(8) COLLATE utf8mb4_bin DEFAULT NULL,
  `NB` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Déchargement des données de la table `open_car`
--

INSERT INTO `open_car` (`id`, `owner`, `plate`, `NB`) VALUES
(2, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'BERL585', 0),
(3, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'PNBU622', 0),
(7, '556324f99fd7e2ea9ad1fe5542b8d8a1b8470485', 'FIWT646', 0),
(8, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'FQYQ768', 0),
(9, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'RMEQ996', 0),
(10, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'HWST642', 0),
(11, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'LNGO263', 0),
(13, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'HVFN779', 0),
(14, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'FEBR114', 0),
(15, '556324f99fd7e2ea9ad1fe5542b8d8a1b8470485', 'SNKN192', 0),
(16, '556324f99fd7e2ea9ad1fe5542b8d8a1b8470485', 'YJYP898', 0),
(17, '2575ac82da3a12b33e52ffe48dc63ca6efe2f3db', 'OVTS631', 0),
(18, '2575ac82da3a12b33e52ffe48dc63ca6efe2f3db', 'CASM552', 0),
(20, 'caefce36f70c17d9bee7c766d271fbce0199419d', 'VOVL746', 0),
(21, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'IBBK752', 0),
(22, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'CUIA327', 0),
(23, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'QBGA462', 0),
(24, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'SRIS339', 0),
(25, '26a6ed6f3c05191b38ca1e3dc57cb349df614329', 'ROBP636', 0),
(26, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', '69VYX930', 0),
(27, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'PZUG113', 0),
(28, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'JAAF749', 0),
(29, '3339e6215337f29d2b77b311702a80f2c9637dc6', 'HLSC117', 0),
(30, 'a58642a034203259f2574eed4f43d83f46979553', 'NJRF951', 0),
(31, 'ac7c1ae563dc1234e69bdc206d49c677eff23097', 'ZCIM766', 0),
(32, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'NZLG538', 0),
(33, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'RUGL963', 0),
(34, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'XNXW562', 0),
(37, '3411b72cb47c10d8d78026ee46ea5d09843e0685', 'NYPU753', 0),
(38, 'c9a4f510db6a7f621cd57e41f3cfaf12b035ada2', 'BRWE582', 0),
(39, '055eec09e035d3567b7ba2691d04851ab243a107', 'PXCL977', 0),
(40, '764fb156dd9475f40df6c98effe8f2c3bf886980', 'WRUT333', 0),
(41, 'c941e05cd8a0733c6e180831b4bf36eb3665165d', 'CNWP281', 0),
(42, '3f13c40aebd47edf7899f3e1f82cb44684ecf38f', 'KANR898', 0);

-- --------------------------------------------------------

--
-- Structure de la table `owned_vehicles`
--

CREATE TABLE `owned_vehicles` (
  `owner` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `plate` varchar(12) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `vehicle` longtext COLLATE utf8mb4_bin NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'car',
  `state` tinyint(1) NOT NULL DEFAULT 0,
  `boutique` tinyint(1) DEFAULT 0,
  `selling` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Déchargement des données de la table `owned_vehicles`
--

INSERT INTO `owned_vehicles` (`owner`, `plate`, `label`, `vehicle`, `type`, `state`, `boutique`, `selling`) VALUES
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'HMME517', 'Golf Mk7', '{\"model\":-1222347999,\"plate\":\"HMME517\"}', 'car', 0, 1, 0),
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'CSGI215', 'Golf Mk7', '{\"model\":-1222347999,\"plate\":\"CSGI215\"}', 'car', 0, 1, 0),
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'MPQA144', 'Golf Mk7', '{\"model\":-1222347999,\"plate\":\"MPQA144\"}', 'car', 0, 1, 0),
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'BERL585', 'Véhicule particuliers', '{\"modHydrolic\":-1,\"pearlescentColor\":3,\"modTrimA\":-1,\"modVanityPlate\":-1,\"engineHealth\":1000.0,\"fuelLevel\":65.0,\"modSmokeEnabled\":1,\"modRoof\":-1,\"modTank\":-1,\"modHorns\":14,\"modSuspension\":-1,\"modDial\":-1,\"modStruts\":-1,\"neonColor\":[255,0,255],\"modSpeakers\":-1,\"modXenon\":1,\"plate\":\"BERL585\",\"modRearBumper\":1,\"modAirFilter\":-1,\"color1\":12,\"modTurbo\":1,\"modEngineBlock\":-1,\"modTrimB\":-1,\"wheels\":0,\"modSeats\":-1,\"modSideSkirt\":-1,\"dirtLevel\":4.0,\"modFrontBumper\":1,\"wheelColor\":0,\"modAerials\":-1,\"modWindows\":-1,\"tyreSmokeColor\":[255,255,255],\"modTrunk\":-1,\"modRightFender\":-1,\"extras\":[],\"modLivery\":-1,\"modFender\":-1,\"modFrontWheels\":21,\"neonEnabled\":[1,1,1,1],\"tankHealth\":998.4,\"modFrame\":-1,\"modPlateHolder\":-1,\"modArchCover\":-1,\"modBackWheels\":-1,\"modDoorSpeaker\":-1,\"xenonColor\":255,\"plateIndex\":1,\"modGrille\":-1,\"modHood\":1,\"color2\":12,\"modOrnaments\":-1,\"modEngine\":3,\"modShifterLeavers\":-1,\"modAPlate\":-1,\"windowTint\":5,\"bodyHealth\":984.2,\"modTransmission\":2,\"modArmor\":-1,\"modDashboard\":-1,\"modExhaust\":1,\"modSpoilers\":-1,\"model\":1663218586,\"modSteeringWheel\":-1,\"modBrakes\":2}', 'car', 0, 0, 1),
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'RMMI383', 'Golf Mk7', '{\"model\":-1222347999,\"plate\":\"RMMI383\"}', 'car', 0, 1, 0),
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'PNBU622', 'Starter Legal', '{\"plate\":\"PNBU622\",\"model\":-431692672}', 'car', 0, 0, 0),
('556324f99fd7e2ea9ad1fe5542b8d8a1b8470485', 'FIWT646', 'Starter Business', '{\"plate\":\"FIWT646\",\"model\":86520421}', 'car', 0, 0, 0),
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'FQYQ768', 'Véhicule particuliers', '{\"plate\":\"FQYQ768\",\"model\":-431692672}', 'car', 1, 0, 1),
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'HVFN779', NULL, '{\"model\":-391594584,\"plate\":\"HVFN779\"}', 'car', 0, 0, 0),
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'FEBR114', NULL, '{\"plate\":\"FEBR114\",\"model\":-624529134}', 'car', 0, 0, 0),
('556324f99fd7e2ea9ad1fe5542b8d8a1b8470485', 'SNKN192', NULL, '{\"model\":-344943009,\"plate\":\"SNKN192\"}', 'car', 0, 0, 0),
('556324f99fd7e2ea9ad1fe5542b8d8a1b8470485', 'YJYP898', NULL, '{\"plate\":\"YJYP898\",\"model\":-344943009}', 'car', 0, 0, 0),
('2575ac82da3a12b33e52ffe48dc63ca6efe2f3db', 'OVTS631', 'Starter Business', '{\"model\":86520421,\"plate\":\"OVTS631\"}', 'car', 0, 0, 1),
('2575ac82da3a12b33e52ffe48dc63ca6efe2f3db', 'CASM552', NULL, '{\"model\":-344943009,\"plate\":\"CASM552\"}', 'car', 0, 0, 0),
('caefce36f70c17d9bee7c766d271fbce0199419d', 'VOVL746', 'Starter Business', '{\"model\":86520421,\"plate\":\"VOVL746\"}', 'car', 0, 0, 0),
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'IBBK752', NULL, '{\"plate\":\"IBBK752\",\"model\":-624529134}', 'car', 0, 0, 0),
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'CUIA327', 'Véhicule particuliers', '{\"model\":1581459400,\"plate\":\"CUIA327\"}', 'car', 0, 0, 1),
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'QBGA462', NULL, '{\"plate\":\"QBGA462\",\"model\":-511601230}', 'car', 0, 0, 0),
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'SRIS339', 'Véhicule particuliers', '{\"model\":-391594584,\"plate\":\"SRIS339\"}', 'car', 0, 0, 0),
('26a6ed6f3c05191b38ca1e3dc57cb349df614329', 'ROBP636', 'Starter Business', '{\"model\":86520421,\"plate\":\"ROBP636\"}', 'car', 0, 0, 0),
('26a6ed6f3c05191b38ca1e3dc57cb349df614329', 'EDYU642', NULL, '{\"model\":-344943009,\"plate\":\"EDYU642\"}', 'car', 0, 0, 0),
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'PZUG113', NULL, '{\"model\":-624529134,\"plate\":\"PZUG113\"}', 'car', 0, 0, 1),
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'JAAF749', NULL, '{\"model\":-391594584,\"plate\":\"JAAF749\"}', 'car', 0, 0, 0),
('3339e6215337f29d2b77b311702a80f2c9637dc6', 'HLSC117', 'Starter Business', '{\"model\":86520421,\"plate\":\"HLSC117\"}', 'car', 0, 0, 0),
('a58642a034203259f2574eed4f43d83f46979553', 'NJRF951', 'Starter Business', '{\"model\":86520421,\"plate\":\"NJRF951\"}', 'car', 1, 0, 0),
('ac7c1ae563dc1234e69bdc206d49c677eff23097', 'ZCIM766', 'Starter Illegal', '{\"modSpeakers\":-1,\"modTrunk\":-1,\"modFrame\":-1,\"modDoorSpeaker\":-1,\"model\":1753414259,\"modFender\":-1,\"modAPlate\":-1,\"modXenon\":false,\"windowTint\":-1,\"neonColor\":[255,0,255],\"modHydrolic\":-1,\"modRoof\":-1,\"modHorns\":-1,\"modSuspension\":-1,\"modWindows\":-1,\"bodyHealth\":1000.0,\"neonEnabled\":[false,false,false,false],\"modFrontWheels\":-1,\"modStruts\":-1,\"modPlateHolder\":-1,\"modHood\":-1,\"modSpoilers\":-1,\"tyreSmokeColor\":[255,255,255],\"modSteeringWheel\":-1,\"modArmor\":-1,\"xenonColor\":255,\"modRearBumper\":-1,\"modArchCover\":-1,\"modShifterLeavers\":-1,\"modBrakes\":-1,\"modSeats\":-1,\"modEngine\":-1,\"modTransmission\":-1,\"color1\":4,\"modSmokeEnabled\":false,\"color2\":0,\"modTank\":-1,\"engineHealth\":1000.0,\"modGrille\":-1,\"wheels\":6,\"plateIndex\":0,\"extras\":[],\"modTrimB\":-1,\"wheelColor\":156,\"modTrimA\":-1,\"modEngineBlock\":-1,\"modFrontBumper\":-1,\"modTurbo\":false,\"modDashboard\":-1,\"tankHealth\":1000.0,\"plate\":\"ZCIM766\",\"modSideSkirt\":-1,\"modBackWheels\":-1,\"modAirFilter\":-1,\"modDial\":-1,\"modAerials\":-1,\"fuelLevel\":65.0,\"modRightFender\":-1,\"dirtLevel\":8.0,\"modExhaust\":-1,\"modVanityPlate\":-1,\"modOrnaments\":-1,\"pearlescentColor\":111,\"modLivery\":-1}', 'car', 0, 0, 0),
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'NZLG538', NULL, '{\"plate\":\"NZLG538\",\"model\":-114291515}', 'car', 0, 0, 0),
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'RUGL963', NULL, '{\"plate\":\"RUGL963\",\"model\":-624529134}', 'car', 0, 0, 0),
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'XNXW562', NULL, '{\"plate\":\"XNXW562\",\"model\":330661258}', 'car', 0, 0, 0),
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'SIXT2401', 'SIXT', '{\"model\":-1222347999,\"plate\":\"SIXT2401\"}', 'car', 1, 0, 0),
('b3ac67bb27e84fcb6c5ce99861be6487f27333fb', 'SIXT6221', 'SIXT', '{\"plate\":\"SIXT6221\",\"model\":-1222347999}', 'car', 1, 0, 0),
('3411b72cb47c10d8d78026ee46ea5d09843e0685', 'NYPU753', 'Starter Business', '{\"plate\":\"NYPU753\",\"model\":86520421}', 'car', 0, 0, 0),
('c9a4f510db6a7f621cd57e41f3cfaf12b035ada2', 'BRWE582', 'Starter Illegal', '{\"plate\":\"BRWE582\",\"model\":1753414259}', 'car', 0, 0, 0),
('055eec09e035d3567b7ba2691d04851ab243a107', 'PXCL977', 'Starter Illegal', '{\"model\":1753414259,\"plate\":\"PXCL977\"}', 'car', 0, 0, 0),
('764fb156dd9475f40df6c98effe8f2c3bf886980', 'WRUT333', 'Starter Illegal', '{\"plate\":\"WRUT333\",\"model\":1753414259}', 'car', 0, 0, 0),
('c941e05cd8a0733c6e180831b4bf36eb3665165d', 'CNWP281', 'Starter Business', '{\"model\":86520421,\"plate\":\"CNWP281\"}', 'car', 1, 0, 0),
('3f13c40aebd47edf7899f3e1f82cb44684ecf38f', 'KANR898', 'Starter Illegal', '{\"plate\":\"KANR898\",\"model\":1753414259}', 'car', 1, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `identifier` varchar(65) COLLATE utf8mb4_unicode_ci NOT NULL,
  `steam` bit(1) DEFAULT NULL,
  `accounts` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'user',
  `inventory` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `job` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `job2` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unemployed2',
  `job2_grade` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `loadout` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '{"x":-269.4,"y":-955.3,"z":31.2,"heading":205.8}',
  `skin` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firstname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `sex` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateofbirth` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_dead` tinyint(1) DEFAULT 0,
  `society` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `starter` text COLLATE utf8mb4_unicode_ci DEFAULT 'new'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `identifier`, `steam`, `accounts`, `group`, `inventory`, `job`, `job_grade`, `job2`, `job2_grade`, `loadout`, `position`, `skin`, `status`, `firstname`, `lastname`, `size`, `height`, `sex`, `dateofbirth`, `is_dead`, `society`, `starter`) VALUES
(20, 'b3ac67bb27e84fcb6c5ce99861be6487f27333fb', NULL, '{\"money\":22600,\"bank\":21714800,\"black_money\":0}', 'fondateur', '[]', 'unemployed', 0, 'unemployed2', '0', '{\"WEAPON_PISTOL\":{\"ammo\":200}}', '{\"z\":22.9,\"y\":-1150.6,\"x\":-215.8,\"heading\":25.5}', '{\"eyebrows_5\":0,\"bracelets_1\":-1,\"lipstick_1\":0,\"moles_2\":0,\"ears_2\":0,\"bproof_2\":0,\"pants_1\":12,\"mom\":21,\"jaw_1\":0,\"neck_thickness\":0,\"chest_2\":0,\"blush_3\":0,\"chest_3\":0,\"tshirt_1\":111,\"blemishes_2\":0,\"jaw_2\":0,\"watches_2\":0,\"bproof_1\":0,\"eye_squint\":0,\"chain_2\":0,\"nose_2\":0,\"bracelets_2\":0,\"sun_2\":0,\"lip_thickness\":0,\"blush_1\":0,\"lipstick_4\":0,\"cheeks_2\":0,\"blush_2\":0,\"shoes_1\":5,\"nose_1\":0,\"eyebrows_3\":0,\"chest_1\":0,\"beard_3\":0,\"hair_color_1\":0,\"torso_2\":2,\"torso_1\":5,\"chin_1\":0,\"helmet_1\":-1,\"face_md_weight\":50,\"skin_md_weight\":50,\"complexion_2\":0,\"bodyb_1\":-1,\"lipstick_2\":0,\"hair_1\":1,\"dad\":0,\"decals_1\":0,\"hair_color_2\":0,\"mask_2\":0,\"shoes_2\":0,\"tshirt_2\":0,\"pants_2\":0,\"arms\":5,\"helmet_2\":0,\"sun_1\":0,\"chin_3\":0,\"eyebrows_2\":0,\"mask_1\":0,\"ears_1\":-1,\"decals_2\":0,\"hair_2\":0,\"eye_color\":0,\"eyebrows_6\":0,\"sex\":0,\"beard_4\":0,\"nose_6\":0,\"makeup_1\":0,\"cheeks_3\":0,\"bodyb_4\":0,\"makeup_4\":0,\"nose_4\":0,\"complexion_1\":0,\"bags_1\":0,\"age_1\":0,\"eyebrows_1\":0,\"bags_2\":0,\"glasses_1\":0,\"arms_2\":0,\"chin_4\":0,\"nose_3\":0,\"watches_1\":-1,\"cheeks_1\":0,\"chin_2\":0,\"makeup_2\":0,\"nose_5\":0,\"bodyb_2\":0,\"eyebrows_4\":0,\"blemishes_1\":0,\"lipstick_3\":0,\"makeup_3\":0,\"beard_2\":0,\"chain_1\":0,\"glasses_2\":0,\"bodyb_3\":-1,\"age_2\":0,\"beard_1\":0,\"moles_1\":0}', NULL, 'Louis', 'Debusac', NULL, 183, 'm', '09/09/1990', 0, NULL, 'legal'),
(21, '556324f99fd7e2ea9ad1fe5542b8d8a1b8470485', NULL, '{\"bank\":32300,\"black_money\":0,\"money\":0}', 'fondateur', '[]', 'unemployed', 0, 'unemployed2', '0', '{\"weapon_revolver_mk2\":{\"ammo\":300},\"weapon_pumpshotgun\":{\"ammo\":300}}', '{\"z\":534.7,\"y\":5539.4,\"x\":267.0,\"heading\":26.8}', '{\"lipstick_3\":0,\"hair_2\":0,\"lipstick_2\":0,\"cheeks_1\":0,\"glasses_2\":0,\"moles_2\":0,\"arms\":5,\"beard_1\":28,\"decals_1\":0,\"watches_2\":0,\"beard_4\":0,\"shoes_2\":0,\"hair_1\":71,\"jaw_2\":0,\"ears_2\":0,\"mom\":1,\"sun_1\":0,\"neck_thickness\":0,\"nose_5\":0,\"makeup_4\":0,\"ears_1\":-1,\"cheeks_2\":0,\"watches_1\":-1,\"complexion_2\":0,\"makeup_2\":0,\"chain_1\":0,\"makeup_1\":0,\"complexion_1\":0,\"helmet_1\":-1,\"bodyb_4\":0,\"skin_md_weight\":1.0,\"tshirt_2\":0,\"chain_2\":0,\"blemishes_1\":0,\"chest_3\":0,\"blush_1\":0,\"pants_2\":0,\"bracelets_1\":-1,\"torso_1\":5,\"jaw_1\":0,\"chin_3\":0,\"nose_1\":0,\"glasses_1\":0,\"lip_thickness\":0,\"eyebrows_4\":0,\"bags_1\":0,\"bracelets_2\":0,\"helmet_2\":0,\"sun_2\":0,\"eye_color\":21,\"age_1\":0,\"beard_2\":3,\"bproof_2\":0,\"bodyb_1\":-1,\"hair_color_1\":6,\"makeup_3\":0,\"bproof_1\":0,\"eyebrows_3\":0,\"lipstick_1\":0,\"chin_4\":0,\"nose_2\":0,\"age_2\":0,\"mask_2\":0,\"bodyb_2\":0,\"sex\":0,\"arms_2\":0,\"moles_1\":0,\"torso_2\":2,\"eyebrows_2\":0,\"eye_squint\":0,\"dad\":0,\"beard_3\":5,\"nose_3\":0,\"tshirt_1\":111,\"blush_3\":0,\"nose_4\":0,\"eyebrows_6\":0,\"eyebrows_5\":0,\"shoes_1\":5,\"bags_2\":0,\"nose_6\":0,\"mask_1\":0,\"pants_1\":12,\"hair_color_2\":0,\"lipstick_4\":0,\"blemishes_2\":0,\"chin_2\":0,\"eyebrows_1\":1,\"face_md_weight\":0.0,\"cheeks_3\":0,\"blush_2\":0,\"chin_1\":0,\"decals_2\":0,\"chest_1\":0,\"chest_2\":0,\"bodyb_3\":-1}', NULL, 'AAAA', 'BBBB', NULL, 180, 'm', 'JJ/MM/AAAA', 0, NULL, 'business'),
(23, 'caefce36f70c17d9bee7c766d271fbce0199419d', NULL, '{\"bank\":31700,\"black_money\":0,\"money\":0}', 'admin', '[]', 'unemployed', 0, 'unemployed2', '0', '{\"WEAPON_PISTOL\":{\"ammo\":500}}', '{\"z\":66.6,\"heading\":56.8,\"x\":1950.0,\"y\":1735.0}', '{\"helmet_1\":-1,\"helmet_2\":0,\"cheeks_3\":0,\"age_2\":0,\"watches_2\":0,\"lipstick_1\":0,\"decals_2\":0,\"hair_color_1\":0,\"lip_thickness\":0,\"bags_2\":0,\"chin_2\":0,\"pants_2\":0,\"bproof_1\":0,\"bodyb_3\":-1,\"blemishes_1\":0,\"bodyb_4\":0,\"glasses_1\":0,\"chin_3\":0,\"makeup_4\":0,\"nose_1\":0,\"makeup_3\":0,\"mask_1\":0,\"complexion_2\":0,\"skin_md_weight\":0.0,\"shoes_1\":0,\"blush_3\":0,\"bracelets_1\":-1,\"torso_1\":0,\"chest_3\":0,\"makeup_2\":0,\"age_1\":0,\"beard_3\":0,\"hair_color_2\":0,\"blush_2\":0,\"chain_2\":0,\"hair_1\":0,\"mask_2\":0,\"watches_1\":-1,\"bags_1\":0,\"eyebrows_6\":0,\"eyebrows_1\":0,\"lipstick_3\":0,\"dad\":23,\"blemishes_2\":0,\"sun_1\":0,\"bracelets_2\":0,\"chin_1\":0,\"jaw_1\":0,\"lipstick_2\":0,\"ears_2\":0,\"jaw_2\":0,\"eyebrows_2\":0,\"chest_2\":0,\"decals_1\":0,\"chest_1\":0,\"tshirt_2\":0,\"arms\":0,\"chain_1\":0,\"eyebrows_5\":0,\"eye_squint\":0,\"glasses_2\":0,\"nose_5\":0,\"ears_1\":-1,\"moles_2\":0,\"eyebrows_3\":0,\"eye_color\":0,\"makeup_1\":0,\"eyebrows_4\":0,\"shoes_2\":0,\"chin_4\":0,\"cheeks_1\":0,\"sun_2\":0,\"complexion_1\":0,\"bproof_2\":0,\"pants_1\":0,\"torso_2\":0,\"nose_3\":0,\"nose_2\":0,\"moles_1\":0,\"tshirt_1\":0,\"bodyb_2\":0,\"blush_1\":0,\"nose_4\":0,\"beard_4\":0,\"face_md_weight\":100,\"beard_2\":0,\"neck_thickness\":0,\"arms_2\":0,\"lipstick_4\":0,\"cheeks_2\":0,\"hair_2\":0,\"bodyb_1\":-1,\"nose_6\":0,\"mom\":20,\"sex\":0,\"beard_1\":0}', NULL, '~r~Indéfini', 'Mathiotte', NULL, 132, 'm', '04/06/1995', 0, NULL, 'business'),
(24, '26a6ed6f3c05191b38ca1e3dc57cb349df614329', NULL, '{\"money\":0,\"bank\":3023000,\"black_money\":0}', 'fondateur', '[]', 'unemployed', 0, 'unemployed2', '0', '{\"weapon_carbinerifle\":{\"ammo\":300}}', '{\"y\":-430.9,\"x\":-231.1,\"heading\":213.8,\"z\":31.0}', '{\"beard_4\":0,\"nose_4\":0,\"mom\":21,\"mask_2\":0,\"face_md_weight\":50,\"eyebrows_2\":0,\"torso_1\":5,\"hair_1\":0,\"cheeks_1\":0,\"dad\":0,\"chin_1\":0,\"lipstick_3\":0,\"blush_3\":0,\"bproof_1\":0,\"cheeks_3\":0,\"pants_2\":0,\"helmet_1\":-1,\"hair_color_1\":0,\"nose_5\":0,\"chest_3\":0,\"eyebrows_4\":0,\"bodyb_3\":-1,\"makeup_4\":0,\"chin_2\":0,\"skin_md_weight\":50,\"torso_2\":2,\"moles_1\":0,\"chain_2\":0,\"ears_1\":-1,\"decals_2\":0,\"shoes_2\":0,\"mask_1\":0,\"beard_1\":0,\"bproof_2\":0,\"lip_thickness\":0,\"jaw_2\":0,\"glasses_2\":0,\"chain_1\":0,\"chin_4\":0,\"jaw_1\":0,\"bodyb_2\":0,\"bags_2\":0,\"watches_2\":0,\"watches_1\":-1,\"glasses_1\":0,\"beard_2\":0,\"complexion_1\":0,\"bracelets_2\":0,\"helmet_2\":0,\"eye_color\":0,\"eyebrows_1\":0,\"beard_3\":0,\"hair_2\":0,\"nose_3\":0,\"nose_2\":0,\"eyebrows_6\":0,\"ears_2\":0,\"eyebrows_5\":0,\"sex\":0,\"tshirt_2\":0,\"chest_2\":0,\"bags_1\":0,\"eyebrows_3\":0,\"chin_3\":0,\"tshirt_1\":111,\"makeup_1\":0,\"blemishes_1\":0,\"blush_1\":0,\"lipstick_1\":0,\"lipstick_4\":0,\"lipstick_2\":0,\"eye_squint\":0,\"makeup_3\":0,\"blemishes_2\":0,\"arms\":5,\"makeup_2\":0,\"cheeks_2\":0,\"pants_1\":12,\"moles_2\":0,\"neck_thickness\":0,\"shoes_1\":5,\"blush_2\":0,\"nose_6\":0,\"arms_2\":0,\"hair_color_2\":0,\"age_2\":0,\"bodyb_4\":0,\"bracelets_1\":-1,\"age_1\":0,\"chest_1\":0,\"sun_1\":0,\"complexion_2\":0,\"bodyb_1\":-1,\"decals_1\":0,\"nose_1\":0,\"sun_2\":0}', NULL, 'Yobro', 'Salope', NULL, 180, 'm', '18/11/1987', 0, NULL, 'business'),
(25, '3339e6215337f29d2b77b311702a80f2c9637dc6', NULL, '{\"money\":0,\"black_money\":0,\"bank\":32800}', 'gf', '[]', 'unemployed', 0, 'unemployed2', '0', '[]', '{\"heading\":241.9,\"z\":45.7,\"y\":2595.6,\"x\":1860.0}', '{\"face_md_weight\":50,\"hair_2\":0,\"torso_1\":75,\"hair_color_2\":0,\"sun_2\":0,\"beard_1\":0,\"decals_2\":0,\"bodyb_3\":-1,\"jaw_1\":0,\"eyebrows_3\":0,\"cheeks_1\":0,\"eyebrows_2\":0,\"lipstick_1\":0,\"tshirt_1\":14,\"bags_1\":0,\"blemishes_1\":0,\"moles_1\":0,\"age_1\":0,\"blush_3\":0,\"nose_6\":0,\"chest_2\":0,\"pants_2\":0,\"hair_color_1\":12,\"blush_2\":0,\"eye_squint\":0,\"mask_2\":0,\"bodyb_1\":-1,\"bracelets_1\":-1,\"lipstick_2\":0,\"hair_1\":4,\"skin_md_weight\":50,\"lipstick_3\":0,\"eyebrows_5\":0,\"pants_1\":27,\"bodyb_2\":0,\"sex\":1,\"eye_color\":0,\"ears_2\":0,\"bproof_2\":0,\"bags_2\":0,\"glasses_1\":0,\"shoes_1\":3,\"nose_2\":0,\"eyebrows_4\":0,\"shoes_2\":9,\"beard_3\":0,\"chest_1\":0,\"bproof_1\":0,\"makeup_2\":0,\"mom\":6,\"ears_1\":-1,\"complexion_2\":0,\"makeup_3\":0,\"moles_2\":0,\"neck_thickness\":0,\"chain_2\":0,\"nose_1\":0,\"lip_thickness\":0,\"makeup_1\":0,\"decals_1\":0,\"bodyb_4\":0,\"arms_2\":0,\"tshirt_2\":0,\"watches_1\":-1,\"nose_4\":0,\"torso_2\":2,\"eyebrows_6\":0,\"nose_3\":0,\"lipstick_4\":0,\"chain_1\":0,\"glasses_2\":0,\"chin_4\":0,\"chest_3\":0,\"age_2\":0,\"makeup_4\":0,\"helmet_2\":0,\"beard_2\":0,\"chin_3\":0,\"eyebrows_1\":0,\"arms\":9,\"bracelets_2\":0,\"cheeks_2\":0,\"mask_1\":0,\"blush_1\":0,\"chin_2\":0,\"blemishes_2\":0,\"dad\":15,\"jaw_2\":0,\"helmet_1\":-1,\"nose_5\":0,\"chin_1\":0,\"cheeks_3\":0,\"watches_2\":0,\"beard_4\":0,\"complexion_1\":0,\"sun_1\":0}', NULL, 'Jean', 'Neymar', NULL, 185, 'm', '30/04/1995', 0, NULL, 'business'),
(26, 'a58642a034203259f2574eed4f43d83f46979553', NULL, '{\"black_money\":0,\"bank\":30400,\"money\":0}', 'fondateur', '[]', 'unemployed', 0, 'unemployed2', '0', '[]', '{\"y\":-911.3,\"z\":30.7,\"heading\":285.3,\"x\":208.0}', '{\"chin_4\":0,\"hair_2\":0,\"torso_1\":0,\"bags_2\":0,\"sun_2\":0,\"beard_1\":0,\"decals_2\":0,\"bodyb_3\":-1,\"jaw_1\":0,\"eyebrows_3\":0,\"cheeks_1\":0,\"beard_2\":0,\"lipstick_1\":0,\"tshirt_1\":0,\"bags_1\":0,\"blemishes_1\":0,\"moles_1\":0,\"age_1\":0,\"eye_color\":0,\"nose_4\":0,\"chest_2\":0,\"pants_2\":0,\"hair_color_1\":0,\"blush_2\":0,\"moles_2\":0,\"mask_2\":0,\"bodyb_1\":-1,\"bracelets_1\":-1,\"lipstick_2\":0,\"hair_1\":0,\"skin_md_weight\":50,\"lipstick_3\":0,\"eyebrows_5\":0,\"pants_1\":0,\"bodyb_2\":0,\"blush_3\":0,\"helmet_1\":-1,\"ears_2\":0,\"bproof_2\":0,\"nose_1\":0,\"glasses_1\":0,\"sun_1\":0,\"cheeks_2\":0,\"eyebrows_4\":0,\"chest_3\":0,\"mask_1\":0,\"chest_1\":0,\"bproof_1\":0,\"makeup_2\":0,\"mom\":21,\"ears_1\":-1,\"eyebrows_1\":0,\"watches_1\":-1,\"glasses_2\":0,\"nose_6\":0,\"chain_2\":0,\"tshirt_2\":0,\"lip_thickness\":0,\"face_md_weight\":50,\"neck_thickness\":0,\"bodyb_4\":0,\"arms_2\":0,\"makeup_3\":0,\"age_2\":0,\"shoes_2\":0,\"torso_2\":0,\"eyebrows_6\":0,\"nose_3\":0,\"makeup_1\":0,\"chain_1\":0,\"hair_color_2\":0,\"blemishes_2\":0,\"shoes_1\":0,\"decals_1\":0,\"makeup_4\":0,\"cheeks_3\":0,\"helmet_2\":0,\"complexion_1\":0,\"sex\":0,\"arms\":0,\"bracelets_2\":0,\"eyebrows_2\":0,\"nose_2\":0,\"chin_3\":0,\"chin_2\":0,\"beard_3\":0,\"dad\":0,\"jaw_2\":0,\"blush_1\":0,\"nose_5\":0,\"chin_1\":0,\"lipstick_4\":0,\"watches_2\":0,\"beard_4\":0,\"eye_squint\":0,\"complexion_2\":0}', NULL, 'AAA', 'QQQ', NULL, 180, 'm', 'JJ/MM/AAAA', 0, NULL, 'business'),
(27, 'ac7c1ae563dc1234e69bdc206d49c677eff23097', NULL, '{\"money\":0,\"black_money\":8725000,\"bank\":10700}', 'gf', '[]', 'unemployed', 0, 'unemployed2', '0', '{\"weapon_assaultrifle_mk2\":{\"ammo\":300},\"weapon_hominglauncher\":{\"ammo\":300},\"weapon_carbinerifle\":{\"ammo\":300},\"WEAPON_BAT\":{\"ammo\":1},\"weapon_specialcarbine\":{\"ammo\":300},\"weapon_pumpshotgun_mk2\":{\"ammo\":300},\"weapon_grenade\":{\"ammo\":300},\"weapon_appistol\":{\"ammo\":300},\"weapon_combatpdw\":{\"ammo\":300},\"weapon_raycarbine\":{\"ammo\":300},\"weapon_marksmanrifle_mk2\":{\"ammo\":300},\"weapon_compactrifle\":{\"ammo\":300},\"weapon_minigun\":{\"ammo\":300},\"weapon_heavysniper_mk2\":{\"ammo\":300},\"weapon_carbinerifle_mk2\":{\"ammo\":300},\"weapon_proxmine\":{\"ammo\":300},\"weapon_stickybomb\":{\"ammo\":300},\"weapon_sawnoffshotgun\":{\"ammo\":300},\"weapon_combatpistol\":{\"ammo\":300},\"weapon_pumpshotgun\":{\"ammo\":300},\"weapon_pistol50\":{\"ammo\":300},\"weapon_autoshotgun\":{\"ammo\":300},\"weapon_combatmg\":{\"ammo\":300},\"weapon_gadgetpistol\":{\"ammo\":300},\"weapon_marksmanrifle\":{\"ammo\":300}}', '{\"z\":29.3,\"heading\":26.8,\"x\":79.1,\"y\":-1364.9}', '{\"decals_1\":0,\"arms_2\":0,\"watches_2\":0,\"beard_2\":0,\"helmet_1\":-1,\"torso_2\":2,\"lipstick_1\":0,\"tshirt_1\":15,\"glasses_1\":0,\"beard_4\":0,\"lipstick_3\":0,\"chain_1\":0,\"ears_1\":-1,\"chest_2\":0,\"complexion_1\":0,\"sex\":0,\"moles_1\":0,\"glasses_2\":0,\"jaw_1\":0,\"decals_2\":0,\"chain_2\":0,\"arms\":1,\"mom\":21,\"bodyb_4\":0,\"mask_2\":0,\"bracelets_2\":0,\"bracelets_1\":-1,\"nose_6\":0,\"makeup_3\":0,\"eyebrows_4\":0,\"nose_2\":0,\"chest_3\":0,\"bproof_2\":0,\"sun_1\":0,\"cheeks_3\":0,\"cheeks_2\":0,\"chin_2\":0,\"beard_1\":0,\"eye_color\":1,\"face_md_weight\":50,\"lip_thickness\":0,\"moles_2\":0,\"bodyb_1\":-1,\"hair_1\":4,\"shoes_2\":0,\"chin_4\":0,\"eyebrows_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"bags_2\":0,\"nose_5\":0,\"blush_1\":0,\"complexion_2\":0,\"makeup_4\":0,\"skin_md_weight\":50,\"blemishes_1\":0,\"bodyb_3\":-1,\"lipstick_2\":0,\"torso_1\":86,\"dad\":0,\"eyebrows_5\":0,\"makeup_2\":0,\"chin_1\":0,\"age_1\":0,\"eyebrows_3\":0,\"nose_4\":0,\"makeup_1\":0,\"pants_1\":9,\"chest_1\":0,\"eyebrows_1\":0,\"neck_thickness\":0,\"sun_2\":0,\"beard_3\":0,\"blemishes_2\":0,\"age_2\":0,\"nose_3\":0,\"lipstick_4\":0,\"jaw_2\":0,\"tshirt_2\":0,\"shoes_1\":7,\"blush_2\":0,\"hair_color_2\":0,\"eye_squint\":0,\"blush_3\":0,\"bodyb_2\":0,\"watches_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"pants_2\":7,\"mask_1\":0,\"nose_1\":0,\"ears_2\":0,\"cheeks_1\":0,\"hair_2\":0,\"chin_3\":0,\"eyebrows_6\":0}', NULL, 'nail', 'rachid ', NULL, 200, 'm', '07/11/2000', 0, NULL, 'illegal'),
(28, '3411b72cb47c10d8d78026ee46ea5d09843e0685', NULL, '{\"money\":0,\"black_money\":0,\"bank\":34300}', 'helper', '[]', 'unemployed', 0, 'unemployed2', '0', '{\"weapon_advancedrifle\":{\"ammo\":300},\"weapon_combatpistol\":{\"ammo\":300},\"weapon_pumpshotgun\":{\"ammo\":300},\"weapon_snspistol_mk2\":{\"ammo\":300},\"weapon_smg\":{\"ammo\":300},\"weapon_revolver\":{\"ammo\":300},\"weapon_stickybomb\":{\"ammo\":300}}', '{\"z\":5.6,\"heading\":323.3,\"x\":-1368.5,\"y\":6737.7}', '{\"decals_2\":0,\"bodyb_4\":0,\"eyebrows_3\":0,\"shoes_2\":0,\"lipstick_1\":0,\"eye_color\":1,\"helmet_1\":-1,\"cheeks_1\":0,\"tshirt_2\":0,\"neck_thickness\":0,\"chain_1\":0,\"sex\":0,\"eyebrows_6\":0,\"nose_6\":0,\"beard_1\":15,\"hair_1\":68,\"hair_2\":0,\"shoes_1\":5,\"tshirt_1\":111,\"hair_color_1\":61,\"decals_1\":0,\"jaw_2\":0,\"chin_4\":0,\"moles_1\":0,\"nose_4\":0,\"bodyb_2\":0,\"bproof_2\":0,\"chest_2\":0,\"torso_2\":2,\"skin_md_weight\":50,\"complexion_1\":0,\"chin_1\":0,\"pants_2\":0,\"nose_1\":0,\"bracelets_1\":-1,\"watches_1\":-1,\"watches_2\":0,\"arms\":5,\"pants_1\":12,\"sun_2\":0,\"makeup_2\":0,\"mask_2\":0,\"mom\":8,\"lipstick_3\":0,\"arms_2\":0,\"lip_thickness\":0,\"bags_1\":0,\"complexion_2\":0,\"nose_5\":0,\"ears_1\":-1,\"ears_2\":0,\"eye_squint\":0,\"eyebrows_4\":0,\"blemishes_2\":0,\"hair_color_2\":63,\"bodyb_1\":-1,\"bags_2\":0,\"chest_3\":0,\"nose_2\":0,\"eyebrows_1\":5,\"bproof_1\":0,\"glasses_1\":0,\"torso_1\":5,\"blush_1\":0,\"lipstick_4\":0,\"face_md_weight\":50,\"blemishes_1\":0,\"cheeks_3\":0,\"dad\":8,\"bracelets_2\":0,\"age_1\":0,\"makeup_3\":0,\"eyebrows_2\":0,\"jaw_1\":0,\"lipstick_2\":0,\"glasses_2\":0,\"beard_3\":5,\"makeup_4\":0,\"mask_1\":0,\"blush_3\":0,\"helmet_2\":0,\"sun_1\":0,\"bodyb_3\":-1,\"moles_2\":0,\"beard_4\":0,\"cheeks_2\":0,\"blush_2\":0,\"chin_3\":0,\"nose_3\":0,\"beard_2\":5,\"chin_2\":0,\"age_2\":0,\"chest_1\":0,\"chain_2\":0,\"eyebrows_5\":0,\"makeup_1\":0}', NULL, 'Hamid', 'Boualem', NULL, 200, 'm', '20/05/1990', 0, NULL, 'business'),
(29, 'c9a4f510db6a7f621cd57e41f3cfaf12b035ada2', NULL, '{\"money\":5000,\"black_money\":25000,\"bank\":2100}', 'user', '[]', 'unemployed', 0, 'unemployed2', '0', '{\"weapon_snspistol_mk2\":{\"ammo\":300},\"weapon_bat\":{\"ammo\":300},\"weapon_smg\":{\"ammo\":300}}', '{\"z\":49.9,\"heading\":72.8,\"x\":1783.2,\"y\":2493.5}', '{\"mask_2\":0,\"torso_1\":86,\"ears_1\":-1,\"shoes_2\":0,\"lipstick_1\":0,\"glasses_1\":0,\"moles_1\":0,\"cheeks_1\":0,\"tshirt_2\":0,\"neck_thickness\":0,\"chain_1\":0,\"sex\":0,\"eyebrows_6\":0,\"nose_6\":0,\"beard_1\":10,\"hair_1\":2,\"hair_2\":0,\"nose_2\":0,\"tshirt_1\":15,\"hair_color_1\":1,\"decals_1\":0,\"blemishes_2\":0,\"chin_4\":0,\"jaw_2\":0,\"nose_4\":0,\"bodyb_2\":0,\"bproof_2\":0,\"makeup_3\":0,\"torso_2\":2,\"skin_md_weight\":50,\"cheeks_2\":0,\"arms\":1,\"pants_2\":7,\"helmet_1\":-1,\"bracelets_1\":-1,\"watches_1\":-1,\"eye_color\":0,\"makeup_2\":0,\"eyebrows_3\":0,\"sun_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"mom\":21,\"lipstick_3\":0,\"chest_2\":0,\"lip_thickness\":0,\"dad\":0,\"complexion_2\":0,\"nose_5\":0,\"bodyb_3\":-1,\"watches_2\":0,\"eye_squint\":0,\"blush_3\":0,\"chin_1\":0,\"hair_color_2\":2,\"bracelets_2\":0,\"bags_2\":0,\"chin_3\":0,\"sun_1\":0,\"eyebrows_1\":0,\"pants_1\":9,\"chest_3\":0,\"bags_1\":0,\"beard_3\":0,\"lipstick_4\":0,\"face_md_weight\":50,\"blemishes_1\":0,\"cheeks_3\":0,\"decals_2\":0,\"complexion_1\":0,\"age_1\":0,\"age_2\":0,\"ears_2\":0,\"jaw_1\":0,\"bodyb_4\":0,\"glasses_2\":0,\"chain_2\":0,\"makeup_4\":0,\"mask_1\":0,\"blush_1\":0,\"helmet_2\":0,\"lipstick_2\":0,\"nose_1\":0,\"moles_2\":0,\"beard_4\":0,\"bproof_1\":0,\"blush_2\":0,\"bodyb_1\":-1,\"nose_3\":0,\"beard_2\":4,\"chin_2\":0,\"shoes_1\":7,\"eyebrows_5\":0,\"arms_2\":0,\"chest_1\":0,\"makeup_1\":0}', NULL, 'john', 'djazairie', NULL, 180, 'm', '27/07/1991', 0, NULL, 'illegal'),
(30, '055eec09e035d3567b7ba2691d04851ab243a107', NULL, '{\"money\":5000,\"black_money\":25000,\"bank\":400}', 'gf', '[]', 'unemployed', 0, 'unemployed2', '0', '[]', '{\"heading\":304.1,\"z\":30.4,\"y\":-1205.2,\"x\":59.7}', '{\"mask_2\":0,\"torso_1\":0,\"eyebrows_3\":0,\"shoes_2\":0,\"lipstick_1\":0,\"eye_color\":0,\"helmet_1\":-1,\"cheeks_1\":0,\"tshirt_2\":0,\"neck_thickness\":0,\"chain_1\":0,\"sex\":0,\"eyebrows_6\":0,\"nose_6\":0,\"beard_1\":0,\"hair_1\":0,\"hair_2\":0,\"shoes_1\":0,\"tshirt_1\":0,\"hair_color_1\":0,\"decals_1\":0,\"blemishes_2\":0,\"chin_4\":0,\"arms\":0,\"watches_2\":0,\"bodyb_2\":0,\"bproof_2\":0,\"nose_4\":0,\"age_2\":0,\"skin_md_weight\":50,\"bracelets_1\":-1,\"decals_2\":0,\"pants_2\":0,\"moles_2\":0,\"bags_1\":0,\"makeup_2\":0,\"lipstick_2\":0,\"bags_2\":0,\"watches_1\":-1,\"sun_2\":0,\"chin_3\":0,\"bodyb_3\":-1,\"mom\":21,\"lipstick_3\":0,\"eyebrows_4\":0,\"lip_thickness\":0,\"ears_2\":0,\"complexion_2\":0,\"chain_2\":0,\"glasses_1\":0,\"complexion_1\":0,\"eye_squint\":0,\"blush_3\":0,\"age_1\":0,\"hair_color_2\":0,\"bodyb_1\":-1,\"dad\":1,\"chest_3\":0,\"bodyb_4\":0,\"eyebrows_1\":0,\"nose_5\":0,\"jaw_2\":0,\"bracelets_2\":0,\"jaw_1\":0,\"lipstick_4\":0,\"face_md_weight\":50,\"blemishes_1\":0,\"cheeks_3\":0,\"ears_1\":-1,\"beard_3\":0,\"arms_2\":0,\"nose_2\":0,\"eyebrows_2\":0,\"blush_1\":0,\"cheeks_2\":0,\"glasses_2\":0,\"moles_1\":0,\"makeup_4\":0,\"mask_1\":0,\"pants_1\":0,\"helmet_2\":0,\"sun_1\":0,\"nose_1\":0,\"chest_2\":0,\"beard_4\":0,\"bproof_1\":0,\"blush_2\":0,\"chin_1\":0,\"nose_3\":0,\"beard_2\":0,\"chin_2\":0,\"eyebrows_5\":0,\"chest_1\":0,\"makeup_3\":0,\"torso_2\":0,\"makeup_1\":0}', NULL, 'Zk', 'test', NULL, 180, 'm', '10/11/1997', 0, NULL, 'illegal');

-- --------------------------------------------------------

--
-- Structure de la table `vehicles_sales`
--

CREATE TABLE `vehicles_sales` (
  `id` int(11) NOT NULL,
  `seller` varchar(50) NOT NULL,
  `seller_name` varchar(50) NOT NULL,
  `name` text NOT NULL,
  `description` text NOT NULL,
  `price` int(90) NOT NULL DEFAULT 0,
  `vehicle` longtext NOT NULL,
  `expire_at` int(11) NOT NULL DEFAULT 0,
  `formatted_expire_at` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `alma_accounts`
--
ALTER TABLE `alma_accounts`
  ADD PRIMARY KEY (`steam`);

--
-- Index pour la table `alma_ammunation`
--
ALTER TABLE `alma_ammunation`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `alma_ban`
--
ALTER TABLE `alma_ban`
  ADD PRIMARY KEY (`id_ban`);

--
-- Index pour la table `alma_commands`
--
ALTER TABLE `alma_commands`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `alma_daywheel`
--
ALTER TABLE `alma_daywheel`
  ADD PRIMARY KEY (`license`);

--
-- Index pour la table `alma_entreprise`
--
ALTER TABLE `alma_entreprise`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `alma_garage`
--
ALTER TABLE `alma_garage`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `alma_isdead`
--
ALTER TABLE `alma_isdead`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `alma_jail`
--
ALTER TABLE `alma_jail`
  ADD PRIMARY KEY (`jailId`);

--
-- Index pour la table `alma_logs_commands`
--
ALTER TABLE `alma_logs_commands`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `alma_paid_wheel`
--
ALTER TABLE `alma_paid_wheel`
  ADD PRIMARY KEY (`license`);

--
-- Index pour la table `alma_playerlevel`
--
ALTER TABLE `alma_playerlevel`
  ADD PRIMARY KEY (`license`);

--
-- Index pour la table `alma_sixt`
--
ALTER TABLE `alma_sixt`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `alma_society`
--
ALTER TABLE `alma_society`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `alma_wallet`
--
ALTER TABLE `alma_wallet`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `job_grades`
--
ALTER TABLE `job_grades`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `open_car`
--
ALTER TABLE `open_car`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `vehicles_sales`
--
ALTER TABLE `vehicles_sales`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `alma_ammunation`
--
ALTER TABLE `alma_ammunation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `alma_ban`
--
ALTER TABLE `alma_ban`
  MODIFY `id_ban` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `alma_commands`
--
ALTER TABLE `alma_commands`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `alma_entreprise`
--
ALTER TABLE `alma_entreprise`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `alma_garage`
--
ALTER TABLE `alma_garage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT pour la table `alma_isdead`
--
ALTER TABLE `alma_isdead`
  MODIFY `id` int(25) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4865;

--
-- AUTO_INCREMENT pour la table `alma_jail`
--
ALTER TABLE `alma_jail`
  MODIFY `jailId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT pour la table `alma_logs_commands`
--
ALTER TABLE `alma_logs_commands`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT pour la table `alma_society`
--
ALTER TABLE `alma_society`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT pour la table `alma_wallet`
--
ALTER TABLE `alma_wallet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2332;

--
-- AUTO_INCREMENT pour la table `job_grades`
--
ALTER TABLE `job_grades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT pour la table `open_car`
--
ALTER TABLE `open_car`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT pour la table `vehicles_sales`
--
ALTER TABLE `vehicles_sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- ALMA V2 SQL