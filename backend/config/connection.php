<?php
    // TAG : 10022021 : BATCH #1

    $SERVER = "localhost";
    $USERDB = "root";
    $KEYDB = "!!&21adi";
    $DBNAME = "db_invoice";

    $_AUTH = mysqli_connect($SERVER, $USERDB, $KEYDB, $DBNAME);

    if($_AUTH) {
        // $response["message"] = "Koneksi berhasil terhubung";
        // $response["status"] = true;
        // $response["code"] = 200;
    } else {
        // $response["message"] = "Koneksi gagal terhubung";
        // $response["status"] = false;
        // $response["code"] = 404;
    }

    // echo json_encode($response);
?>