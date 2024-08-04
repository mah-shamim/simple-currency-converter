<?php
require '../include/db.php';

// Fetch exchange rates from the external API
$apiUrl = "https://api.exchangerate-api.com/v4/latest/USD"; // Replace with your API endpoint

$response = file_get_contents($apiUrl);
$data = json_decode($response, true);

if ($data) {
    // Clear existing rates
    $stmt = $pdo->prepare("TRUNCATE TABLE exchange_rates");
    $stmt->execute();

    // Insert new rates
    $stmt = $pdo->prepare("INSERT INTO exchange_rates (currency, rate) VALUES (:currency, :rate)");
    foreach ($data['rates'] as $currency => $rate) {
        $stmt->execute(['currency' => $currency, 'rate' => $rate]);
    }

    echo json_encode(['status' => 'success', 'message' => 'Exchange rates updated successfully.']);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Failed to fetch exchange rates.']);
}
?>
