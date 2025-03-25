<?php

header("Content-type: text/html; charset=UTF-8");
?>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Minha Landing Page</title>
    <style>

    /* Fundo animado que muda de cor*/

        @keyframes bgAnimation {
                0% { background: linear-gradient(45deg, #ff4d4d, #ffcc00); }
                25% { background: linear-gradient(45deg, #ffcc00, #4dd2ff); }
                50% { background: linear-gradient(45deg, #4dd2ff, #8cff66); }
                75% { background: linear-gradient(45deg, #8cff66, #ff4d4d); }
                100% { background: linear-gradient(45deg, #ff4d4d, #ffcc00); }
            }



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
        <h1>Bem-vindo! Este é um teste de balanceamento de carga </h1>
        <p>O seu IP é: 
            <strong>
                <?php echo gethostbyname(gethostname()); ?>
            </strong>
        </p>
    </div>
</body>
</html>
