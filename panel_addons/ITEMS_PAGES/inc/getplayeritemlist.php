<?php

if(empty($_SERVER['HTTP_X_REQUESTED_WITH']) || !strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') 
{
	header("Location: ../index.php?error=".urlencode("Direct access not allowed."));
	die();
}

//Include Config
include "config.php";

// Include database class
include 'database.class.php';

// Instantiate database.
$database = new Database();

$database->query('SELECT itemlog.*, items.*, items_quality.*, COUNT(itemlog.`index`) AS found FROM itemlog INNER JOIN items ON itemlog.`index` = items.`index` INNER JOIN items_quality ON itemlog.`quality` = items_quality.`quality_type` WHERE `auth` = :id GROUP BY itemlog.`index`, itemlog.`quality` ORDER BY found DESC');
$database->bind(':id', $_GET['id']);
$log = $database->resultset();

?>

<?php foreach ($log as $log): ?>
<div class="col-sm-3 getitem">
	<input type="hidden" value="<?php echo $log['index']; ?>"/>
	<div class="row">
		<div style="background-color:<?php echo $log['quality_color']; ?>;border-radius:4px;border:2px solid #222222;margin:5px">
			<div class="pull-left">
				<span class="fa-stack fa-lg fa-2x">
					<i class="fa fa-circle-thin fa-stack-2x"></i>
					<i style='font-size:18px;color:#ecf0f1' class='fa-stack-1x'><?php echo $log['found']; ?></i>
				</span>
			</div>
			<div style="text-align:right">
				<img width="80" height="80" src="<?php echo $log['image']; ?>">
			</div>
		</div>
	</div>
</div>
<?php endforeach ?>