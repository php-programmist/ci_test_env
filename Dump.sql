SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Структура таблицы `comments`
--

CREATE TABLE `comments` (
  `id` int(10) UNSIGNED NOT NULL,
  `news_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `comments`
--

INSERT INTO `comments` (`id`, `news_id`, `user_id`, `text`, `created_at`) VALUES
  (1, 8, 1, 'test text', '2019-04-25 07:04:51'),
  (2, 1, 1, 'test text', '2019-04-26 06:10:00'),
  (3, 8, 1, 'тест', '2019-04-26 07:28:45'),
  (4, 8, 1, 'тест2', '2019-04-26 07:29:20'),
  (5, 8, 1, 'тест3', '2019-04-26 07:30:05'),
  (6, 8, 1, 'т3', '2019-04-26 07:31:04'),
  (7, 8, 1, 'т4', '2019-04-26 07:35:05'),
  (8, 8, 1, 'т5', '2019-04-26 07:38:21'),
  (9, 1, 1, 't8', '2019-04-26 08:02:52'),
  (10, 3, 1, 'жирный', '2019-04-26 08:03:53');

-- --------------------------------------------------------

--
-- Структура таблицы `likes`
--

CREATE TABLE `likes` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `entity_id` int(10) UNSIGNED NOT NULL,
  `entity_type` enum('news','comments') NOT NULL DEFAULT 'news',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `likes`
--

INSERT INTO `likes` (`id`, `user_id`, `entity_id`, `entity_type`, `created_at`) VALUES
  (8, 1, 8, 'news', '2019-04-26 06:33:52'),
  (9, 1, 1, 'comments', '2019-04-26 07:10:50'),
  (11, 1, 9, 'comments', '2019-04-26 08:02:56'),
  (12, 1, 10, 'comments', '2019-04-26 08:03:58'),
  (13, 1, 3, 'news', '2019-04-26 08:05:47');

-- --------------------------------------------------------

--
-- Структура таблицы `news`
--

CREATE TABLE `news` (
  `id` int(11) UNSIGNED NOT NULL,
  `header` varchar(1024) DEFAULT NULL,
  `short_description` varchar(2048) DEFAULT NULL,
  `text` text,
  `img` varchar(1024) DEFAULT NULL,
  `tags` varchar(1024) DEFAULT NULL,
  `status` enum('open','closed') DEFAULT 'open',
  `time_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `time_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `views` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `news`
--

INSERT INTO `news` (`id`, `header`, `short_description`, `text`, `img`, `tags`, `status`, `time_created`, `time_updated`, `views`) VALUES
  (1, 'News #1', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore \' +\n            \'et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip\' +\n            \' ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu \' +\n            \'fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt \' +\n            \'mollit anim id est laborum.', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore \' +\n            \'et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip\' +\n            \' ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu \' +\n            \'fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt \' +\n            \'mollit anim id est laborum.', 'http://placehold.it/750x300', 'кек,чебурек', 'open', '2018-08-30 13:31:14', '2019-04-26 08:02:39', 1),
  (3, 'Эх, чужд кайф, сплющь', '<p>Широкая электрификация южных губерний даст мощный толчок подъёму сельского хозяйства.<br></p>', '<<<<<<<p>Эй, жлоб! Где туз? Прячь юных <u><b>съёмщиц</b></u> в шкаф. Съешь [же] ещё этих мягких <span style=\"background-color: rgb(255, 255, 0);\">французских</span> булок да выпей чаю. В чащах юга жил бы цитрус? Да, но фальшивый экземпляр! Эх, чужак! Общий съём <a href=\"#\" target=\"_blank\">цен</a> шляп (юфть) — вдрызг!<br></p>', 'http://placehold.it/750x300', NULL, 'open', '2018-10-11 01:33:27', '2019-04-26 08:05:25', 3),
  (4, 'News #3', '\r\n\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ac elit non erat pellentesque bibendum. Pellentesque rutrum id enim in viverra. Aenean lacinia sodales dolor. Morbi leo ex, ornare vitae metus viverra, elementum gravida ex. Suspendisse potenti. Suspendisse ullamcorper, nunc non ullamcorper dictum, dolor nunc scelerisque elit, sit amet pretium libero metus ut ipsum. Aliquam sed convallis tortor. Aenean in enim eu nisi mattis posuere quis nec quam. Nunc turpis orci, pharetra in consequat sed, congue vitae turpis. Pellentesque suscipit enim orci, vulputate dictum felis euismod quis. Vivamus posuere laoreet aliquet. Duis gravida volutpat velit vitae lacinia. Vestibulum sagittis vehicula leo et auctor. Quisque ultricies mi mi, eget pretium metus euismod a.\r\n\r\nNulla at eros molestie, congue risus a, pulvinar sapien. Mauris aliquet sed metus in auctor. Maecenas tempus, magna eget mollis egestas, arcu elit iaculis orci, eget volutpat risus sem sed mi. Nunc aliquet non quam sit amet dictum. Nullam id suscipit dui. Sed condimentum vulputate justo ac elementum. Donec at est felis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer vel tristique enim. ', '\r\n\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor tortor velit. Nunc placerat velit sed justo maximus, at mollis velit faucibus. Etiam id rutrum lorem. Praesent venenatis sem id nulla placerat tempor. Quisque tincidunt, velit et congue accumsan, felis urna rhoncus sapien, ac vehicula ante erat id purus. Maecenas aliquet tempor ex in lobortis. Morbi in sodales est. Sed pellentesque ex in nulla porttitor tincidunt. Donec placerat imperdiet libero, vitae laoreet leo vestibulum non. Donec at facilisis tellus. Nam nisi ligula, varius in volutpat eu, egestas vel leo. Aliquam erat volutpat.\r\n\r\nAliquam pharetra justo quis arcu sollicitudin ullamcorper. Sed ut ex porttitor, auctor arcu quis, ultrices libero. Donec a fermentum diam. In luctus diam at sem tincidunt viverra. Aenean nec condimentum nunc. Sed hendrerit quis nisl eu gravida. Sed consequat nunc eros, sed bibendum tortor rhoncus quis. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla facilisi. Quisque urna urna, auctor eu enim vehicula, efficitur semper sapien. In non nulla eu libero laoreet rutrum ac mattis lorem. Nullam id tempor libero, nec dapibus risus. Nam vel metus tempus, imperdiet augue et, rutrum lectus. Sed dictum magna purus, id convallis eros laoreet quis.\r\n\r\nNulla auctor risus non elit hendrerit aliquam. Duis fermentum nec quam pulvinar eleifend. Etiam tempor sagittis leo in malesuada. Aliquam est velit, porttitor et eros laoreet, dignissim sagittis erat. Sed sed quam enim. Vivamus iaculis tristique arcu, et egestas ipsum sagittis in. Maecenas sit amet sagittis quam. Fusce sed nisi arcu. Aenean vitae ex quis lectus egestas hendrerit ut ac velit. Nam sit amet mauris commodo, pulvinar urna ut, molestie mi. Quisque quis congue quam, at condimentum odio. Vestibulum feugiat, magna ac congue viverra, turpis tellus pretium tellus, ac lobortis odio mauris non ex.\r\n\r\nMauris in volutpat ex, at molestie metus. Mauris est lorem, ullamcorper vitae sollicitudin et, volutpat eget dolor. Nam dui felis, ornare suscipit ipsum eget, aliquet facilisis lorem. Suspendisse tincidunt commodo mi, ut mollis lacus luctus quis. Proin accumsan varius odio et euismod. Nunc blandit, leo ac scelerisque ornare, sapien eros pellentesque arcu, a congue dui sem eu diam. Fusce odio eros, iaculis sit amet dapibus eget, fermentum id mi.\r\n\r\nFusce eget rutrum diam, ac fringilla nibh. Ut non luctus erat. Fusce pharetra, urna et tincidunt imperdiet, urna dolor convallis dolor, at scelerisque urna dolor ac magna. Sed eget sapien cursus, commodo sem vel, tristique eros. Nunc augue ligula, dignissim in venenatis quis, mollis a lacus. Nunc semper lobortis blandit. Aliquam semper ac odio a malesuada. Duis eleifend consequat commodo. Maecenas pulvinar libero at sodales gravida. Integer eget urna augue. Donec porttitor ac turpis eget viverra. Cras at arcu accumsan, ultricies mi quis, suscipit elit. Nulla quis odio consectetur, pharetra nulla eu, lacinia diam. Praesent urna enim, ornare at urna vitae, consequat consequat diam. Proin eu mollis eros. Nullam eget ipsum at metus scelerisque semper vitae quis neque. ', 'http://placehold.it/750x300', NULL, 'open', '2019-04-23 17:40:13', '2019-04-26 04:19:22', 0),
  (5, 'News #4', '\r\n\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ac elit non erat pellentesque bibendum. Pellentesque rutrum id enim in viverra. Aenean lacinia sodales dolor. Morbi leo ex, ornare vitae metus viverra, elementum gravida ex. Suspendisse potenti. Suspendisse ullamcorper, nunc non ullamcorper dictum, dolor nunc scelerisque elit, sit amet pretium libero metus ut ipsum. Aliquam sed convallis tortor. Aenean in enim eu nisi mattis posuere quis nec quam. Nunc turpis orci, pharetra in consequat sed, congue vitae turpis. Pellentesque suscipit enim orci, vulputate dictum felis euismod quis. Vivamus posuere laoreet aliquet. Duis gravida volutpat velit vitae lacinia. Vestibulum sagittis vehicula leo et auctor. Quisque ultricies mi mi, eget pretium metus euismod a.\r\n\r\nNulla at eros molestie, congue risus a, pulvinar sapien. Mauris aliquet sed metus in auctor. Maecenas tempus, magna eget mollis egestas, arcu elit iaculis orci, eget volutpat risus sem sed mi. Nunc aliquet non quam sit amet dictum. Nullam id suscipit dui. Sed condimentum vulputate justo ac elementum. Donec at est felis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer vel tristique enim. ', '\r\n\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor tortor velit. Nunc placerat velit sed justo maximus, at mollis velit faucibus. Etiam id rutrum lorem. Praesent venenatis sem id nulla placerat tempor. Quisque tincidunt, velit et congue accumsan, felis urna rhoncus sapien, ac vehicula ante erat id purus. Maecenas aliquet tempor ex in lobortis. Morbi in sodales est. Sed pellentesque ex in nulla porttitor tincidunt. Donec placerat imperdiet libero, vitae laoreet leo vestibulum non. Donec at facilisis tellus. Nam nisi ligula, varius in volutpat eu, egestas vel leo. Aliquam erat volutpat.\r\n\r\nAliquam pharetra justo quis arcu sollicitudin ullamcorper. Sed ut ex porttitor, auctor arcu quis, ultrices libero. Donec a fermentum diam. In luctus diam at sem tincidunt viverra. Aenean nec condimentum nunc. Sed hendrerit quis nisl eu gravida. Sed consequat nunc eros, sed bibendum tortor rhoncus quis. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla facilisi. Quisque urna urna, auctor eu enim vehicula, efficitur semper sapien. In non nulla eu libero laoreet rutrum ac mattis lorem. Nullam id tempor libero, nec dapibus risus. Nam vel metus tempus, imperdiet augue et, rutrum lectus. Sed dictum magna purus, id convallis eros laoreet quis.\r\n\r\nNulla auctor risus non elit hendrerit aliquam. Duis fermentum nec quam pulvinar eleifend. Etiam tempor sagittis leo in malesuada. Aliquam est velit, porttitor et eros laoreet, dignissim sagittis erat. Sed sed quam enim. Vivamus iaculis tristique arcu, et egestas ipsum sagittis in. Maecenas sit amet sagittis quam. Fusce sed nisi arcu. Aenean vitae ex quis lectus egestas hendrerit ut ac velit. Nam sit amet mauris commodo, pulvinar urna ut, molestie mi. Quisque quis congue quam, at condimentum odio. Vestibulum feugiat, magna ac congue viverra, turpis tellus pretium tellus, ac lobortis odio mauris non ex.\r\n\r\nMauris in volutpat ex, at molestie metus. Mauris est lorem, ullamcorper vitae sollicitudin et, volutpat eget dolor. Nam dui felis, ornare suscipit ipsum eget, aliquet facilisis lorem. Suspendisse tincidunt commodo mi, ut mollis lacus luctus quis. Proin accumsan varius odio et euismod. Nunc blandit, leo ac scelerisque ornare, sapien eros pellentesque arcu, a congue dui sem eu diam. Fusce odio eros, iaculis sit amet dapibus eget, fermentum id mi.\r\n\r\nFusce eget rutrum diam, ac fringilla nibh. Ut non luctus erat. Fusce pharetra, urna et tincidunt imperdiet, urna dolor convallis dolor, at scelerisque urna dolor ac magna. Sed eget sapien cursus, commodo sem vel, tristique eros. Nunc augue ligula, dignissim in venenatis quis, mollis a lacus. Nunc semper lobortis blandit. Aliquam semper ac odio a malesuada. Duis eleifend consequat commodo. Maecenas pulvinar libero at sodales gravida. Integer eget urna augue. Donec porttitor ac turpis eget viverra. Cras at arcu accumsan, ultricies mi quis, suscipit elit. Nulla quis odio consectetur, pharetra nulla eu, lacinia diam. Praesent urna enim, ornare at urna vitae, consequat consequat diam. Proin eu mollis eros. Nullam eget ipsum at metus scelerisque semper vitae quis neque. ', 'http://placehold.it/750x300', NULL, 'open', '2019-04-23 17:40:13', '2019-04-26 04:19:22', 0),
  (6, 'News #5', '\r\n\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ac elit non erat pellentesque bibendum. Pellentesque rutrum id enim in viverra. Aenean lacinia sodales dolor. Morbi leo ex, ornare vitae metus viverra, elementum gravida ex. Suspendisse potenti. Suspendisse ullamcorper, nunc non ullamcorper dictum, dolor nunc scelerisque elit, sit amet pretium libero metus ut ipsum. Aliquam sed convallis tortor. Aenean in enim eu nisi mattis posuere quis nec quam. Nunc turpis orci, pharetra in consequat sed, congue vitae turpis. Pellentesque suscipit enim orci, vulputate dictum felis euismod quis. Vivamus posuere laoreet aliquet. Duis gravida volutpat velit vitae lacinia. Vestibulum sagittis vehicula leo et auctor. Quisque ultricies mi mi, eget pretium metus euismod a.\r\n\r\nNulla at eros molestie, congue risus a, pulvinar sapien. Mauris aliquet sed metus in auctor. Maecenas tempus, magna eget mollis egestas, arcu elit iaculis orci, eget volutpat risus sem sed mi. Nunc aliquet non quam sit amet dictum. Nullam id suscipit dui. Sed condimentum vulputate justo ac elementum. Donec at est felis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer vel tristique enim. ', '\r\n\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor tortor velit. Nunc placerat velit sed justo maximus, at mollis velit faucibus. Etiam id rutrum lorem. Praesent venenatis sem id nulla placerat tempor. Quisque tincidunt, velit et congue accumsan, felis urna rhoncus sapien, ac vehicula ante erat id purus. Maecenas aliquet tempor ex in lobortis. Morbi in sodales est. Sed pellentesque ex in nulla porttitor tincidunt. Donec placerat imperdiet libero, vitae laoreet leo vestibulum non. Donec at facilisis tellus. Nam nisi ligula, varius in volutpat eu, egestas vel leo. Aliquam erat volutpat.\r\n\r\nAliquam pharetra justo quis arcu sollicitudin ullamcorper. Sed ut ex porttitor, auctor arcu quis, ultrices libero. Donec a fermentum diam. In luctus diam at sem tincidunt viverra. Aenean nec condimentum nunc. Sed hendrerit quis nisl eu gravida. Sed consequat nunc eros, sed bibendum tortor rhoncus quis. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla facilisi. Quisque urna urna, auctor eu enim vehicula, efficitur semper sapien. In non nulla eu libero laoreet rutrum ac mattis lorem. Nullam id tempor libero, nec dapibus risus. Nam vel metus tempus, imperdiet augue et, rutrum lectus. Sed dictum magna purus, id convallis eros laoreet quis.\r\n\r\nNulla auctor risus non elit hendrerit aliquam. Duis fermentum nec quam pulvinar eleifend. Etiam tempor sagittis leo in malesuada. Aliquam est velit, porttitor et eros laoreet, dignissim sagittis erat. Sed sed quam enim. Vivamus iaculis tristique arcu, et egestas ipsum sagittis in. Maecenas sit amet sagittis quam. Fusce sed nisi arcu. Aenean vitae ex quis lectus egestas hendrerit ut ac velit. Nam sit amet mauris commodo, pulvinar urna ut, molestie mi. Quisque quis congue quam, at condimentum odio. Vestibulum feugiat, magna ac congue viverra, turpis tellus pretium tellus, ac lobortis odio mauris non ex.\r\n\r\nMauris in volutpat ex, at molestie metus. Mauris est lorem, ullamcorper vitae sollicitudin et, volutpat eget dolor. Nam dui felis, ornare suscipit ipsum eget, aliquet facilisis lorem. Suspendisse tincidunt commodo mi, ut mollis lacus luctus quis. Proin accumsan varius odio et euismod. Nunc blandit, leo ac scelerisque ornare, sapien eros pellentesque arcu, a congue dui sem eu diam. Fusce odio eros, iaculis sit amet dapibus eget, fermentum id mi.\r\n\r\nFusce eget rutrum diam, ac fringilla nibh. Ut non luctus erat. Fusce pharetra, urna et tincidunt imperdiet, urna dolor convallis dolor, at scelerisque urna dolor ac magna. Sed eget sapien cursus, commodo sem vel, tristique eros. Nunc augue ligula, dignissim in venenatis quis, mollis a lacus. Nunc semper lobortis blandit. Aliquam semper ac odio a malesuada. Duis eleifend consequat commodo. Maecenas pulvinar libero at sodales gravida. Integer eget urna augue. Donec porttitor ac turpis eget viverra. Cras at arcu accumsan, ultricies mi quis, suscipit elit. Nulla quis odio consectetur, pharetra nulla eu, lacinia diam. Praesent urna enim, ornare at urna vitae, consequat consequat diam. Proin eu mollis eros. Nullam eget ipsum at metus scelerisque semper vitae quis neque. ', 'http://placehold.it/750x300', NULL, 'open', '2019-04-23 17:40:13', '2019-04-26 04:19:22', 0),
  (7, 'News #6', '\r\n\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ac elit non erat pellentesque bibendum. Pellentesque rutrum id enim in viverra. Aenean lacinia sodales dolor. Morbi leo ex, ornare vitae metus viverra, elementum gravida ex. Suspendisse potenti. Suspendisse ullamcorper, nunc non ullamcorper dictum, dolor nunc scelerisque elit, sit amet pretium libero metus ut ipsum. Aliquam sed convallis tortor. Aenean in enim eu nisi mattis posuere quis nec quam. Nunc turpis orci, pharetra in consequat sed, congue vitae turpis. Pellentesque suscipit enim orci, vulputate dictum felis euismod quis. Vivamus posuere laoreet aliquet. Duis gravida volutpat velit vitae lacinia. Vestibulum sagittis vehicula leo et auctor. Quisque ultricies mi mi, eget pretium metus euismod a.\r\n\r\nNulla at eros molestie, congue risus a, pulvinar sapien. Mauris aliquet sed metus in auctor. Maecenas tempus, magna eget mollis egestas, arcu elit iaculis orci, eget volutpat risus sem sed mi. Nunc aliquet non quam sit amet dictum. Nullam id suscipit dui. Sed condimentum vulputate justo ac elementum. Donec at est felis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer vel tristique enim. ', '\r\n\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor tortor velit. Nunc placerat velit sed justo maximus, at mollis velit faucibus. Etiam id rutrum lorem. Praesent venenatis sem id nulla placerat tempor. Quisque tincidunt, velit et congue accumsan, felis urna rhoncus sapien, ac vehicula ante erat id purus. Maecenas aliquet tempor ex in lobortis. Morbi in sodales est. Sed pellentesque ex in nulla porttitor tincidunt. Donec placerat imperdiet libero, vitae laoreet leo vestibulum non. Donec at facilisis tellus. Nam nisi ligula, varius in volutpat eu, egestas vel leo. Aliquam erat volutpat.\r\n\r\nAliquam pharetra justo quis arcu sollicitudin ullamcorper. Sed ut ex porttitor, auctor arcu quis, ultrices libero. Donec a fermentum diam. In luctus diam at sem tincidunt viverra. Aenean nec condimentum nunc. Sed hendrerit quis nisl eu gravida. Sed consequat nunc eros, sed bibendum tortor rhoncus quis. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla facilisi. Quisque urna urna, auctor eu enim vehicula, efficitur semper sapien. In non nulla eu libero laoreet rutrum ac mattis lorem. Nullam id tempor libero, nec dapibus risus. Nam vel metus tempus, imperdiet augue et, rutrum lectus. Sed dictum magna purus, id convallis eros laoreet quis.\r\n\r\nNulla auctor risus non elit hendrerit aliquam. Duis fermentum nec quam pulvinar eleifend. Etiam tempor sagittis leo in malesuada. Aliquam est velit, porttitor et eros laoreet, dignissim sagittis erat. Sed sed quam enim. Vivamus iaculis tristique arcu, et egestas ipsum sagittis in. Maecenas sit amet sagittis quam. Fusce sed nisi arcu. Aenean vitae ex quis lectus egestas hendrerit ut ac velit. Nam sit amet mauris commodo, pulvinar urna ut, molestie mi. Quisque quis congue quam, at condimentum odio. Vestibulum feugiat, magna ac congue viverra, turpis tellus pretium tellus, ac lobortis odio mauris non ex.\r\n\r\nMauris in volutpat ex, at molestie metus. Mauris est lorem, ullamcorper vitae sollicitudin et, volutpat eget dolor. Nam dui felis, ornare suscipit ipsum eget, aliquet facilisis lorem. Suspendisse tincidunt commodo mi, ut mollis lacus luctus quis. Proin accumsan varius odio et euismod. Nunc blandit, leo ac scelerisque ornare, sapien eros pellentesque arcu, a congue dui sem eu diam. Fusce odio eros, iaculis sit amet dapibus eget, fermentum id mi.\r\n\r\nFusce eget rutrum diam, ac fringilla nibh. Ut non luctus erat. Fusce pharetra, urna et tincidunt imperdiet, urna dolor convallis dolor, at scelerisque urna dolor ac magna. Sed eget sapien cursus, commodo sem vel, tristique eros. Nunc augue ligula, dignissim in venenatis quis, mollis a lacus. Nunc semper lobortis blandit. Aliquam semper ac odio a malesuada. Duis eleifend consequat commodo. Maecenas pulvinar libero at sodales gravida. Integer eget urna augue. Donec porttitor ac turpis eget viverra. Cras at arcu accumsan, ultricies mi quis, suscipit elit. Nulla quis odio consectetur, pharetra nulla eu, lacinia diam. Praesent urna enim, ornare at urna vitae, consequat consequat diam. Proin eu mollis eros. Nullam eget ipsum at metus scelerisque semper vitae quis neque. ', 'http://placehold.it/750x300', NULL, 'open', '2019-04-23 17:40:13', '2019-04-26 04:19:22', 0),
  (8, 'News #7', '\r\n\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ac elit non erat pellentesque bibendum. Pellentesque rutrum id enim in viverra. Aenean lacinia sodales dolor. Morbi leo ex, ornare vitae metus viverra, elementum gravida ex. Suspendisse potenti. Suspendisse ullamcorper, nunc non ullamcorper dictum, dolor nunc scelerisque elit, sit amet pretium libero metus ut ipsum. Aliquam sed convallis tortor. Aenean in enim eu nisi mattis posuere quis nec quam. Nunc turpis orci, pharetra in consequat sed, congue vitae turpis. Pellentesque suscipit enim orci, vulputate dictum felis euismod quis. Vivamus posuere laoreet aliquet. Duis gravida volutpat velit vitae lacinia. Vestibulum sagittis vehicula leo et auctor. Quisque ultricies mi mi, eget pretium metus euismod a.\r\n\r\nNulla at eros molestie, congue risus a, pulvinar sapien. Mauris aliquet sed metus in auctor. Maecenas tempus, magna eget mollis egestas, arcu elit iaculis orci, eget volutpat risus sem sed mi. Nunc aliquet non quam sit amet dictum. Nullam id suscipit dui. Sed condimentum vulputate justo ac elementum. Donec at est felis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer vel tristique enim. ', '\r\n\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor tortor velit. Nunc placerat velit sed justo maximus, at mollis velit faucibus. Etiam id rutrum lorem. Praesent venenatis sem id nulla placerat tempor. Quisque tincidunt, velit et congue accumsan, felis urna rhoncus sapien, ac vehicula ante erat id purus. Maecenas aliquet tempor ex in lobortis. Morbi in sodales est. Sed pellentesque ex in nulla porttitor tincidunt. Donec placerat imperdiet libero, vitae laoreet leo vestibulum non. Donec at facilisis tellus. Nam nisi ligula, varius in volutpat eu, egestas vel leo. Aliquam erat volutpat.\r\n\r\nAliquam pharetra justo quis arcu sollicitudin ullamcorper. Sed ut ex porttitor, auctor arcu quis, ultrices libero. Donec a fermentum diam. In luctus diam at sem tincidunt viverra. Aenean nec condimentum nunc. Sed hendrerit quis nisl eu gravida. Sed consequat nunc eros, sed bibendum tortor rhoncus quis. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla facilisi. Quisque urna urna, auctor eu enim vehicula, efficitur semper sapien. In non nulla eu libero laoreet rutrum ac mattis lorem. Nullam id tempor libero, nec dapibus risus. Nam vel metus tempus, imperdiet augue et, rutrum lectus. Sed dictum magna purus, id convallis eros laoreet quis.\r\n\r\nNulla auctor risus non elit hendrerit aliquam. Duis fermentum nec quam pulvinar eleifend. Etiam tempor sagittis leo in malesuada. Aliquam est velit, porttitor et eros laoreet, dignissim sagittis erat. Sed sed quam enim. Vivamus iaculis tristique arcu, et egestas ipsum sagittis in. Maecenas sit amet sagittis quam. Fusce sed nisi arcu. Aenean vitae ex quis lectus egestas hendrerit ut ac velit. Nam sit amet mauris commodo, pulvinar urna ut, molestie mi. Quisque quis congue quam, at condimentum odio. Vestibulum feugiat, magna ac congue viverra, turpis tellus pretium tellus, ac lobortis odio mauris non ex.\r\n\r\nMauris in volutpat ex, at molestie metus. Mauris est lorem, ullamcorper vitae sollicitudin et, volutpat eget dolor. Nam dui felis, ornare suscipit ipsum eget, aliquet facilisis lorem. Suspendisse tincidunt commodo mi, ut mollis lacus luctus quis. Proin accumsan varius odio et euismod. Nunc blandit, leo ac scelerisque ornare, sapien eros pellentesque arcu, a congue dui sem eu diam. Fusce odio eros, iaculis sit amet dapibus eget, fermentum id mi.\r\n\r\nFusce eget rutrum diam, ac fringilla nibh. Ut non luctus erat. Fusce pharetra, urna et tincidunt imperdiet, urna dolor convallis dolor, at scelerisque urna dolor ac magna. Sed eget sapien cursus, commodo sem vel, tristique eros. Nunc augue ligula, dignissim in venenatis quis, mollis a lacus. Nunc semper lobortis blandit. Aliquam semper ac odio a malesuada. Duis eleifend consequat commodo. Maecenas pulvinar libero at sodales gravida. Integer eget urna augue. Donec porttitor ac turpis eget viverra. Cras at arcu accumsan, ultricies mi quis, suscipit elit. Nulla quis odio consectetur, pharetra nulla eu, lacinia diam. Praesent urna enim, ornare at urna vitae, consequat consequat diam. Proin eu mollis eros. Nullam eget ipsum at metus scelerisque semper vitae quis neque. ', 'http://placehold.it/750x300', NULL, 'open', '2019-04-23 17:40:13', '2019-04-26 08:02:24', 51);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_id` (`news_id`);

--
-- Индексы таблицы `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id_entity_id_entity_type` (`user_id`,`entity_id`,`entity_type`) USING BTREE,
  ADD UNIQUE KEY `entity_id_type` (`entity_id`,`entity_type`);

--
-- Индексы таблицы `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `likes`
--
ALTER TABLE `likes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT для таблицы `news`
--
ALTER TABLE `news`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;