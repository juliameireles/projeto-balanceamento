/* o que a landing page deve fazer? 
um código php que colete o ip da máquina e o revele
*/

<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Minha Landing Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 50px;
        }
        .container {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            display: inline-block;
        }
        h1 {
            color: #333;
        }
        p {
            font-size: 18px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Bem-vindo à minha Landing Page</h1>
        <p>O seu IP é: 
            <strong>
                <?php echo $_SERVER['REMOTE_ADDR']; ?>
            </strong>
        </p>
    </div>
</body>
</html>
