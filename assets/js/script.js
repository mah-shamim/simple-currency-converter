$(document).ready(function() {
    // Fetch exchange rates and populate the select options
    $.ajax({
        url: 'src/fetch-rates.php',
        method: 'GET',
        dataType: 'json',
        success: function(data) {
            if (data.status === 'success') {
                populateCurrencyOptions();
            }
        }
    });

    function populateCurrencyOptions() {
        $.ajax({
            url: 'src/get-currencies.php',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                if (data.status === 'success') {
                    var options = '';
                    console.log(data.currencies)
                    $.each(data.currencies, function(index, currency) {
                        options += '<option value="' + currency.code + '">' + currency.name + '</option>';
                    });
                    $('#from_currency, #to_currency').html(options);
                }
            }
        });
    }

    // Handle form submission
    $('#currency-form').on('submit', function(e) {
        e.preventDefault();
        var amount = $('#amount').val();
        var fromCurrency = $('#from_currency').val();
        var toCurrency = $('#to_currency').val();

        $.ajax({
            url: 'src/convert.php',
            method: 'POST',
            data: {
                amount: amount,
                from_currency: fromCurrency,
                to_currency: toCurrency
            },
            dataType: 'json',
            success: function(data) {
                if (data.status === 'success') {
                    $('#result').html('Converted Amount: ' + data.converted_amount).show();
                } else {
                    $('#result').html(data.message).show();
                }
            }
        });
    });
});
