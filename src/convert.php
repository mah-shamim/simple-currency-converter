<?php
require '../include/db.php';

$amount = $_POST['amount'];
$fromCurrency = $_POST['from_currency'];
$toCurrency = $_POST['to_currency'];

// Fetch the exchange rate from the database
$stmt = $pdo->prepare("SELECT rate FROM exchange_rates WHERE currency = :currency");
$stmt->execute(['currency' => $fromCurrency]);
$fromRate = $stmt->fetchColumn();

$stmt->execute(['currency' => $toCurrency]);
$toRate = $stmt->fetchColumn();

if ($fromRate && $toRate) {
    // Convert the amount
    $convertedAmount = ($amount / $fromRate) * $toRate;
    echo json_encode(['status' => 'success', 'converted_amount' => number_format($convertedAmount, 2)]);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Conversion failed.']);
}
?>