<?php
/**
 * Custom WordPress configurations on "wp-config.php" file.
 *
 * This file has the following configurations: MySQL settings, Table Prefix, Secret Keys, WordPress Language, ABSPATH and more.
 * For more information visit {@link https://codex.wordpress.org/Editing_wp-config.php Editing wp-config.php} Codex page.
 * Created using {@link http://generatewp.com/wp-config/ wp-config.php File Generator} on GenerateWP.com.
 *
 * @package WordPress
 * @generator GenerateWP.com
 */


/* MySQL settings */
define( 'DB_NAME',     'salmedina_db' );
define( 'DB_USER',     'salmedina_user' );
define( 'DB_PASSWORD', 'salmedina_pass' );
define( 'DB_HOST',     'localhost' );
define( 'DB_CHARSET',  'utf8mb4' );


/* MySQL database table prefix. */
$table_prefix = 'wp_';


/* Authentication Unique Keys and Salts. */
/* https://api.wordpress.org/secret-key/1.1/salt/ */
define('AUTH_KEY',         '7D6K%a#}kKEfcYGEqV6:X7?&-,6;VZ@z )ayX0wzQ|PVaK_.pLocc0WM1($K1`Mq');
define('SECURE_AUTH_KEY',  '@,WV^+*e zNV~k};Ja%,GF5*)!fQ%>#ReTa)kbA+)&?dhnnnE9dZOrNM6yyD#=0H');
define('LOGGED_IN_KEY',    'U$>-.MZ=G4-<-A`Zw,H[K+hBDE V;{gx0-+F5+OA@CCI62rG5^t!NV|&?%yu,GR(');
define('NONCE_KEY',        ',@t/HW+wR?P+X,+[1%fzKdZJC3Nnq`lcd/qDD8#?@3&3UC7T|v/^4S%3|Zz}InRo');
define('AUTH_SALT',        '%tbL(X_+~1Q`7Qu`Ugd#y1U2JF2Zz//MY8L[{~]9exY$%Ncz(].HD}xYSR`bi^Y0');
define('SECURE_AUTH_SALT', 'jcKGN%GU|7.;R-j:x--RS]m1kA+?Mifa;JJBe!2/%$84VL0#j+n=tz/|`p9)c_a9');
define('LOGGED_IN_SALT',   't<7 ]Wl3t,^2(nbvw%ug%ntdjzcEw|kG0h@SGA>Z/WxP]+5?A| z8@l>z:D%Fa#/');
define('NONCE_SALT',       '9o-U^l6L9|mG)72.fi|qDs(Civ]{ B!D-n5izk,z;QgR2.|#**TITHG:T}?6@|9k');


/* Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/* Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');